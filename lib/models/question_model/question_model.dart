class QuestionModel {
  String? owner;
  String? content;

  QuestionModel({this.owner, this.content});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    owner = json['owner'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['owner'] = owner;
    data['content'] = content;
    return data;
  }
}
