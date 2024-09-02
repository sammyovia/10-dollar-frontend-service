class HomwVideosModel {
  HomwVideosModel({
    required this.status,
    required this.data,
    required this.message,
  });
  late final bool status;
  late final List<HomeVideoModelData> data;
  late final String message;

  HomwVideosModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data']).map((e) => HomeVideoModelData.fromJson(e)).toList();
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

class HomeVideoModelData {
  HomeVideoModelData({
    required this.id,
    required this.title,
    required this.videoUrl,
    required this.likeCount,
    required this.voteCount,
    required this.createdAt,
  });
  late final String id;
  late final String title;
  late final String videoUrl;
  late final int likeCount;
  late final int voteCount;
  late final String createdAt;

  HomeVideoModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    videoUrl = json['videoUrl'];
    likeCount = json['likeCount'];
    voteCount = json['voteCount'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final datam = <String, dynamic>{};
    datam['id'] = id;
    datam['title'] = title;
    datam['videoUrl'] = videoUrl;
    datam['likeCount'] = likeCount;
    datam['voteCount'] = voteCount;
    datam['createdAt'] = createdAt;
    return datam;
  }
}
