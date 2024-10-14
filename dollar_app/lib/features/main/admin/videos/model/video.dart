class AdminVideo {
  AdminVideo({
    required this.status,
    required this.data,
    required this.message,
  });

  final bool? status;
  final List<AdminVideoDatum> data;
  final String? message;

  AdminVideo copyWith({
    bool? status,
    List<AdminVideoDatum>? data,
    String? message,
  }) {
    return AdminVideo(
      status: status ?? this.status,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }

  factory AdminVideo.fromJson(Map<String, dynamic> json){
    return AdminVideo(
      status: json["status"],
      data: json["data"] == null ? [] : List<AdminVideoDatum>.from(json["data"]!.map((x) => AdminVideoDatum.fromJson(x))),
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
    return "$status, $data, $message, ";
  }
}

class AdminVideoDatum {
  AdminVideoDatum({
    required this.id,
    required this.title,
    required this.videoUrl,
    required this.voteCount,
    required this.likeCount,
    required this.stakeCount,
    required this.status,
    required this.artistId,
    required this.createdAt,
    required this.updatedAt,
    required this.artist,
  });

  final String? id;
  final String? title;
  final String? videoUrl;
  final num? voteCount;
  final num? likeCount;
  final num? stakeCount;
  final String? status;
  final String? artistId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Artist? artist;

  AdminVideoDatum copyWith({
    String? id,
    String? title,
    String? videoUrl,
    num? voteCount,
    num? likeCount,
    num? stakeCount,
    String? status,
    String? artistId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Artist? artist,
  }) {
    return AdminVideoDatum(
      id: id ?? this.id,
      title: title ?? this.title,
      videoUrl: videoUrl ?? this.videoUrl,
      voteCount: voteCount ?? this.voteCount,
      likeCount: likeCount ?? this.likeCount,
      stakeCount: stakeCount ?? this.stakeCount,
      status: status ?? this.status,
      artistId: artistId ?? this.artistId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      artist: artist ?? this.artist,
    );
  }

  factory AdminVideoDatum.fromJson(Map<String, dynamic> json){
    return AdminVideoDatum(
      id: json["id"],
      title: json["title"] ?? "",
      videoUrl: json["videoUrl"],
      voteCount: json["voteCount"],
      likeCount: json["likeCount"],
      stakeCount: json["stakeCount"],
      status: json["status"] ?? "",
      artistId: json["artistId"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      artist: json["artist"] == null ? null : Artist.fromJson(json["artist"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "videoUrl": videoUrl,
    "voteCount": voteCount,
    "likeCount": likeCount,
    "stakeCount": stakeCount,
    "status": status,
    "artistId": artistId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "artist": artist?.toJson(),
  };

  @override
  String toString(){
    return "$id, $title, $videoUrl, $voteCount, $likeCount, $stakeCount, $status, $artistId, $createdAt, $updatedAt, $artist, ";
  }
}

class Artist {
  Artist({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? avatar;

  Artist copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? avatar,
  }) {
    return Artist(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
    );
  }

  factory Artist.fromJson(Map<String, dynamic> json){
    return Artist(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      avatar: json["avatar"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "avatar": avatar,
  };

  @override
  String toString(){
    return "$id, $firstName, $lastName, $email, $avatar, ";
  }
}
