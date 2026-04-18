// lib/services/auth_service.dart
// Firebase Auth + Firestore user profile service

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  CollectionReference<Map<String, dynamic>> get _users =>
      _db.collection('users');

  DocumentReference<Map<String, dynamic>> userDoc(String uid) =>
      _users.doc(uid);

  Stream<DocumentSnapshot<Map<String, dynamic>>> userDocStream(String uid) =>
      _users.doc(uid).snapshots();

  Future<UserCredential> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    await cred.user?.updateDisplayName(name.trim());

    await _users.doc(cred.user!.uid).set({
      'uid': cred.user!.uid,
      'name': name.trim(),
      'email': email.trim(),
      'photoUrl': null,
      'createdAt': FieldValue.serverTimestamp(),
      'lastLoginAt': FieldValue.serverTimestamp(),
      'provider': 'password',
    });
    return cred;
  }

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    await _users.doc(cred.user!.uid).set({
      'lastLoginAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
    return cred;
  }

  Future<void> signOut() => _auth.signOut();

  Future<void> updateProfile({
    required String uid,
    String? name,
    String? phone,
    String? city,
  }) async {
    final data = <String, dynamic>{
      'updatedAt': FieldValue.serverTimestamp(),
    };
    if (name != null) data['name'] = name.trim();
    if (phone != null) data['phone'] = phone.trim();
    if (city != null) data['city'] = city.trim();
    await _users.doc(uid).set(data, SetOptions(merge: true));
    if (name != null) {
      await _auth.currentUser?.updateDisplayName(name.trim());
    }
  }

  Future<void> resetPassword(String email) =>
      _auth.sendPasswordResetEmail(email: email.trim());
}
