import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_matchaholic_project_uts/main.dart';
import 'package:flutter_matchaholic_project_uts/screen/detail.dart';
import '../class/mahasiswa.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  String _temp = 'Waiting API respond';

  Future<String> fetchData() async {
    final response = await http.post(
      Uri.parse("https://ubaya.cloud/flutter/160422127/mahasiswalist.php"),
      body: {'id': loggedInUser?.id.toString() ?? ''},
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
        for (var mhs in json['data']) {
          Mahasiswa maha = Mahasiswa.fromJson(mhs);
          Mhs.add(maha);
        }
      } else {
        Mhs.clear();
      }
      setState(() {});
    });
  }

  Widget DaftarMahasiswa(listMhs) {
    if (listMhs != null) {
      return ListView.builder(
        itemCount: listMhs.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return Container(
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(128, 128, 128, 0.5),
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
                      Mhs[index].name,
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
                      child: Image.network(Mhs[index].photo, fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Text(Mhs[index].nrp),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(elevation: WidgetStateProperty.all(5)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Detail(mahasiswaID: Mhs[index].id),
                          ),
                        );
                      },
                      child: const Text("Lihat Detail Profile"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      return const CircularProgressIndicator();
    }
  }

  @override
  void initState() {
    super.initState();
    bacaData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Mahasiswa')),
      drawer: const MyDrawer(),

      body: Container(
        height: MediaQuery.of(context).size.height - 200,
        child: Mhs.isNotEmpty
            ? DaftarMahasiswa(Mhs)
            : const Center(child: Text('tidak ada data')),
      ),
    );
  }
}
