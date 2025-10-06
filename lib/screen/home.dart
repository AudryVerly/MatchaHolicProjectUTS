import 'package:flutter/material.dart';
import 'package:flutter_matchaholic_project_uts/main.dart';
import 'package:flutter_matchaholic_project_uts/screen/detail.dart';
import '../class/mahasiswa.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> widMahasiswas() {
      List<Widget> temp = [];
      int i = 0;
      while (i < mahasiswas.length) {
        var mhs = mahasiswas[i];
        Widget w = Container(
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
                    mhs.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Image.network(mhs.photo),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Text(mhs.nrp),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detail(
                          mhs.name,
                          mhs.photo,
                          mhs.program,
                          mhs.nrp,
                          mhs.biografi,
                        ),
                      ),
                    );
                  },
                  child: const Text("Lihat Detail Profile"),
                ),
              ],
            ),
          ),
        );
        temp.add(w);
        i++;
      }
      return temp;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Mahasiswa')),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: widMahasiswas(),
            ),
            Divider(height: 100),
          ],
        ),
      ),
    );
  }
}
