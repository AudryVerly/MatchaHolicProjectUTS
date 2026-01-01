import 'package:flutter/material.dart';
import 'package:flutter_matchaholic_project_uts/class/mahasiswa.dart';
import 'package:flutter_matchaholic_project_uts/main.dart';
import 'package:flutter_matchaholic_project_uts/screen/home.dart';
import 'package:flutter_matchaholic_project_uts/screen/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String active_user = "";
String _user_email = "";
String _user_password = "";
// int _user_id = 0;
String _error_login = "";
String _emailError = "";

// Future<bool> doLogin(String email, String pwd) async {
//   Mahasiswa? foundUser;
//   try {
//     foundUser = mahasiswas.firstWhere(
//       (m) => m.email == email && m.password == pwd,
//     );
//   } catch (e) {
//     foundUser = null;
//   }
//   if (foundUser == null) {
//     return false;
//   } else {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString("user_id", active_user);
//     loggedInUser = foundUser;
//     main();
//     return true;
//   }
// }

class MyLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Matchaholic UTS',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  void doLogin() async {
    final response = await http.post(
      Uri.parse("https://ubaya.cloud/flutter/160422127/loginmahasiswa.php"),
      body: {'email': _user_email, 'password': _user_password},
    );

    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("user_id", json['data']['id'].toString());
        prefs.setString("email", json['data']['email']);
        prefs.setString("password", json['data']['password']);

        loggedInUser = Mahasiswa.fromJson(json['data']);
        main();
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const Home()),
        // );
      } else {
        setState(() {
          _error_login = "Incorrect user or password";
        });
      }
    } else {
      throw Exception('Failed to read API');
    }
  }

  bool _validateEmail(String email) {
    return email.isNotEmpty && email.contains('@');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),

      body: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1),
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 5)],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com',
                    errorText: _emailError.isEmpty ? null : _emailError,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _user_email = value;
                      _emailError = _validateEmail(value)
                          ? ''
                          : 'Invalid email format';
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _pwdController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password',
                  ),
                  onChanged: (value) {
                    _user_password = value;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      doLogin();
                    },
                    child: Text('Login', style: TextStyle(fontSize: 25)),
                  ),
                ),
              ),
              if (_error_login.isNotEmpty)
                Text(_error_login, style: TextStyle(color: Colors.red)),

              // Register Link
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Belum memiliki akun? '),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                      child: const Text(
                        'Daftar di sini',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.all(10),
              //   child: Container(
              //     height: 50,
              //     width: 300,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     child: ElevatedButton(
              //       onPressed: () async {
              //         if (_validateEmail(active_user)) {
              //           // Call the login function
              //           bool successLogin = await doLogin(
              //             active_user,
              //             _pwdController.text,
              //           );
              //           if (!successLogin) {
              //             //if_the_login_failed
              //             showDialog(
              //               context: context,
              //               builder: (BuildContext context) {
              //                 return AlertDialog(
              //                   title: const Text("Login Failed"),
              //                   content: const Text(
              //                     "Incorrect email or password. Please try again.",
              //                   ),
              //                   shape: RoundedRectangleBorder(
              //                     borderRadius: BorderRadius.circular(12),
              //                   ),
              //                   actions: [
              //                     TextButton(
              //                       child: const Text("OK"),
              //                       onPressed: () {
              //                         Navigator.popAndPushNamed(context, 'login');
              //                       },
              //                     ),
              //                   ],
              //                 );
              //               },
              //             );
              //           }
              //         } else {
              //           setState(() {
              //             _emailError = 'Invalid email format';
              //           });
              //         }
              //       },
              //       child: Text('Login', style: TextStyle(fontSize: 25)),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
