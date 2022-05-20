import 'package:mela_service/mela_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mela/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance;

  Stream<auth.User?> isLogin() {
    print("is Loaggin");
    return firebaseAuth.authStateChanges();
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
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString("mela-token", await user.user!.getIdToken());
    return user;
  }

  Future<User> registerUser(
      {required String phone,
      required String password,
      required String name,
      required List<String> roles}) async {
    final newUser = await createUser({
      "phone": phone,
      "name": name,
      "password": password,
      "roles": roles,
    });
    return User.fromJson(newUser.data);
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

  Future<User?> me() async {
    var uid = firebaseAuth.currentUser!.uid;
    print(uid);
    var result = await getUser(uid: uid);
    final data = result.data!['user'];
    print(data);
    return User.fromJson(data);
  }
}
