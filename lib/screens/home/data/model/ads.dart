class Ads {
  final bool isSuccess;
  final String message;
  final List<DataAds> dataAds;
  Ads({required this.isSuccess, required this.message, required this.dataAds});

  factory Ads.fromJson(Map<String, dynamic> json) {
    return Ads(
      isSuccess: json['success'] ?? false,
      message: json['message'] ?? '',
      dataAds: (json['data'] as List)
          .map((ad) => DataAds.fromJson(ad))
          .toList(),
    );
  }
}

class DataAds {
  final int id;
  final String title;
  final String image;

  DataAds({required this.id, required this.title, required this.image});

  factory DataAds.fromJson(Map<String, dynamic> json) {
    return DataAds(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      image: json['featured_image'] ?? '',
    );
  }
}
