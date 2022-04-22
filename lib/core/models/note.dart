class Note {
  final String uid;
  String? title;
  String content;

  Note({
    required this.uid,
    required this.content,
    this.title,
  });
}
