import 'dart:convert';

class Mahasiswa {
  int id;
  String name;
  String email;
  String password;
  String photo;
  String program;
  String nrp;
  String biografi;
  List? friendRequest;

  int? requestId;
  int? senderId;

  Mahasiswa({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.photo,
    required this.program,
    required this.nrp,
    required this.biografi,
    required this.friendRequest,
    this.requestId,
    this.senderId,
  });

  factory Mahasiswa.fromJson(Map<String, dynamic> json) {
    return Mahasiswa(
      id: int.parse(json['id'].toString()),
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      photo: json['photo'] != null ? json['photo'].toString() : '',
      program: json['program'] as String,
      nrp: json['nrp'] as String,
      biografi: json['biografi'] as String,
      friendRequest: json['friend_request'],
    requestId: json['requestId'] != null
        ? int.parse(json['requestId'].toString())
        : null,
    senderId: json['sender_id'] != null
        ? int.parse(json['sender_id'].toString())
        : null,
    );
  }
}

List<Mahasiswa> Mhs = [];
List<Mahasiswa> requestMhs = [];
