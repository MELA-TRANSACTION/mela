import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mela/models/auth_error.dart';
import 'package:mela_service/mela_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:mela/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance;

  Stream<auth.User?> isLogin() {
    if (kDebugMode) {
      print("is Loaggin");
    }
    return firebaseAuth.authStateChanges();
  }

  Future<void> logout() async {
    if (kDebugMode) {
      print("**************** logout *********************");
    }
    await firebaseAuth.signOut();
  }

  Future<Either<AuthError, auth.User>> loginUser(
      {required String phone, required String password}) async {
    try {
      var user = await firebaseAuth.signInWithEmailAndPassword(
          email: phone + "@mela.com", password: password);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = await user.user!.getIdToken();
      if (kDebugMode) {
        print(token);
      }
      await prefs.setString("mela-token", token);
      return Right(user.user!);
    } on auth.FirebaseAuthException catch (ex) {
      return Left(messageHandler(ex.code));
    } on PlatformException catch (ex) {
      return Left(
          AuthError(code: ex.code, message: ex.message ?? "Erreur inconnue"));
    }
  }

  Future<Either<AuthError, User>> registerUser({
    required String phone,
    required String password,
    required String name,
    required List<String> roles,
  }) async {
    try {
      final newUser = await createUser({
        "phone": phone,
        "name": name,
        "password": password,
        "roles": roles,
      });
      return Right(User.fromJson(newUser.data!['createUser']));
    } catch (ex) {
      return Left(AuthError(message: ex.toString(), code: "Duplicate"));
    }
  }

  Future<User?> me() async {
    var uid = firebaseAuth.currentUser!.uid;
    if (kDebugMode) {
      print(uid);
    }
    var result = await getUser(uid: uid);
    print(result);
    final data = result.data!['user'];
    //print(data);
    return User.fromJson(data);
  }

  AuthError messageHandler(String code) {
    if (kDebugMode) {
      print(code);
    }
    AuthError authError;
    switch (code) {
      case "user-not-found":
        authError = AuthError(
          code: "user-not-found",
          message: "Erreur, ce compte n'existe pas.",
        );
        if (kDebugMode) {
          print(authError.message);
        }
        break;
      case "ERROR_WEAK_PASSWORD":
        authError = AuthError(
          code: "ERROR_WEAK_PASSWORD",
          message: "Your password is too weak",
        );

        if (kDebugMode) {
          print(authError.message);
        }

        break;
      case "ERROR_INVALID_EMAIL":
        authError = AuthError(
          code: "ERROR_INVALID_EMAIL",
          message: "Your phone is invalid",
        );
        if (kDebugMode) {
          print(authError.message);
        }
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        authError = AuthError(
          code: "ERROR_EMAIL_ALREADY_IN_USE",
          message: "phone is already in use on different account",
        );
        if (kDebugMode) {
          print(authError.message);
        }
        break;
      case "wrong-password":
        authError = AuthError(
          code: "ERROR_INVALID_CREDENTIAL",
          message: "Mot de passe incorrecte",
        );
        if (kDebugMode) {
          print(authError.message);
        }
        break;

      default:
        authError = AuthError(
          code: "",
          message: "An undefined Error happened.",
        );
      //errorMessage = "An undefined Error happened.";
    }
    return authError;
  }
}
