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
  final num totalRateers;
  final bool isAccredited;
  final List<String> comments;

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
    required this.totalRateers,
    required this.isAccredited,
    required this.comments,
  });

  factory Workshop.fromJson(Map<String, dynamic> json) {
    return Workshop(
      comments: (json['comments'] is List)
          ? (json['comments'] as List<dynamic>)
                .map((e) => e.toString())
                .toList()
          : [],
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
      totalRateers: json['total_raters'] ?? 0,
      isAccredited: json['is_accredited'] ?? false,
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
}
