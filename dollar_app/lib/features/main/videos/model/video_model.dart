class VideoModel {
  VideoModel({
    required this.status,
    required this.data,
    required this.message,
  });
  late final bool status;
  late final List<VideoModelData> data;
  late final String message;

  VideoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data']).map((e) => VideoModelData.fromJson(e)).toList();
    message = json['message'];
  }

 
}

class VideoModelData {
  VideoModelData({
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

  VideoModelData.fromJson(Map<String, dynamic> json) {
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

 
}
