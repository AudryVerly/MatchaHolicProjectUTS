class Friends {
  int id;
  int idpenerima;
  int idTeman;

  Friends({required this.id, required this.idpenerima, required this.idTeman});

  factory Friends.fromJson(Map<String, dynamic> json) {
    return Friends(
      id: int.parse(json['id'].toString()),
      idpenerima: int.parse(json['idpenerima'].toString()),
      idTeman: int.parse(json['idTeman'].toString()),
    );
  }
}
