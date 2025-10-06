import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}


class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = "";
    _passwordController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(child: Column(
          children: [
            Text("Login"),
            TextField(
              controller: _emailController,
              onChanged: (v) {
                print(_emailController.text);
                print(v);
              },
            ),
            TextField(
              controller: _passwordController,
              onChanged: (v) {
                print(_passwordController.text);
                print(v);
              },
            ),
         
          ],
        ),
      ),
    );
  }
}
