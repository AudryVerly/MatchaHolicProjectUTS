class FriendRequest {
  int id;
  int senderId;
  int receiverId;
  int status;

  FriendRequest({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.status,
  });

  factory FriendRequest.fromJson(Map<String, dynamic> json) {
    return FriendRequest(
      id: int.parse(json['id'].toString()),
      senderId: int.parse(json['senderid'].toString()),
      receiverId: int.parse(json['receiverid'].toString()),
      status: int.parse(json['status'].toString()),
    );
  }
}
