class UserResponseModel {
  String? token;
  String? userId;

  UserResponseModel({this.token, this.userId});

  UserResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['userId'] = userId;
    return data;
  }
}