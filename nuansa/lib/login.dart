import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'models/user_model.dart';
import 'navigation.dart';
import 'db/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  DatabaseManager database = DatabaseManager();
  int count = 0;
  UserModel userData = UserModel("", "error.png", "error", "error", "error", []);

  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?>? _onUserLogin(LoginData data) {
    // Future<List<UserModel>> userDataListFuture = dbHelper.getUserByEmail(data.name);
    // userDataListFuture.then((userDataList) {
    //   userList = userDataList;
    //   count = userDataList.length;
    // });
    String? auth;
    return Future.delayed(loginTime).then((_) async {
      try {
        await database.getUserList().then((value) {
          if (value.isEmpty) {
            auth = 'Email belum terdaftar';
          } else {
            for (var element in value) {
              if (element.email == data.name) {
                if (element.kataSandi == data.password) {
                  auth = null;
                  userData = element;
                  break;
                } else {
                  auth = 'Password salah';
                  break;
                }
              } else {
                auth = 'Email belum terdaftar';
                break;
              }
            }
          }
        });
        return auth;
      } catch (e) {
        print(e);
        return "Aplikasi sedang perbaikan";
      }
      // if (count != 0) {
      //   if (userList![0].email != data.name) {
      //     return 'User not exists';
      //   }
      //   print(userList!);
      //   if (userList![0].kataSandi != data.password) {
      //     return 'Password does not match';
      //   }
      // } else {
      //   return 'Email tidak terdaftar';
      // }
      // return null;
    });
  }

  Future<String?>? _onUserSignUp(LoginData data) {
    String? auth;
    return Future.delayed(loginTime).then((_) async {
      try {
        await database.getUserList().then((value) {
          if (value.isEmpty) {
            database.signUp(data.name, data.password);
            auth = null;
          } else {
            for (var element in value) {
              if (element.email == data.name) {
                auth = "Email anda sudah terdaftar";

                break;
              } else {
                database.signUp(data.name, data.password);
                auth = null;
              }
            }
          }
        });
        return auth;
        } catch (e) {
          print(e);
          return "Aplikasi sedang perbaikan";
        }
        
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
    
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: FlutterLogin(
          title: "Nuansa.co",
          onLogin: _onUserLogin,
          onSignup: _onUserSignUp,
          onSubmitAnimationCompleted: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => Navigation(userData: userData,),
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
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}