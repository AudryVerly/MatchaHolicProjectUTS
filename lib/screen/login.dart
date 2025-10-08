import 'package:flutter/material.dart';
import 'package:flutter_matchaholic_project_uts/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void doLogin() async {
  //later, we use web service here to check the user id and password
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("user_id", active_user);
  main();
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
                  onPressed: () {
                    if (_validateEmail(active_user)) {
                      setState(() {
                        doLogin(); // Call the login function
                      });
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
