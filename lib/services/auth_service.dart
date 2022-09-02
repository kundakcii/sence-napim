import 'dart:io';
import 'package:dio/dio.dart';
import 'package:sence/models/user_models/user_model.dart';
import 'package:sence/models/user_models/user_response_model.dart';

abstract class IAuthService {
  final String loginPath = '/login';
  final String registerPath = '/register';
  final Dio dio;
  IAuthService(this.dio);
  Future<UserResponseModel?> fetchLogin(UserModel model);
  Future<UserResponseModel?> fetchRegister(UserModel model);
}

class AuthService extends IAuthService {
  AuthService(super.dio);

  @override
  Future<UserResponseModel?> fetchLogin(UserModel model) async {
    try {
      final response = await dio.post(loginPath, data: model);
      if (response.statusCode == HttpStatus.ok) {
        return UserResponseModel.fromJson(response.data);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Future<UserResponseModel?> fetchRegister(UserModel model) async {
    try {
      final response = await dio.post(registerPath, data: model);
      if (response.statusCode == HttpStatus.ok) {
        return UserResponseModel.fromJson(response.data);
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
