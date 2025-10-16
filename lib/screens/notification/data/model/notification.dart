class Notifications {
  final String title;
  final String content;
  final String date;
  Notifications({
    required this.content,
    required this.date,
    required this.title,
  });
  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      content: json['content'],
      date: json['date'],
      title: json['title'],
    );
  }
}
