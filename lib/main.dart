import 'package:flutter/material.dart';
import 'package:flutter_matchaholic_project_uts/class/mahasiswa.dart';
import 'package:flutter_matchaholic_project_uts/screen/daftarkontak.dart';
import 'package:flutter_matchaholic_project_uts/screen/editprofile.dart';
import 'package:flutter_matchaholic_project_uts/screen/home.dart';
import 'package:flutter_matchaholic_project_uts/screen/login.dart';
import 'package:flutter_matchaholic_project_uts/screen/requestlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  checkUser().then((String result) {
    if (result == '')
      runApp(MyLogin());
    else {
      active_user = result;
      runApp(MyApp());
    }
  });
}

String active_user = "";
Mahasiswa? loggedInUser; //mengambil_data_user_yg_lg_login

Future<String> checkUser() async {
  final prefs = await SharedPreferences.getInstance();
  String user_id = prefs.getString("user_id") ?? '';
  return user_id;
}

void doLogout() async {
  //later, we use web service here to check the user id and password
  final prefs = await SharedPreferences.getInstance();
  prefs.remove("user_id");
  String user_id = prefs.getString("user_id") ?? '';
  main();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Home(), //the_first_page_to_launch_it's_the_home.dart
      //routing
      routes: {
        'home': (context) => const Home(),
        'editprofile': (context) => const Editprofile(),
        'requestlist': (context) => Requestlist(),
        'kontak': (context) =>Daftarkontak(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 16.0,
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(loggedInUser?.name ?? "Username"),
            accountEmail: Text(loggedInUser?.email ?? "email"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(loggedInUser?.photo ?? ""),
            ),
          ),
          ListTile(
            title: const Text("Home"),
            leading: const Icon(Icons.home),
            onTap: () {
              Navigator.popAndPushNamed(context, 'home');
            },
          ),
          ListTile(
            title: const Text("Edit Profile"),
            leading: const Icon(Icons.edit),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'editprofile');
            },
          ),
          ListTile(
            title: const Text("Requests"),
            leading: const Icon(Icons.notifications),
            onTap: () {
              Navigator.popAndPushNamed(context, 'requestlist');
            },
          ),
          ListTile(
            title: const Text("Daftar Kontak"),
            leading: const Icon(Icons.contacts_rounded),
            onTap: () {
              Navigator.popAndPushNamed(context, 'kontak');
            },
          ),
          ListTile(
            title: const Text("Logout"),
            leading: const Icon(Icons.logout),
            onTap: () {
              doLogout();
            },
          ),
        ],
      ),
    );
  }
}
