import 'package:dio/dio.dart';

class ProfileApi {
  final String urlEditStatus = 'http://192.168.100.24:3000/users/editstatus';

  var error = '';
  var message = '';

  Future<void> editStatus(String status, String token) async {
    await Dio().put(
      urlEditStatus,
      data: {'status_animal_care': status},
      options: Options(
        headers: {'token': token},
      ),
    );
  }
}
