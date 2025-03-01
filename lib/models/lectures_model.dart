class LecturesModel {
  String? id;
  String? title;
  String? source;
  String? imageUrl;
  Category? category;
  List<User>? allowedUsers;
  int? type;

  LecturesModel({
    this.id,
    this.title,
    this.source,
    this.imageUrl,
    this.category,
    this.allowedUsers,
    this.type,
  });

  LecturesModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    source = json['source'];
    imageUrl = json['imageUrl'];
    if (json['catId'] != null) {
      category = Category.fromJson(json['catId']);
    }
    if (json['allowedUsers'] != null) {
      allowedUsers = (json['allowedUsers'] as List)
          .map((e) => User.fromJson(e))
          .toList();
    }
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'source': source,
      'imageUrl': imageUrl,
      'catId': category?.toJson(),
      'allowedUsers': allowedUsers?.map((e) => e.toJson()).toList(),
      'type': type,
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

class User {
  String? id;
  String? name;
  String? email;
  bool? approved;

  User({this.id, this.name, this.email, this.approved});

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    approved = json['approved'];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'approved': approved,
    };
  }
}

class LecturesResponse {
  bool? success;
  List<LecturesModel>? payload;
  String? msg;

  LecturesResponse({this.success, this.payload, this.msg});

  LecturesResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null && json['data']['payload'] != null) {
      payload = (json['data']['payload'] as List)
          .map((e) => LecturesModel.fromJson(e))
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
