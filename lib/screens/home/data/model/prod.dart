class Prod {
  final String name;
  final String price;
  final int id;
  final List<ProductImage> images;
  final bool featured;
  final int ratingCount;
  final String shortDesc;

  Prod({
    required this.images,
    required this.name,
    required this.price,
    required this.id,
    required this.featured,
    required this.ratingCount,
    required this.shortDesc,
  });

  factory Prod.fromJson(Map<String, dynamic> json) {
    return Prod(
      images: (json['images'] as List)
          .map((img) => ProductImage.fromJson(img))
          .toList(),
      name: json['name'] ?? '',
      price: json['price'] ?? '',
      id: json['id'] ?? '',
      featured: json['featured'] ?? false,
      ratingCount: json['rating_count'] ?? 0,
      shortDesc: json['short_description'] ?? '',
    );
  }
}

class ProductImage {
  final int id;
  final String src;
  final String name;
  final String alt;

  ProductImage({
    required this.id,
    required this.src,
    required this.name,
    required this.alt,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'] ?? 0,
      src: json['src'] ?? '',
      name: json['name'] ?? '',
      alt: json['alt'] ?? '',
    );
  }
}
