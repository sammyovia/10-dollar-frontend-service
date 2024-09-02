class PollsVideoModel {
  PollsVideoModel({
    required this.status,
    required this.data,
    required this.message,
  });
  late final bool status;
  late final List<PollsVideoModelData> data;
  late final String message;

  PollsVideoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data']).map((e) => PollsVideoModelData.fromJson(e)).toList();
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

class PollsVideoModelData {
  PollsVideoModelData({
    required this.id,
    required this.videoId,
    required this.createdAt,
    required this.updatedAt,
    required this.video,
  });
  late final String id;
  late final String videoId;
  late final String createdAt;
  late final String updatedAt;
  late final Video video;

  PollsVideoModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videoId = json['videoId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    video = Video.fromJson(json['video']);
  }

  Map<String, dynamic> toJson() {
    final datam = <String, dynamic>{};
    datam['id'] = id;
    datam['videoId'] = videoId;
    datam['createdAt'] = createdAt;
    datam['updatedAt'] = updatedAt;
    datam['video'] = video.toJson();
    return datam;
  }
}

class Video {
  Video({
    required this.id,
    required this.title,
    required this.videoUrl,
    required this.voteCount,
    required this.likeCount,
    required this.status,
    required this.artistId,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String title;
  late final String videoUrl;
  late final int voteCount;
  late final int likeCount;
  late final String status;
  late final String artistId;
  late final String createdAt;
  late final String updatedAt;

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    videoUrl = json['videoUrl'];
    voteCount = json['voteCount'];
    likeCount = json['likeCount'];
    status = json['status'];
    artistId = json['artistId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final datam = <String, dynamic>{};
    datam['id'] = id;
    datam['title'] = title;
    datam['videoUrl'] = videoUrl;
    datam['voteCount'] = voteCount;
    datam['likeCount'] = likeCount;
    datam['status'] = status;
    datam['artistId'] = artistId;
    datam['createdAt'] = createdAt;
    datam['updatedAt'] = updatedAt;
    return datam;
  }
}
