import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Stream<User?> isLogin() {
    return firebaseAuth.authStateChanges();
  }

  Future<void> logout() async {
    print("**************** logout *********************");
    await firebaseAuth.signOut();
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    print("${credential.accessToken} ....");

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(
      credential,
    );
  }
}
