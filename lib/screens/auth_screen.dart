// lib/screens/auth_screen.dart
// Auth page — Login / Register with Gir Yatra forest-green + amber theme.

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;
  final _loginFormKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();

  final _loginEmail = TextEditingController();
  final _loginPass = TextEditingController();

  final _signupName = TextEditingController();
  final _signupEmail = TextEditingController();
  final _signupPass = TextEditingController();
  final _signupConfirm = TextEditingController();

  bool _obscureLogin = true;
  bool _obscureSignup = true;
  bool _obscureConfirm = true;
  bool _remember = true;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    _loginEmail.dispose();
    _loginPass.dispose();
    _signupName.dispose();
    _signupEmail.dispose();
    _signupPass.dispose();
    _signupConfirm.dispose();
    super.dispose();
  }

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email required';
    final re = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!re.hasMatch(v.trim())) return 'Enter valid email';
    return null;
  }

  String? _validatePass(String? v) {
    if (v == null || v.isEmpty) return 'Password required';
    if (v.length < 6) return 'Min 6 characters';
    return null;
  }

  Future<void> _submitLogin() async {
    if (!_loginFormKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() => _loading = false);
    _goHome();
  }

  Future<void> _submitSignup() async {
    if (!_signupFormKey.currentState!.validate()) return;
    if (_signupPass.text != _signupConfirm.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() => _loading = false);
    _goHome();
  }

  void _goHome() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const HomeScreen(),
        transitionsBuilder: (_, a, __, child) =>
            FadeTransition(opacity: a, child: child),
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  void _skip() => _goHome();

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1B5E20),
              Color(0xFF2E7D32),
              Color(0xFF4A3728),
            ],
            stops: [0.0, 0.45, 1.0],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: media.viewInsets.bottom + 24,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const SizedBox(height: 18),
                      _buildHeader(),
                      const SizedBox(height: 18),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: _buildCard(),
                      ),
                      const Spacer(),
                      _buildFooter(),
                      const SizedBox(height: 14),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.25), width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 24,
                spreadRadius: 2,
              ),
              BoxShadow(
                color: AppTheme.goldenAmber.withOpacity(0.35),
                blurRadius: 18,
              ),
            ],
          ),
          padding: const EdgeInsets.all(6),
          child: ClipOval(
            child: Image.asset(
              'gir_yatra_icon.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Gir Yatra',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            shadows: [
              Shadow(offset: Offset(0, 2), blurRadius: 8, color: Colors.black38),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'ગિર યાત્રા · Explore Sasan Gir',
          style: TextStyle(
            color: Colors.white.withOpacity(0.75),
            fontSize: 12,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.warmWhite,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppTheme.softBorder, width: 0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildTabBar(),
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            child: SizedBox(
              height: _tab.index == 0 ? 360 : 500,
              child: TabBarView(
                controller: _tab,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildLoginTab(),
                  _buildSignupTab(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.beige,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TabBar(
        controller: _tab,
        onTap: (_) => setState(() {}),
        indicator: BoxDecoration(
          color: AppTheme.primaryGreen,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryGreen.withOpacity(0.25),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.all(4),
        labelColor: Colors.white,
        unselectedLabelColor: AppTheme.primaryBrown,
        labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        dividerColor: Colors.transparent,
        splashBorderRadius: BorderRadius.circular(12),
        tabs: const [
          Tab(text: 'Login'),
          Tab(text: 'Register'),
        ],
      ),
    );
  }

  Widget _buildLoginTab() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 6, 18, 18),
      child: Form(
        key: _loginFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _field(
              controller: _loginEmail,
              label: 'Email',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
            ),
            const SizedBox(height: 12),
            _field(
              controller: _loginPass,
              label: 'Password',
              icon: Icons.lock_outline,
              obscure: _obscureLogin,
              validator: _validatePass,
              suffix: IconButton(
                icon: Icon(
                  _obscureLogin ? Icons.visibility_off : Icons.visibility,
                  size: 20,
                ),
                onPressed: () =>
                    setState(() => _obscureLogin = !_obscureLogin),
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                SizedBox(
                  height: 26,
                  width: 26,
                  child: Checkbox(
                    value: _remember,
                    onChanged: (v) => setState(() => _remember = v ?? false),
                    activeColor: AppTheme.primaryGreen,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                const SizedBox(width: 6),
                const Text('Remember me',
                    style: TextStyle(fontSize: 13, color: AppTheme.textDark)),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Reset link sent to email')),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppTheme.primaryGreen,
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text('Forgot?',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _primaryButton(
              label: 'Login',
              onPressed: _loading ? null : _submitLogin,
            ),
            const SizedBox(height: 10),
            _dividerOr(),
            const SizedBox(height: 10),
            _socialRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildSignupTab() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 6, 18, 18),
      child: Form(
        key: _signupFormKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _field(
                controller: _signupName,
                label: 'Full name',
                icon: Icons.person_outline,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Name required' : null,
              ),
              const SizedBox(height: 12),
              _field(
                controller: _signupEmail,
                label: 'Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
              ),
              const SizedBox(height: 12),
              _field(
                controller: _signupPass,
                label: 'Password',
                icon: Icons.lock_outline,
                obscure: _obscureSignup,
                validator: _validatePass,
                suffix: IconButton(
                  icon: Icon(
                    _obscureSignup ? Icons.visibility_off : Icons.visibility,
                    size: 20,
                  ),
                  onPressed: () =>
                      setState(() => _obscureSignup = !_obscureSignup),
                ),
              ),
              const SizedBox(height: 12),
              _field(
                controller: _signupConfirm,
                label: 'Confirm password',
                icon: Icons.lock_outline,
                obscure: _obscureConfirm,
                validator: _validatePass,
                suffix: IconButton(
                  icon: Icon(
                    _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                    size: 20,
                  ),
                  onPressed: () =>
                      setState(() => _obscureConfirm = !_obscureConfirm),
                ),
              ),
              const SizedBox(height: 18),
              _primaryButton(
                label: 'Create account',
                onPressed: _loading ? null : _submitSignup,
              ),
              const SizedBox(height: 10),
              _dividerOr(),
              const SizedBox(height: 10),
              _socialRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscure = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    Widget? suffix,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(color: AppTheme.textDark, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20, color: AppTheme.primaryBrown),
        suffixIcon: suffix,
        labelStyle: const TextStyle(color: AppTheme.lightBrown, fontSize: 13),
      ),
    );
  }

  Widget _primaryButton({required String label, VoidCallback? onPressed}) {
    return SizedBox(
      height: 50,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppTheme.primaryGreen,
          disabledBackgroundColor: AppTheme.primaryGreen.withOpacity(0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 2,
        ),
        child: _loading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  color: Colors.white,
                ),
              )
            : Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
      ),
    );
  }

  Widget _dividerOr() {
    return const Row(
      children: [
        Expanded(child: Divider(color: AppTheme.softBorder)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'or continue with',
            style: TextStyle(
              fontSize: 11,
              color: AppTheme.lightBrown,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Expanded(child: Divider(color: AppTheme.softBorder)),
      ],
    );
  }

  Widget _socialRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialBtn(Icons.g_mobiledata, 'Google'),
        const SizedBox(width: 12),
        _socialBtn(Icons.phone_android, 'Phone'),
        const SizedBox(width: 12),
        _socialBtn(Icons.apple, 'Apple'),
      ],
    );
  }

  Widget _socialBtn(IconData icon, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$tooltip sign-in coming soon')),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 56,
          height: 44,
          decoration: BoxDecoration(
            color: AppTheme.beige,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.softBorder),
          ),
          child: Icon(icon, color: AppTheme.primaryBrown, size: 24),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        TextButton(
          onPressed: _skip,
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          ),
          child: const Text(
            'Skip · Continue as guest →',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Sasan Gir · Gujarat · India',
          style: TextStyle(
            color: Colors.white.withOpacity(0.55),
            fontSize: 11,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}
