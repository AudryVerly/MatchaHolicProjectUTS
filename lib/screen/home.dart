import 'package:flutter/material.dart';
import '../class/mahasiswa.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> widMahasiswas() {
      List<Widget> temp = [];
      int i = 0;
      while (i < mahasiswas.length) {
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
                    mahasiswas[i].name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Image.network(mahasiswas[i].photo),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Text(mahasiswas[i].nrp),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'detailprofile');
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
