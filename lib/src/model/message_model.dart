class MessageModel {
  String? receiverId;
  String? content;

  MessageModel({this.receiverId, this.content});

  MessageModel.fromJson(Map<String, dynamic> json) {
    receiverId = json['receiverId'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() => {
        'content': content,
        'receiverId': receiverId,
      };
}
