import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:majootestcase/common/widget/alert_dialog.dart';
import 'package:majootestcase/main.dart';
import 'package:majootestcase/models/user.dart';
import 'package:majootestcase/utils/sqlite.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_bloc_state.dart';

class AuthBlocCubit extends Cubit<AuthBlocState> {
  AuthBlocCubit() : super(AuthBlocInitialState());

  void fetchHistoryLogin() async {
    emit(AuthBlocInitialState());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isLoggedIn = sharedPreferences.getBool("is_logged_in");
    if (isLoggedIn == null) {
      emit(AuthBlocLoginState());
    } else {
      if (isLoggedIn) {
        emit(AuthBlocLoggedInState());
      } else {
        emit(AuthBlocLoginState());
      }
    }
  }

  ///Ganti state auth ke register
  ///@author nur syahfei
  void goToRegister() {
    emit(AuthBlocRegisterState());
  }

  ///ganti state auth ke login
  ///@author nur syahfei
  void goToLogin() {
    emit(AuthBlocLoginState());
  }

  ///Digunakan untuk melakukan register akun baru
  ///@author nur syahfei
  ///@param Srting _email:  email user
  ///@param Srting  _password:  password user
  ///@param Srting  _username:  username  user
  void register(String _email, String _password, String _username, {bool valid}) async {
    if (_email == null || _password == null) {
      await _showAlert(title: "Login Gagal", content: "Form tidak boleh kosong, mohon cek kembali data yang anda inputkan", isError: true);
      return;
    }

    if (!valid) {
      await _showAlert(title: "Login Gagal", content: "Masukkan e-mail yang valid", isError: true);
      return;
    }

    final user = await DBLite.i.insert(User(email: _email, password: _password, userName: _username));
    if (user != null) {
      String data = jsonEncode(user.toJson());

      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("user_value", data);

      await sharedPreferences.setBool("is_logged_in", true);
      await _showAlert(title: "Register Berhasil", content: "", isError: false);

      sharedPreferences.setString("user_value", data);
      emit(AuthBlocLoggedInState());
    } else {
      await _showAlert(title: "Register Gagal", content: "", isError: true);
      emit(AuthBlocLoginState());
    }
  }

  ///Digunakan login ke aplikasi
  ///@author nur syahfei
  ///@param Srting _email:  email user
  ///@param Srting  _password:  password user
  ///@param Srting  _username:  username  user
  void loginUser(String _email, String _password) async {
    if (_email == null || _password == null) {
      await _showAlert(title: "Login Gagal", content: "Form tidak boleh kosong, mohon cek kembali data yang anda inputkan", isError: true);
      return;
    }

    final user = await DBLite.i.getUser(email: _email, password: _password);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (user != null) {
      await sharedPreferences.setBool("is_logged_in", true);
      String data = jsonEncode(user.toJson());
      sharedPreferences.setString("user_value", data);

      await _showAlert(title: "Login Berhasil", content: "", isError: false);

      emit(AuthBlocLoggedInState());
    } else {
      await _showAlert(title: "Login Gagal", content: "Periksa kembali inputan anda", isError: true);
      emit(AuthBlocLoginState());
    }
  }


  ///Digunakan logout ke aplikasi, dan menghapus setting di sharedPreferences
  ///@author nur syahfei
  void logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    emit(AuthBlocLoadingState());
    await sharedPreferences.setBool("is_logged_in", false);
    sharedPreferences.remove("user_value");
    emit(AuthBlocLoginState());
  }


  ///Digunakan menampilkan dialog alaert gagal atau berhasil
  ///@author nur syahfei
  ///@param String title: judul alert
  ///@param String content: isi alart
  ///@param bool isError: menemtukan apakah ini dialog error atau berhasil
  Future<void> _showAlert({String title, String content, bool isError}) async {
    return await showDialog(
      context: navigatorKey.currentContext,
      builder: (_) => CostumeAlertDialog(content: content, title: title, isError: isError),
    );
  }
}
