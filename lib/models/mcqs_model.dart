class McqsModel {
  String? id;
  String? title;
  String? desc;
  List<McqStatement>? mcqsStatements;
  Category? category;

  McqsModel({this.id, this.title, this.desc, this.mcqsStatements, this.category});

  McqsModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    desc = json['desc'];
    if (json['mcqs_statements'] != null) {
      mcqsStatements = (json['mcqs_statements'] as List)
          .map((e) => McqStatement.fromJson(e))
          .toList();
    }
    category = json['catId'] != null ? Category.fromJson(json['catId']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'desc': desc,
      'mcqs_statements': mcqsStatements?.map((e) => e.toJson()).toList(),
      'catId': category?.toJson(),
    };
  }
}

class McqStatement {
  String? id;
  String? statement;
  int? correctOption;
  List<String>? options;

  McqStatement({this.id, this.statement, this.correctOption, this.options});

  McqStatement.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    statement = json['statement'];
    correctOption = json['corrent_option'];
    options = (json['options'] as List).map((e) => e.toString()).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'statement': statement,
      'corrent_option': correctOption,
      'options': options,
    };
  }
}

class Category {
  String? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

class McqsResponse {
  bool? success;
  List<McqsModel>? payload;
  String? msg;

  McqsResponse({this.success, this.payload, this.msg});

  McqsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null && json['data']['payload'] != null) {
      payload = (json['data']['payload'] as List)
          .map((e) => McqsModel.fromJson(e))
          .toList();
    }
    msg = json['data']['msg'];
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'payload': payload?.map((e) => e.toJson()).toList(),
      'msg': msg,
    };
  }
}
