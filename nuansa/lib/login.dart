import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'models/user_model.dart';
import 'navigation.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?>? _authUser(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?>? _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: "Nuansa.co",
      onLogin: _authUser,
      onSignup: _authUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Navigation(),
        ));
      },
      onRecoverPassword: _recoverPassword,
      messages: LoginMessages(
        passwordHint: "Kata Sandi",
        forgotPasswordButton: "Lupa Password?",
        goBackButton: "Kembali",
        loginButton: "Masuk",
        signupButton: "Daftar",
        recoverPasswordButton: "Lanjutkan",
        recoverPasswordIntro: "Setel ulang kata sandi anda di sini",
        recoverPasswordDescription: "Kami akan mengirimkan kata sandi anda ke akun email ini",
        confirmPasswordError: "Kata sandi salah",
        recoverPasswordSuccess: "Email telah dikirim",
        flushbarTitleError: "Kesalahan",
        flushbarTitleSuccess: "Sukses"
      ),
    );
  }
}