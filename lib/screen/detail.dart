import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  final String name;
  final String photo;
  final String program;
  final String nrp;
  final String biografi;

  const Detail(
    this.name,
    this.photo,
    this.program,
    this.nrp,
    this.biografi, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Profil')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CircleAvatar(radius: 60, backgroundImage: NetworkImage(photo)),
            Divider(height: 10, color: Colors.transparent),
            const SizedBox(height: 15),
            Text(
              name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('NRP: $nrp'),
            Divider(height: 10, color: Colors.transparent),
            Card(
              color: Colors.grey,
              margin: EdgeInsets.all(15),
              child: ListTile(
                title: const Text('Program/ Lab'),
                subtitle: Text(program),
              ),
            ),
            Divider(height: 10, color: Colors.transparent),
            Card(
              color: Colors.grey,
              margin: EdgeInsets.all(15),
              child: ListTile(
                title: const Text('Biografi'),
                subtitle: Text(biografi),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
