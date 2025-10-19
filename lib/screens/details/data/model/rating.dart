class Rating {
  final bool success;
  final num? averageRating;
  final num? totalRaters;
  final String message;
  Rating({
    this.averageRating,
    required this.message,
    required this.success,
    this.totalRaters,
  });
  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      averageRating: json['average_rating'],
      message: json['message'],
      success: json['success'],
      totalRaters: json['total_raters'],
    );
  }
}
