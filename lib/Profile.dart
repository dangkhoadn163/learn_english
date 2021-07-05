class Profile {
  final int userId;
  final int id;
  final String title;

  Profile({
    this.userId,
    this.id,
    this.title,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}
