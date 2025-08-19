import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:invoice_app/core/auth/model/auth_models.dart';
// Import the user model

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Stream to listen for authentication state changes (login/logout).
  Stream<AuthUser?> get user {
    return _firebaseAuth.authStateChanges().map((User? user) {
      if (user != null) {
        return AuthUser.fromFirebaseUser(user);
      }
      return null;
    });
  }

  // Sign in with email and password.
  Future<AuthUser?> signInWithEmail(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return AuthUser.fromFirebaseUser(userCredential.user);
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase errors (e.g., 'user-not-found', 'wrong-password').
      print('Sign-in failed: $e');
      return null;
    }
  }

  // Sign up with email and password.
  Future<AuthUser?> signUpWithEmail(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return AuthUser.fromFirebaseUser(userCredential.user);
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase errors (e.g., 'email-already-in-use', 'weak-password').
      print('Sign-up failed: $e');
      return null;
    }
  }

  // Sign in with Google.
  Future<AuthUser?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User cancelled the sign-in flow.
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);
      return AuthUser.fromFirebaseUser(userCredential.user);
    } on FirebaseAuthException catch (e) {
      print('Google sign-in failed: $e');
      return null;
    }
  }

  // Sign out the current user.
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut(); // Sign out from Google if they used it
      await _firebaseAuth.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
