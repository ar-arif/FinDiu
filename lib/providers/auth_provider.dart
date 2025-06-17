import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';
import '../services/firestore_service.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirestoreService _firestoreService = FirestoreService();

  User? _user;
  UserModel? _userModel;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  UserModel? get userModel => _userModel;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  void _onAuthStateChanged(User? user) async {
    _user = user;
    if (user != null) {
      await _loadUserModel();
    } else {
      _userModel = null;
    }
    notifyListeners();
  }

  Future<void> _loadUserModel() async {
    if (_user == null) return;
    
    try {
      _userModel = await _firestoreService.getUser(_user!.uid);
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      _error = _getAuthErrorMessage(e.code);
      return false;
    } catch (e) {
      _error = 'An unexpected error occurred';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String studentId,
    required String university,
    required String program,
    required String year,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        final userModel = UserModel(
          id: credential.user!.uid,
          name: name,
          email: email,
          studentId: studentId,
          university: university,
          program: program,
          year: year,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        await _firestoreService.createUser(userModel);
        await credential.user!.updateDisplayName(name);
      }

      return true;
    } on FirebaseAuthException catch (e) {
      _error = _getAuthErrorMessage(e.code);
      return false;
    } catch (e) {
      _error = 'An unexpected error occurred';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return false;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      
      if (userCredential.user != null) {
        // Check if user exists in Firestore
        final existingUser = await _firestoreService.getUser(userCredential.user!.uid);
        
        if (existingUser == null) {
          // Create new user profile
          final userModel = UserModel(
            id: userCredential.user!.uid,
            name: userCredential.user!.displayName ?? '',
            email: userCredential.user!.email ?? '',
            studentId: '',
            university: '',
            program: '',
            year: '',
            photoUrl: userCredential.user!.photoURL,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
          
          await _firestoreService.createUser(userModel);
        }
      }

      return true;
    } catch (e) {
      _error = 'Google sign-in failed';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      _error = 'Sign out failed';
      notifyListeners();
    }
  }

  Future<bool> updateProfile(UserModel updatedUser) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _firestoreService.updateUser(updatedUser);
      _userModel = updatedUser;
      
      return true;
    } catch (e) {
      _error = 'Failed to update profile';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found with this email address';
      case 'wrong-password':
        return 'Incorrect password';
      case 'email-already-in-use':
        return 'An account already exists with this email';
      case 'weak-password':
        return 'Password is too weak';
      case 'invalid-email':
        return 'Invalid email address';
      default:
        return 'Authentication failed';
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}