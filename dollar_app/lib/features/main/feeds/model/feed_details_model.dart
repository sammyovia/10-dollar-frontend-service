class FeedDetails {
  FeedDetails({
    required this.status,
    required this.data,
    required this.message,
  });

  final bool? status;
  final Data? data;
  final String? message;

  factory FeedDetails.fromJson(Map<String, dynamic> json) {
    return FeedDetails(
      status: json["status"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
      };

  @override
  String toString() {
    return "$status, $data, $message, ";
  }
}

class Data {
  Data({
    required this.id,
    required this.title,
    required this.content,
    required this.attachment,
    required this.likeCount,
    required this.commentCount,
    required this.user,
  });

  final String? id;
  final String? title;
  final String? content;
  final String? attachment;
  final int? likeCount;
  final int? commentCount;
  final User? user;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["id"],
      title: json["title"],
      content: json["content"],
      attachment: json["attachment"],
      likeCount: json["likeCount"],
      commentCount: json["commentCount"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "attachment": attachment,
        "likeCount": likeCount,
        "commentCount": commentCount,
        "user": user?.toJson(),
      };

  @override
  String toString() {
    return "$id, $title, $content, $attachment, $likeCount, $commentCount, $user, ";
  }
}

class User {
  User({
    required this.id,
    required this.avatar,
    required this.firstName,
    required this.lastName,
    required this.role,
  });

  final String? id;
  final dynamic avatar;
  final dynamic firstName;
  final dynamic lastName;
  final String? role;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      avatar: json["avatar"],
      firstName: json["firstName"] ?? 'new',
      lastName: json["lastName"] ?? 'user',
      role: json["role"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "firstName": firstName,
        "lastName": lastName,
        "role": role,
      };

  @override
  String toString() {
    return "$id, $avatar, $firstName, $lastName, $role, ";
  }
}
