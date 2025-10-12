import 'package:flutter/material.dart';
import 'package:flutter_matchaholic_project_uts/class/mahasiswa.dart';
import 'package:flutter_matchaholic_project_uts/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> doLogin(String email, String pwd) async {
  Mahasiswa? foundUser;
  try {
    foundUser = mahasiswas.firstWhere(
      (m) => m.email == email && m.password == pwd,
    );
  } catch (e) {
    foundUser = null;
  }
  if (foundUser == null) {
    return false;
  } else {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("user_id", active_user);
    loggedInUser = foundUser;
    main();
    return true;
  }
}

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
  final TextEditingController _pwdController = TextEditingController();
  String _emailError = "";

  bool _validateEmail(String email) {
    return email.isNotEmpty && email.contains('@');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),

      body: Container(
        height: 300,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1),
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 5)],
        ),
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
                    active_user = value;
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
                  onPressed: () async {
                    if (_validateEmail(active_user)) {
                      // Call the login function
                      bool successLogin = await doLogin(
                        active_user,
                        _pwdController.text,
                      );
                      if (!successLogin) {
                        //if_the_login_failed
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Login Failed"),
                              content: const Text(
                                "Incorrect email or password. Please try again.",
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text("OK"),
                                  onPressed: () {
                                    Navigator.popAndPushNamed(context, 'login');
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    } else {
                      setState(() {
                        _emailError = 'Invalid email format';
                      });
                    }
                  },
                  child: Text('Login', style: TextStyle(fontSize: 25)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
