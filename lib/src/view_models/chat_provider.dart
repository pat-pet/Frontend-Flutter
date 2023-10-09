import 'package:flutter/material.dart';
import 'package:frontend_flutter/src/api/authentication_api.dart';
import 'package:frontend_flutter/src/api/message_api.dart';
import 'package:frontend_flutter/src/model/message_model.dart';
import 'package:frontend_flutter/src/model/message_response.dart';
import 'package:frontend_flutter/src/model/register_model.dart';
import 'package:frontend_flutter/src/utils/token_manager.dart';

enum ChatStatus { empty, loading, success, error }

class ChatProvider extends ChangeNotifier {
  ChatStatus _homeStatus = ChatStatus.empty;
  ChatStatus get homeStatus => _homeStatus;

  UserModel? _user = null;
  UserModel? get user => _user;

  List<MessageResponse> _messages = [];
  List<MessageResponse> get messages => _messages;

  Map<String, List<MessageResponse>> _userMessages = {};
  Map<String, List<MessageResponse>> get userMessages => _userMessages;

  final String _error = '';
  String get error => _error;

  String _message = '';
  String get message => _message;

  String _senderId = '';
  String get senderId => _senderId;

  String _senderName = '';
  String get senderName => _senderName;

  void setUser(UserModel user) {
    _user = user;
  }

  Future<void> sendMessage(String content) async {
    final token = await SharedPrefManager.getString(SharedPrefManager.tokenKey);

    await MessageApi().sendMessage(
      _user?.id?.toString() ?? '',
      content,
      token ?? '',
    );

    notifyListeners();
  }

  Future<void> getUserMessages() async {
    final token = await SharedPrefManager.getString(SharedPrefManager.tokenKey);

    List<MessageResponse> result = await MessageApi().getUserMessage(
      token ?? "",
    );

    _userMessages =
        result.groupBy((message) => message.receiver?.fullName ?? '');
    notifyListeners();
  }

  Future<void> getMessages(String receiverId) async {
    final id = await SharedPrefManager.getString(SharedPrefManager.idKey);
    final name =
        await SharedPrefManager.getString(SharedPrefManager.fullNameKey);
    final token = await SharedPrefManager.getString(SharedPrefManager.tokenKey);

    List<MessageResponse> result =
        await MessageApi().getMessageByUserIdReceiverId(
      int.parse(id ?? "0"),
      _user?.id ?? 0,
      token ?? "",
    );

    _senderId = id ?? '';
    _senderName = name ?? '';
    _messages = result;
    notifyListeners();
  }

  void addMessage(int senderId, String sender, String content) {
    _messages.add(MessageResponse(
      id: null,
      sender: UserModel(fullName: sender, id: senderId),
      receiver: _user,
      content: content,
    ));
    notifyListeners();
  }
}

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}
