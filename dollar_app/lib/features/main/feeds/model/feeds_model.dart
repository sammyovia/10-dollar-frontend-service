class FeedsModel {
  FeedsModel({
    required this.status,
    required this.feedModelData,
    required this.message,
  });
  late final bool status;
  late final List<FeedModelData> feedModelData;
  late final String message;

  FeedsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    feedModelData = List.from(json['data']).map((e) => FeedModelData.fromJson(e)).toList();
    message = json['message'];
  }

}

class FeedModelData {
  FeedModelData({
    required this.id,
    required this.title,
    required this.content,
    this.attachment,
    required this.likeCount,
    required this.commentCount,
    required this.user,
  });
  late final String id;
  late final String title;
  late final String content;
  late final String? attachment;
  late final int likeCount;
  late final int commentCount;
  late final User user;

  FeedModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    attachment = json['attachment'] ?? '';
    likeCount = json['likeCount'];
    commentCount = json['commentCount'];
    user = User.fromJson(json['user']);
  }
}

class User {
  User({
    required this.id,
    this.avatar,
    this.firstName,
    this.lastName,
    required this.role,
  });
  late final String id;
  late final String? avatar;
  late final String? firstName;
  late final String? lastName;
  late final String role;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    role = json['role'];
  }

  
}
