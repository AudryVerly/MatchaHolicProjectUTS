import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_matchaholic_project_uts/class/mahasiswa.dart';
import 'package:flutter_matchaholic_project_uts/screen/detail.dart';
import 'package:flutter_matchaholic_project_uts/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Daftarkontak extends StatefulWidget {
  const Daftarkontak({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DaftarKontak();
  }
}

class _DaftarKontak extends State<Daftarkontak> {
  String _temp = 'Waiting API Respond';

  Future<String> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    String userlogin = prefs.getString("user_id") ?? '';

    final response = await http.post(
      Uri.parse("https://ubaya.cloud/flutter/160422127/daftarkontak.php"),
      body: {'userId': userlogin},
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  bacaData() {
    Future<String> data = fetchData();
    data.then((value) {
      Map json = jsonDecode(value);
      if (json['result'] == 'success') {
        setState(() {
          //disini supaya datanya gak double double
          listkontak.clear();

          for (var mhs in json['data']) {
            Mahasiswa maha = Mahasiswa.fromJson(mhs);
            listkontak.add(maha);
          }
        });
      } else {
        listkontak.clear();
      }
      setState(() {});
    });
  }

  Widget DaftarKontakWidget() {
    if (listkontak.isEmpty) {
      return const Center(child: Text('Tidak ada kontak'));
    }

    return ListView.builder(
      itemCount: listkontak.length,
      itemBuilder: (BuildContext context, int index) {
        Mahasiswa mhs = listkontak[index];
        return Container(
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(128, 128, 128, 0.5),
                spreadRadius: -6,
                blurRadius: 8,
                offset: const Offset(8, 7),
              ),
            ],
          ),
          child: Card(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(15),
                  child: Text(
                    mhs.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: 180,
                  height: 180,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: mhs.photo.isNotEmpty
                        ? Image.network(mhs.photo, fit: BoxFit.cover)
                        : Image.asset('assets/default.png', fit: BoxFit.cover),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(mhs.nrp),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Detail(mahasiswaID: mhs.id),
                        ),
                      );
                    },
                    child: const Text("Lihat Detail"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    bacaData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Kontak')),
      drawer: const MyDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height- 200,
        child: DaftarKontakWidget(),
      ),
    );
  }
}
