class Workshop {
  int id;
  String title;
  String content;
  String code;
  bool isFeatured;
  String featuredImageUrl;
  String phoneNumner;
  num rating;
  String location;
  Workshop({
    required this.id,
    required this.title,
    required this.content,
    required this.code,
    required this.isFeatured,
    required this.featuredImageUrl,
    required this.phoneNumner,
    required this.rating,
    required this.location,
  });
  factory Workshop.fromJson(Map<String, dynamic> json) {
    return Workshop(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      code: json['workshop_code'] ?? '',
      isFeatured: json['is_featured'] ?? false,
      featuredImageUrl: json['featured_image_url'] ?? '',
      phoneNumner: json['phone_number'] ?? '',
      rating: json['average_rating'] ?? 0,
      location: json['location'] ?? '',
    );
  }
}
