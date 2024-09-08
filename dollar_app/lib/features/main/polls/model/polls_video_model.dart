
// ignore_for_file: no_leading_underscores_for_local_identifiers, duplicate_ignore

class PollsVideoModel {
  bool? status;
  List<Data>? data;
  String? message;

  PollsVideoModel({this.status, this.data, this.message});

  PollsVideoModel.fromJson(Map<String, dynamic> json) {
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
  String? videoId;
  String? createdAt;
  String? updatedAt;
  Video? video;

  Data({this.id, this.videoId, this.createdAt, this.updatedAt, this.video});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["id"] is String) {
      id = json["id"];
    }
    if(json["videoId"] is String) {
      videoId = json["videoId"];
    }
    if(json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if(json["updatedAt"] is String) {
      updatedAt = json["updatedAt"];
    }
    if(json["video"] is Map) {
      video = json["video"] == null ? null : Video.fromJson(json["video"]);
    }
  }

  Map<String, dynamic> toJson() {
    // ignore: no_leading_underscores_for_local_identifiers
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["videoId"] = videoId;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    if(video != null) {
      _data["video"] = video?.toJson();
    }
    return _data;
  }
}

class Video {
  String? id;
  String? title;
  String? videoUrl;
  int? voteCount;
  int? likeCount;
  int? stakeCount;
  String? status;
  String? artistId;
  String? createdAt;
  String? updatedAt;
  Artist? artist;

  Video({this.id, this.title, this.videoUrl, this.voteCount, this.likeCount, this.stakeCount, this.status, this.artistId, this.createdAt, this.updatedAt, this.artist});

  Video.fromJson(Map<String, dynamic> json) {
    if(json["id"] is String) {
      id = json["id"];
    }
    if(json["title"] is String) {
      title = json["title"];
    }
    if(json["videoUrl"] is String) {
      videoUrl = json["videoUrl"];
    }
    if(json["voteCount"] is int) {
      voteCount = json["voteCount"];
    }
    if(json["likeCount"] is int) {
      likeCount = json["likeCount"];
    }
    if(json["stakeCount"] is int) {
      stakeCount = json["stakeCount"];
    }
    if(json["status"] is String) {
      status = json["status"];
    }
    if(json["artistId"] is String) {
      artistId = json["artistId"];
    }
    if(json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if(json["updatedAt"] is String) {
      updatedAt = json["updatedAt"];
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
    _data["voteCount"] = voteCount;
    _data["likeCount"] = likeCount;
    _data["stakeCount"] = stakeCount;
    _data["status"] = status;
    _data["artistId"] = artistId;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
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