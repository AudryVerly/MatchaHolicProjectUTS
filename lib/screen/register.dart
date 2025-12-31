import 'package:flutter/material.dart';
import 'package:flutter_matchaholic_project_uts/class/mahasiswa.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

String _register_name = '';
String _register_email = '';
String _register_password = '';
String _register_confirm_password = '';
String _register_nrp = '';
String _error_register = '';
String _nameError = '';
String _emailError = '';
String _passwordError = '';
String _nrpError = '';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nrpController = TextEditingController();

  bool _validateEmail(String email) {
    return email.isNotEmpty && email.contains('@') && email.contains('.');
  }

  bool _validatePassword(String password) {
    return password.isNotEmpty && password.length >= 6;
  }

  bool _validateName(String name) {
    return name.isNotEmpty && name.length >= 3;
  }

  bool _validateNRP(String nrp) {
    return nrp.isNotEmpty && nrp.length >= 9;
  }

  void doRegister() async {
    bool isValid = true;

    if (!_validateName(_register_name)) {
      setState(() {
        _nameError = 'Nama minimal 3 karakter';
      });
      isValid = false;
    } else {
      setState(() {
        _nameError = '';
      });
    }

    if (!_validateEmail(_register_email)) {
      setState(() {
        _emailError = 'Format email tidak valid';
      });
      isValid = false;
    } else {
      setState(() {
        _emailError = '';
      });
    }

    if (!_validatePassword(_register_password)) {
      setState(() {
        _passwordError = 'Password minimal 6 karakter';
      });
      isValid = false;
    } else if (_register_password != _register_confirm_password) {
      setState(() {
        _passwordError = 'Password tidak sesuai';
      });
      isValid = false;
    } else {
      setState(() {
        _passwordError = '';
      });
    }

    if (!_validateNRP(_register_nrp)) {
      setState(() {
        _nrpError = 'NRP minimal 9 karakter';
      });
      isValid = false;
    } else {
      setState(() {
        _nrpError = '';
      });
    }

    if (!isValid) {
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(
          "https://ubaya.cloud/flutter/160422127/registermahasiswa.php",
        ),
        body: {
          'name': _register_name,
          'email': _register_email,
          'password': _register_password,
          'nrp': _register_nrp,
        },
      );

      if (response.statusCode == 200) {
        Map json = jsonDecode(response.body);
        if (json['result'] == 'success') {
          // Show success dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Registrasi Berhasil'),
                content: const Text(
                  'Akun Anda telah berhasil dibuat. Silakan login dengan email dan password yang Anda daftarkan.',
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                actions: [
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context); // Go back to login
                    },
                  ),
                ],
              );
            },
          );
        } else {
          setState(() {
            _error_register =
                json['message'] ??
                'Registrasi gagal. Email mungkin sudah terdaftar.';
          });
        }
      } else {
        setState(() {
          _error_register = 'Terjadi kesalahan pada server';
        });
      }
    } catch (e) {
      setState(() {
        _error_register = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrasi Akun Baru'), elevation: 0),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(width: 1),
            color: Colors.white,
            boxShadow: [
              BoxShadow(blurRadius: 5, color: Colors.grey.withOpacity(0.3)),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Nama Lengkap',
                    hintText: 'Masukkan nama lengkap Anda',
                    errorText: _nameError.isEmpty ? null : _nameError,
                    prefixIcon: const Icon(Icons.person),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _register_name = value;
                    });
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Masukkan email Anda',
                    errorText: _emailError.isEmpty ? null : _emailError,
                    prefixIcon: const Icon(Icons.email),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _register_email = value;
                    });
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _nrpController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'NRP',
                    hintText: 'Masukkan NRP Anda',
                    errorText: _nrpError.isEmpty ? null : _nrpError,
                    prefixIcon: const Icon(Icons.badge),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _register_nrp = value;
                    });
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Masukkan password minimal 6 karakter',
                    errorText: _passwordError.isEmpty ? null : _passwordError,
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _register_password = value;
                    });
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Konfirmasi Password',
                    hintText: 'Masukkan ulang password Anda',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _register_confirm_password = value;
                    });
                  },
                ),
              ),

              if (_error_register.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    _error_register,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),

              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    onPressed: doRegister,
                    child: const Text(
                      'Daftar Akun',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Sudah memiliki akun? '),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Masuk di sini',
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
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nrpController.dispose();
    super.dispose();
  }
}
