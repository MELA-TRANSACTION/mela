import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<User?> isLogin() {
    return firebaseAuth.authStateChanges();
  }

  Future<void> logout() async {
    print("**************** logout *********************");
    await firebaseAuth.signOut();
  }

  Future<UserCredential> loginUser(
      {required String phone, required String password}) async {
    var user = await firebaseAuth.signInWithEmailAndPassword(
        email: phone + "@mela.com", password: password);
    return user;
  }

  Future<UserCredential> registerUser({
    required String phone,
    required String password,
    required String name,
  }) async {
    print(phone);
    var user = await firebaseAuth.createUserWithEmailAndPassword(
        email: phone + "@mela.com", password: password);

    if (user.user != null) {
      await db.collection("users").doc(user.user!.uid).set({
        "uid": user.user!.uid,
        "name": name,
        "phone": phone,
      });
    }
    return user;
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
