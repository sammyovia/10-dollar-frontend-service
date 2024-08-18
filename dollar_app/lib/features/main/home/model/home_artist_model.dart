class HomeArtistModel {
  final int id;
  final String fullName;
  final String position;
  final String profilePic;
  final String description;
  final String image;
  final int stake;
  final int likes;

  HomeArtistModel(
      {required this.id,
      required this.fullName,
      required this.position,
      required this.profilePic,
      required this.description,
      required this.image,
      required this.stake,
      required this.likes});
}
