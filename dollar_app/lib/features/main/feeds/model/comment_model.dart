class CommentModel {
  CommentModel({
    required this.status,
    required this.data,
    required this.message,
  });
  late final bool status;
  late final List<CommentModelData> data;
  late final String message;

  CommentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data'])
        .map((e) => CommentModelData.fromJson(e))
        .toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final datam = <String, dynamic>{};
    datam['status'] = status;
    datam['data'] = data.map((e) => e.toJson()).toList();
    datam['message'] = message;
    return datam;
  }
}

class CommentModelData {
  CommentModelData({
    required this.id,
    required this.content,
    required this.attachment,
    required this.userId,
    required this.postId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });
  late final String id;
  late final String content;
  late final String? attachment;
  late final String userId;
  late final String postId;
  late final String createdAt;
  late final String updatedAt;
  late final User user;

  CommentModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    attachment = json['attachment'];
    userId = json['userId'];
    postId = json['postId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final datam = <String, dynamic>{};
    datam['id'] = id;
    datam['content'] = content;
    datam['attachment'] = attachment;
    datam['userId'] = userId;
    datam['postId'] = postId;
    datam['createdAt'] = createdAt;
    datam['updatedAt'] = updatedAt;
    datam['user'] = user.toJson();
    return datam;
  }
}

class User {
  User({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.avatar,
    required this.role,
  });
  late final String id;
  late final String email;
  late final Null firstName;
  late final Null lastName;
  late final Null avatar;
  late final String role;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = null;
    lastName = null;
    avatar = null;
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final datam = <String, dynamic>{};
    datam['id'] = id;
    datam['email'] = email;
    datam['firstName'] = firstName;
    datam['lastName'] = lastName;
    datam['avatar'] = avatar;
    datam['role'] = role;
    return datam;
  }
}
