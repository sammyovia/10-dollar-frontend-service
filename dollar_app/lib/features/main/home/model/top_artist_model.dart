class TopArtistModel {
  TopArtistModel({
    required this.status,
    required this.data,
    required this.message,
  });
  late final bool status;
  late final List<TopArtistModelData> data;
  late final String message;

  TopArtistModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data'])
        .map((e) => TopArtistModelData.fromJson(e))
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

class TopArtistModelData {
  TopArtistModelData({
    required this.id,
    required this.title,
    required this.videoUrl,
    required this.likeCount,
    required this.voteCount,
    required this.artist,
  });
  late final String id;
  late final String title;
  late final String videoUrl;
  late final int likeCount;
  late final int voteCount;
  late final Artist artist;

  TopArtistModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    videoUrl = json['videoUrl'];
    likeCount = json['likeCount'];
    voteCount = json['voteCount'];
    artist = Artist.fromJson(json['artist']);
  }

  Map<String, dynamic> toJson() {
    final datam = <String, dynamic>{};
    datam['id'] = id;
    datam['title'] = title;
    datam['videoUrl'] = videoUrl;
    datam['likeCount'] = likeCount;
    datam['voteCount'] = voteCount;
    datam['artist'] = artist.toJson();
    return datam;
  }
}

class Artist {
  Artist({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.avatar,
  });
  late final String id;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String? avatar;

  Artist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final datam = <String, dynamic>{};
    datam['id'] = id;
    datam['firstName'] = firstName;
    datam['lastName'] = lastName;
    datam['email'] = email;
    datam['avatar'] = avatar;
    return datam;
  }
}
