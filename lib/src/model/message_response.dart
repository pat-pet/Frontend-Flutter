import 'package:frontend_flutter/src/model/register_model.dart';

class MessageResponse {
  int? id;
  UserModel? sender;
  UserModel? receiver;
  String? content;

  MessageResponse({
    this.id,
    this.sender,
    this.receiver,
    this.content,
  });

  MessageResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sender = UserModel.fromJson(json["sender"]);
    receiver = UserModel.fromJson(json["receiver"]);
    content = json['content'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'sender': sender?.toJson(),
        'receiver': receiver?.toJson(),
      };
}
