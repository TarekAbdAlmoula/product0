class About {
  final String aboutUs;
  final List<String> features;
  final ContactInfo contactInfo;
  About({
    required this.aboutUs,
    required this.features,
    required this.contactInfo,
  });
  factory About.fromJson(Map<String, dynamic> json) {
    return About(
      aboutUs: json['about_us'] ?? '',
      features: json['features_app'].split('_'),
      contactInfo: ContactInfo.fromJson(json['contact_info']),
    );
  }
}

class ContactInfo {
  final String phone;
  final String email;
  final String website;
  ContactInfo({
    required this.phone,
    required this.email,
    required this.website,
  });
  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      website: json['website'] ?? '',
    );
  }
}
