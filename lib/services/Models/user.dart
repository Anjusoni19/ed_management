class Album {
  final String userId;
  final String subdomain;
  final String token;

  const Album({
    required this.userId,
    required this.subdomain,
    required this.token,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
    {
      'userId': String userId,
    'id': String id,
    'title': String title,
    } =>
    Album(
    userId: userId,
    subdomain: id,
    token: title,
    ),
    _ => throw const FormatException('Failed to load album.'),
  };
  }
}