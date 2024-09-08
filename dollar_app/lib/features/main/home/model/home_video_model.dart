
// ignore_for_file: no_leading_underscores_for_local_identifiers

class HomeVideo {
  bool? status;
  List<Data>? data;
  String? message;

  HomeVideo({this.status, this.data, this.message});

  HomeVideo.fromJson(Map<String, dynamic> json) {
    if(json["status"] is bool) {
      status = json["status"];
    }
    if(json["data"] is List) {
      data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    }
    if(json["message"] is String) {
      message = json["message"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    if(data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    _data["message"] = message;
    return _data;
  }
}

class Data {
  String? id;
  String? title;
  String? videoUrl;
  int? likeCount;
  int? voteCount;
  String? createdAt;
  Artist? artist;

  Data({this.id, this.title, this.videoUrl, this.likeCount, this.voteCount, this.createdAt, this.artist});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["id"] is String) {
      id = json["id"];
    }
    if(json["title"] is String) {
      title = json["title"];
    }
    if(json["videoUrl"] is String) {
      videoUrl = json["videoUrl"];
    }
    if(json["likeCount"] is int) {
      likeCount = json["likeCount"];
    }
    if(json["voteCount"] is int) {
      voteCount = json["voteCount"];
    }
    if(json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if(json["artist"] is Map) {
      artist = json["artist"] == null ? null : Artist.fromJson(json["artist"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["title"] = title;
    _data["videoUrl"] = videoUrl;
    _data["likeCount"] = likeCount;
    _data["voteCount"] = voteCount;
    _data["createdAt"] = createdAt;
    if(artist != null) {
      _data["artist"] = artist?.toJson();
    }
    return _data;
  }
}

class Artist {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  dynamic avatar;

  Artist({this.id, this.firstName, this.lastName, this.email, this.avatar});

  Artist.fromJson(Map<String, dynamic> json) {
    if(json["id"] is String) {
      id = json["id"];
    }
    if(json["firstName"] is String) {
      firstName = json["firstName"];
    }
    if(json["lastName"] is String) {
      lastName = json["lastName"];
    }
    if(json["email"] is String) {
      email = json["email"];
    }
    avatar = json["avatar"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["firstName"] = firstName;
    _data["lastName"] = lastName;
    _data["email"] = email;
    _data["avatar"] = avatar;
    return _data;
  }
}