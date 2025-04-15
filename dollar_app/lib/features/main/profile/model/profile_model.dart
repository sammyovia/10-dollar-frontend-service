class ProfileModel {
  bool? status;
  ProfileData? data;
  String? message;

  ProfileModel({this.status, this.data, this.message});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class ProfileData {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? role;
  bool? emailVerified;
  bool? phoneVerified;
  String? status;
  String? chatStatus;
  String? avatar;
  dynamic gender;
  dynamic googleId;
  dynamic phoneNumber;
  dynamic referralBonus;
  dynamic referralCode;
  dynamic referredBy;
  String? createdAt;
  String? updatedAt;

  ProfileData(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.role,
      this.emailVerified,
      this.phoneVerified,
      this.status,
      this.chatStatus,
      this.avatar,
      this.gender,
      this.googleId,
      this.phoneNumber,
      this.referralBonus,
      this.referralCode,
      this.referredBy,
      this.createdAt,
      this.updatedAt});

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    role = json['role'];
    emailVerified = json['emailVerified'];
    phoneVerified = json['phoneVerified'];
    status = json['status'];
    chatStatus = json['chatStatus'];
    avatar = json['avatar'];
    gender = json['gender'];
    googleId = json['googleId'];
    phoneNumber = json['phoneNumber'];
    referralBonus = json['referralBonus'];
    referralCode = json['referralCode'];
    referredBy = json['referredBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['role'] = role;
    data['emailVerified'] = emailVerified;
    data['phoneVerified'] = phoneVerified;
    data['status'] = status;
    data['chatStatus'] = chatStatus;
    data['avatar'] = avatar;
    data['gender'] = gender;
    data['googleId'] = googleId;
    data['phoneNumber'] = phoneNumber;
    data['referralBonus'] = referralBonus;
    data['referralCode'] = referralCode;
    data['referredBy'] = referredBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
  @override
  String toString() {
    
    return 'userId: $id userName: $firstName $lastName ';
  }
}
