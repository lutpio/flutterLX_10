class UserImage {
  String id;
  final String username;
  final String images;

  UserImage({
    this.id = "",
    required this.username,
    required this.images,
  });

  factory UserImage.fromJson(Map<String, dynamic> json) {
    return UserImage(
      id: json['id'] as String,
      images: json['images'] as String,
      username: json['username'] as String,
    );
  }
}
