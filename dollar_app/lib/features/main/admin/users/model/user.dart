class User {
  User({
    required this.status,
    required this.data,
    required this.message,
  });

  final bool? status;
  final List<UserDatum> data;
  final String? message;

  User copyWith({
    bool? status,
    List<UserDatum>? data,
    String? message,
  }) {
    return User(
      status: status ?? this.status,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      status: json["status"],
      data: json["data"] == null ? [] : List<UserDatum>.from(json["data"]!.map((x) => UserDatum.fromJson(x))),
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.map((x) => x.toJson()).toList(),
    "message": message,
  };

  @override
  String toString(){
    return "$status, $data, $message,";
  }
}

class UserDatum {
  UserDatum({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.role,
    required this.chatStatus
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? avatar;
  final String? role;
  final String? chatStatus;

  UserDatum copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? avatar,
    String? role,
    String? charStatus
  }) {
    return UserDatum(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      avatar: avatar ?? this.avatar,
      role: role ?? this.role,
      chatStatus: charStatus ?? chatStatus
    );
  }

  factory UserDatum.fromJson(Map<String, dynamic> json){
    return UserDatum(
      id: json["id"],
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      avatar: json["avatar"] ?? "",
      role: json["role"] ?? "",
      chatStatus: json['chatStatus'] ?? ""
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "avatar": avatar,
    "role": role,
    "chatStatus":chatStatus
  };

  @override
  String toString(){
    return "$id, $firstName, $lastName, $avatar, $role, $chatStatus ";
  }
}
