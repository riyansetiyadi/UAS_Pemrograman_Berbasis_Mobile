import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'models/user_model.dart';
import 'navigation.dart';
import 'db/database.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  UserModel? userData;
  List<UserModel>? userList;

  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?>? _onUserLogin(LoginData data) {
    Future<List<UserModel>> userDataListFuture = dbHelper.getUserByEmail(data.name);
    userDataListFuture.then((userDataList) {
      userList = userDataList;
      count = userDataList.length;
    });
    return Future.delayed(loginTime).then((_) {
      if (count != 0) {
        if (userList![0].email != data.name) {
          return 'User not exists';
        }
        print(userList!);
        if (userList![0].kataSandi != data.password) {
          return 'Password does not match';
        }
      } else {
        return 'Email tidak terdaftar';
      }
      return null;
    });
  }

  Future<String?>? _onUserSignUp(LoginData data) {
    userData = UserModel(null, data.name, data.name, data.password);
    return Future.delayed(loginTime).then((_) async {
      int result = await dbHelper.insertUser(userData!);
      if (result > 0) {
        return null;
      }
      return 'Email sudah terdaftar';
    });
  }

  Future<String?>? _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      // if (!users.containsKey(name)) {
      //   return 'User not exists';
      // }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return FlutterLogin(
      title: "Nuansa.co",
      onLogin: _onUserLogin,
      onSignup: _onUserSignUp,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Navigation(),
        ));
      },
      onRecoverPassword: _recoverPassword,
      messages: LoginMessages(
        passwordHint: "Kata Sandi",
        confirmPasswordHint: "Konfirmasi Kata Sandi",
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

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}