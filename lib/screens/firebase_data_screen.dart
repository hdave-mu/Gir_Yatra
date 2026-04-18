// lib/screens/firebase_data_screen.dart
// Live Firestore browser — shows collections & doc counts, drill into docs.

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../theme/app_theme.dart';

const _collections = <_Collection>[
  _Collection('safari_zones', 'Safari Zones', Icons.forest),
  _Collection('safari_timings', 'Safari Timings', Icons.schedule),
  _Collection('entry_fees', 'Entry Fees', Icons.confirmation_number_outlined),
  _Collection('hotels', 'Hotels', Icons.hotel),
  _Collection('local_dishes', 'Local Dishes', Icons.restaurant),
  _Collection('culture_traditions', 'Culture', Icons.theater_comedy),
  _Collection('nearby_places', 'Nearby Places', Icons.place),
  _Collection('transport_options', 'Transport', Icons.directions_bus),
  _Collection('nearby_stations', 'Stations', Icons.train),
  _Collection('emergency_contacts', 'Emergency', Icons.emergency),
  _Collection('first_aid_tips', 'First Aid', Icons.medical_services),
  _Collection('quick_facts', 'Quick Facts', Icons.bolt),
  _Collection('wildlife_facts', 'Wildlife', Icons.pets),
  _Collection('users', 'Users', Icons.people),
];

class FirebaseDataScreen extends StatelessWidget {
  const FirebaseDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.beige,
      appBar: AppBar(title: const Text('Firebase Data')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _collections.length,
        itemBuilder: (_, i) => _CollectionTile(col: _collections[i]),
      ),
    );
  }
}

class _CollectionTile extends StatelessWidget {
  final _Collection col;
  const _CollectionTile({required this.col});

  @override
  Widget build(BuildContext context) {
    final stream =
        FirebaseFirestore.instance.collection(col.path).snapshots();
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppTheme.softBorder),
      ),
      child: StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (_, snap) {
          final count = snap.data?.docs.length;
          final loading = snap.connectionState == ConnectionState.waiting;
          return ListTile(
            leading: Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(col.icon,
                  color: AppTheme.primaryGreen, size: 22),
            ),
            title: Text(
              col.label,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: AppTheme.textDark,
              ),
            ),
            subtitle: Text(
              col.path,
              style: TextStyle(
                fontSize: 11,
                color: AppTheme.textDark.withOpacity(0.55),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (loading)
                  const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${count ?? 0}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                  ),
                const SizedBox(width: 4),
                const Icon(Icons.chevron_right, size: 20),
              ],
            ),
            onTap: (count == null || count == 0)
                ? null
                : () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => _CollectionViewer(col: col),
                      ),
                    ),
          );
        },
      ),
    );
  }
}

class _CollectionViewer extends StatelessWidget {
  final _Collection col;
  const _CollectionViewer({required this.col});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.beige,
      appBar: AppBar(title: Text(col.label)),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(col.path)
            .limit(100)
            .snapshots(),
        builder: (_, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }
          final docs = snap.data?.docs ?? [];
          if (docs.isEmpty) {
            return const Center(child: Text('No documents'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: docs.length,
            itemBuilder: (_, i) {
              final d = docs[i];
              final data = d.data() as Map<String, dynamic>;
              final title = (data['name'] ??
                      data['title'] ??
                      data['label'] ??
                      data['session'] ??
                      data['mode'] ??
                      data['situation'] ??
                      data['animal'] ??
                      data['category'] ??
                      d.id)
                  .toString();
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: AppTheme.softBorder),
                ),
                child: ExpansionTile(
                  title: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textDark,
                    ),
                  ),
                  subtitle: Text(
                    d.id,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppTheme.textDark.withOpacity(0.5),
                    ),
                  ),
                  childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  children: data.entries
                      .map((e) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 110,
                                  child: Text(
                                    e.key,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: AppTheme.primaryGreen
                                          .withOpacity(0.8),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    _fmt(e.value),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.textDark,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _fmt(dynamic v) {
    if (v == null) return '—';
    if (v is Timestamp) return v.toDate().toString();
    if (v is List) return v.join(', ');
    return v.toString();
  }
}

class _Collection {
  final String path;
  final String label;
  final IconData icon;
  const _Collection(this.path, this.label, this.icon);
}
