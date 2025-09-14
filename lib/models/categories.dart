class Categories {
  final int id;
  final String name;
  final Image? image;
  Categories({required this.id, required this.name, this.image});

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['id'],
      name: json['name'],
      image: Image.fromJson(json['image']),
    );
  }
}

class Image {
  String id;
  String ulr;
  Image({required this.id, required this.ulr});
  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(id: json['id'], ulr: json['url']);
  }
}
