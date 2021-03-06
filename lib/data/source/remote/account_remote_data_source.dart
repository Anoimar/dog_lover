import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doglover/api/dog_lover_api_service.dart';
import 'package:doglover/data/source/account_data_source.dart';
import 'package:doglover/data/source/firebase_results.dart';
import 'package:doglover/data/source/firebase_store_keys.dart';
import 'package:doglover/models/account.dart';
import 'package:doglover/models/account_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AccountsRemoteDataSource implements AccountDataSource {
  AccountsRemoteDataSource(this.dogLoverApiService);

  final DogLoverApiService dogLoverApiService;
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;

  @override
  bool isLogged() => throw ('Not implemented in remote');

  @override
  void logOff() => throw ('Not implemented in remote');

  @override
  Future<LoginResult> logIn(String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
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

  @override
  Future<SignUpResult> signUp(
      String email, String password, String name) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((createResult) async {
        UserUpdateInfo info = UserUpdateInfo();
        info.displayName = name;
        await createResult.user.updateProfile(info);
        _firestore.collection('user').add({
          FirebaseStoreKeys.accountEmail: email,
          FirebaseStoreKeys.accountName: name,
          FirebaseStoreKeys.accountDogs: ''
        });
      });
      return Future.value(SignUpResult.success);
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'ERROR_WEAK_PASSWORD') {
        return Future.value(SignUpResult.password_insufficient);
      }
      if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        return Future.value(SignUpResult.user_exist);
      }
    } catch (e) {
      print(e);
    }
    return Future.value(SignUpResult.failure);
  }

  @override
  Future<ResetPasswordResult> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_USER_NOT_FOUND') {
        return Future.value(ResetPasswordResult.email_not_found);
      }
    } catch (e) {
      return Future.value(ResetPasswordResult.failure);
    }
    return Future.value(ResetPasswordResult.success);
  }

  @override
  Future<Account> getAccount() async {
    FirebaseUser user = await _auth.currentUser();
    return Future.value(Account(user.displayName, user.email, ''));
  }

  @override
  Future<bool> uploadUserAvatar(File userAvatar) async {
    final user = await _auth.currentUser();
    try {
      return dogLoverApiService.uploadAvatar(user.uid, userAvatar);
    } catch (e) {
      return Future.value(false);
    }
  }

  @override
  Future<AccountData> getAccountData() async {
    final user = await _auth.currentUser();
    return dogLoverApiService.getUserData(user.uid);
  }
}
