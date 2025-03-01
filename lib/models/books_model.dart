class BooksModel {
  String? id;
  String? title;
  String? imageUrl;
  Category? category;
  int? type;
  List<User>? allowedUsers;
  List<Chapter>? chapters;

  BooksModel({this.id, this.title, this.imageUrl, this.chapters, this.category, this.type, this.allowedUsers,});

  BooksModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    imageUrl = json['imageUrl'];
    category = json['catId'] != null ? Category.fromJson(json['catId']) : null;
    type = json['type'];
    if (json['allowedUsers'] != null) {
      allowedUsers = (json['allowedUsers'] as List)
          .map((e) => User.fromJson(e))
          .toList();
    }
    if (json['chapters'] != null) {
      chapters = (json['chapters'] as List)
          .map((e) => Chapter.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'imageUrl': imageUrl,
      'catId': category?.toJson(),
      'type': type,
      'allowedUsers': allowedUsers?.map((e) => e.toJson()).toList(),
      'chapters': chapters?.map((e) => e.toJson()).toList(),
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

class Chapter {
  String? id;
  String? title;
  String? content;

  Chapter({this.id, this.title, this.content});

  Chapter.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'content': content,
    };
  }
}

class BooksResponse {
  bool? success;
  List<BooksModel>? payload;
  String? msg;

  BooksResponse({this.success, this.payload, this.msg});

  BooksResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null && json['data']['payload'] != null) {
      payload = (json['data']['payload'] as List)
          .map((e) => BooksModel.fromJson(e))
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
