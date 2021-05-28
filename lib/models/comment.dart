class Comment {
  final String by;
  final String comment;
  final DateTime time;
  final String placeId;

  Comment(
      {required this.placeId,
      required this.by,
      required this.comment,
      required this.time});
}
