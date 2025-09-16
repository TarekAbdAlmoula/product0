class Workshop {
  String title;
  String content;
  String code;
  bool isFeatured;
  String featuredImageUrl;
  String phoneNumner;
  Workshop({
    required this.title,
    required this.content,
    required this.code,
    required this.isFeatured,
    required this.featuredImageUrl,
    required this.phoneNumner,
  });
  factory Workshop.fromJson(Map<String, dynamic> json) {
    return Workshop(
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      code: json['workshop_code'] ?? '',
      isFeatured: json['is_featured'] ?? false,
      featuredImageUrl: json['featured_image_url'] ?? '',
      phoneNumner: json['phone_number'] ?? '',
    );
  }
}
