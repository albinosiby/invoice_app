class AuthUser {
  final String uid;
  final String? email;
  final String? displayName;

  AuthUser({required this.uid, this.email, this.displayName});

  // A factory constructor to create an AuthUser from a Firebase User object.
  // This is a common pattern to separate your app's model from a third-party library's model.
  factory AuthUser.fromFirebaseUser(dynamic user) {
    if (user == null) {
      throw Exception('Firebase user is null');
    }
    return AuthUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
    );
  }
}
