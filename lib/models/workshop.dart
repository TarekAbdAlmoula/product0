class Workshop {
  final int id;
  final String title;
  final String content;
  final String excerpt;
  final String code;
  final bool isFeatured;
  final String featuredImageUrl;
  final String phoneNumber;
  final num rating;
  final String location;
  final List<String> gallery;
  final List<String> servicesCategory;

  Workshop({
    required this.id,
    required this.title,
    required this.content,
    required this.excerpt,
    required this.code,
    required this.isFeatured,
    required this.featuredImageUrl,
    required this.phoneNumber,
    required this.rating,
    required this.location,
    required this.gallery,
    required this.servicesCategory,
  });

  factory Workshop.fromJson(Map<String, dynamic> json) {
    return Workshop(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      excerpt: json['excerpt'] ?? '',
      code: json['workshop_code'] ?? '',
      isFeatured: json['is_featured'] ?? false,
      featuredImageUrl: json['featured_image_url'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      rating: (json['average_rating'] ?? 0) as num,
      location: json['location'] ?? '',
      gallery:
          (json['gallery'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      servicesCategory:
          (json['services_category'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'excerpt': excerpt,
      'workshop_code': code,
      'is_featured': isFeatured,
      'featured_image_url': featuredImageUrl,
      'phone_number': phoneNumber,
      'average_rating': rating,
      'location': location,
      'gallery': gallery,
      'services_category': servicesCategory,
    };
  }
}
