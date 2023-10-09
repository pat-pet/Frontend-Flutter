import 'package:dio/dio.dart';
import 'package:frontend_flutter/src/model/message_model.dart';
import 'package:frontend_flutter/src/model/message_response.dart';
import 'package:frontend_flutter/src/model/register_model.dart';

class MessageApi {
  final String urlGetMessageById = 'http://192.168.100.19:3000/messages/sent/';
  final String urlMessage = 'http://192.168.100.19:3000/messages';
  final String urlMessageSended = 'http://192.168.100.19:3000/messages/sended';

  var error = '';
  var message = '';

  Future<List<MessageResponse>> getMessageByUserIdReceiverId(
    int userId,
    int receiverId,
    String token,
  ) async {
    final response = await Dio().get(
      urlGetMessageById + receiverId.toString(),
      options: Options(
        headers: {
          'token': token,
        },
      ),
    );

    if (response.statusCode == 200) {
      List<MessageResponse> messages = response.data['messages']
          .map<MessageResponse>((message) => MessageResponse.fromJson(message))
          .toList();

      return messages;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<MessageResponse>> getUserMessage(String token) async {
    final response = await Dio().get(
      urlMessageSended,
      options: Options(headers: {'token': token}),
    );

    if (response.statusCode == 200) {
      List<MessageResponse> messages = response.data['messages']
          .map<MessageResponse>((message) => MessageResponse.fromJson(message))
          .toList();

      return messages;
    } else {
      throw Exception('Failed to load messages');
    }
  }

  Future<MessageModel> sendMessage(
    String? receiverId,
    String content,
    String token,
  ) async {
    final body = MessageModel(receiverId: receiverId, content: content);

    final response = await Dio().post(
      urlMessage,
      data: body.toJson(),
      options: Options(
        headers: {'token': token},
      ),
    );

    return MessageModel.fromJson(response.data);
  }
}
