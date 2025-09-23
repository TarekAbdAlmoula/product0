class Premieum {
  String title;
  List<String> content;
  Premieum({required this.title, required this.content});

  factory Premieum.fromJson(Map<String, dynamic> json) {
    return Premieum(title: json['title'], content: json['content'].split('_'));
  }
}
