import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mela/models/user.dart';

class AuthService {
  auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<auth.User?> isLogin() {
    return firebaseAuth.authStateChanges();
  }

  Future<User> isClient(String uid) async {
    final user = await db.collection("users").doc(uid).get();
    return User.fromJson(user.data());
  }

  Future<void> logout() async {
    print("**************** logout *********************");
    await firebaseAuth.signOut();
  }

  Future<auth.UserCredential> loginUser(
      {required String phone, required String password}) async {
    print(">>>>>> $password");
    var user = await firebaseAuth.signInWithEmailAndPassword(
        email: phone + "@mela.com", password: password);
    return user;
  }

  Future<auth.UserCredential> registerUser({
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
        "role": "client"
      });
    }
    return user;
  }

  Future<auth.UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = auth.GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    print("${credential.accessToken} ....");

    // Once signed in, return the UserCredential
    return await auth.FirebaseAuth.instance.signInWithCredential(
      credential,
    );
  }
}
