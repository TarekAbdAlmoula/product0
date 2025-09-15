class Workshop {
  String title;
  String content;
  String code;
  bool isFeatured;
  String featuredImageUrl;
  Workshop({
    required this.title,
    required this.content,
    required this.code,
    required this.isFeatured,
    required this.featuredImageUrl,
  });
  factory Workshop.fromJson(Map<String, dynamic> json) {
    return Workshop(
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      code: json['workshop_code'] ?? '',
      isFeatured: json['is_featured'] ?? false,
      featuredImageUrl: json['featured_image_url'] ?? '',
    );
  }
}
