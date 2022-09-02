import 'dart:io';
import 'package:dio/dio.dart';
import 'package:sence/models/question_model/question_model.dart';

abstract class IQuestionService {
  final String questionPath = '/addQuestion';
  final String getQuestionPath = '/getQuestion';
  final String getAskToYouPath = '/getAskToYou';
  final Dio dio;
  IQuestionService(this.dio);
  Future fetchAddQuestion(QuestionModel model);
  Future fetchGetQuestion({required String userId});
  Future fetchGetAskToYou({required String userId});
}

class QuestionService extends IQuestionService {
  QuestionService(super.dio);

  @override
  Future fetchAddQuestion(QuestionModel model) async {
    try {
      final response = await dio.post(questionPath, data: model);
      if (response.statusCode == HttpStatus.ok) {
        return response.data;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Future fetchGetQuestion({required String userId}) async {
    try {
      final response =
          await dio.post(getQuestionPath, data: {'userId': userId});
      if (response.statusCode == HttpStatus.ok) {
        return response.data;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Future fetchGetAskToYou({required String userId}) async {
    try {
      final response =
          await dio.post(getAskToYouPath, data: {'userId': userId});
      if (response.statusCode == HttpStatus.ok) {
        return response.data;
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
