import 'package:doglover/data/source/account_data_source.dart';
import 'package:doglover/data/source/login_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AccountsRemoteDataSource implements AccountDataSource {
  AccountsRemoteDataSource();

  final _auth = FirebaseAuth.instance;

  @override
  bool isLogged() {
    throw ('Not implemented in remote');
  }

  @override
  Future<LoginResult> logIn(String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(result);
      if (result != null) {
        return Future.value(LoginResult.success);
      }
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_USER_NOT_FOUND') {
        return Future.value(LoginResult.user_not_found);
      }
      if (e.code == 'ERROR_WRONG_PASSWORD') {
        return Future.value(LoginResult.wrong_password);
      }
    } catch (e) {}
    return Future.value(LoginResult.failure);
  }
}
