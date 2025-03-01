class CategoryModel {
  String? id;
  String? name;
  String? image;

  CategoryModel({this.id, this.name, required this.image});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'image': image,
    };
  }
}

class CategoryResponse {
  bool? success;
  List<CategoryModel>? payload;
  String? msg;

  CategoryResponse({this.success, this.payload, this.msg});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null && json['data']['payload'] != null) {
      payload = (json['data']['payload'] as List)
          .map((e) => CategoryModel.fromJson(e))
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
