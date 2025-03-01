class NotesModel {
  String? id;
  String? title;
  String? imageUrl;
  String? content;
  Category? category;
  int? type;
  List<User>? allowedUsers;

  NotesModel({
    this.id,
    this.title,
    this.imageUrl,
    this.content,
    this.category,
    this.type,
    this.allowedUsers,
  });

  NotesModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    imageUrl = json['imageUrl'];
    content = json['content'];
    category = json['catId'] != null ? Category.fromJson(json['catId']) : null;
    type = json['type'];
    if (json['allowedUsers'] != null) {
      allowedUsers = (json['allowedUsers'] as List)
          .map((e) => User.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'imageUrl': imageUrl,
      'content': content,
      'catId': category?.toJson(),
      'type': type,
      'allowedUsers': allowedUsers?.map((e) => e.toJson()).toList(),
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

class NotesResponse {
  bool? success;
  List<NotesModel>? payload;
  String? msg;

  NotesResponse({this.success, this.payload, this.msg});

  NotesResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null && json['data']['payload'] != null) {
      payload = (json['data']['payload'] as List)
          .map((e) => NotesModel.fromJson(e))
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
