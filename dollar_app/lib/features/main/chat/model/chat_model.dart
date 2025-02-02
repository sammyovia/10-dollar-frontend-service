class ChatModel {
  bool? status;
  List<Data>? data;
  String? message;
  String? createdAt;

  ChatModel({this.status, this.data, this.message,this.createdAt });

  ChatModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  String? id;
  String? message;
  String? attachment;
  bool? pin;
  User? user;

  Data({this.id, this.message, this.attachment, this.pin, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    attachment = json['attachment'];
    pin = json['pin'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    data['attachment'] = attachment;
    data['pin'] = pin;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? firstName;
  String? lastName;
  String? email;
  String? avatar;
  String? chatStatus;
  String? role;
  String? status;

  User(
      {this.firstName,
      this.lastName,
      this.email,
      this.avatar,
      this.chatStatus,
      this.role,
      this.status});

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    avatar = json['avatar'];
    chatStatus = json['chatStatus'];
    role = json['role'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['avatar'] = avatar;
    data['chatStatus'] = chatStatus;
    data['role'] = role;
    data['status'] = status;
    return data;
  }
}
