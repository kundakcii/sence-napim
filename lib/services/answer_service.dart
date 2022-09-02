import 'dart:io';
import 'package:dio/dio.dart';

abstract class IAnswerService {
  final String asnwerPath = '/addAnswer';
  final Dio dio;
  IAnswerService(this.dio);
  Future fetchAddAnswer(
      {required String content,
      required String owner,
      required String questionId});
}

class AnswerService extends IAnswerService {
  AnswerService(super.dio);

  @override
  Future fetchAddAnswer(
      {required String content,
      required String owner,
      required String questionId}) async {
    try {
      final response = await dio.post(asnwerPath, data: {
        "content": content,
        "owner": owner,
        "questionId": questionId,
      });
      if (response.statusCode == HttpStatus.ok) {
        return response.data;
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
