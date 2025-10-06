import 'package:flutter/widgets.dart';

class Mahasiswa {
  int id;
  String name;
  String photo;
  String program;
  String nrp;
  Text biografi;

  Mahasiswa({
    required this.id,
    required this.name,
    required this.photo,
    required this.program,
    required this.nrp,
    required this.biografi,
  });
}
