class GetQuestionResponseModel {
  String? sId;
  String? content;
  String? owner;
  List<String>? askto;
  List<String>? answers;
  String? createdAt;
  String? updatedAt;
  int? iV;

  GetQuestionResponseModel(
      {this.sId,
      this.content,
      this.owner,
      this.askto,
      this.answers,
      this.createdAt,
      this.updatedAt,
      this.iV});

  GetQuestionResponseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    content = json['content'];
    owner = json['owner'];
    askto = json['askto'].cast<String>();
    answers = json['answers'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['content'] = content;
    data['owner'] = owner;
    data['askto'] = askto;
    data['answers'] = answers;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
