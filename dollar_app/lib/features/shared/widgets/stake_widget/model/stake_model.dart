class SelectedVideo {
  final String id;
  final String position;

  SelectedVideo(this.id, this.position);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectedVideo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          position == other.position;

  @override
  int get hashCode => id.hashCode ^ position.hashCode;

  @override
  String toString() {
    return '$id=> $position';
  }
}
