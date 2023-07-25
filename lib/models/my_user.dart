class MyUser {
  MyUser({
    required this.image,
    required this.about,
    required this.name,
    required this.createdAt,
    required this.lastActive,
    required this.isOnline,
    required this.id,
    required this.email,
    required this.pushToken,
    required this.lat,
    required this.long,
  });

  late String image;
  late String about;
  late String name;
  late String createdAt;
  late String lastActive;
  late bool isOnline;
  late String id;
  late String email;
  late String pushToken;
  late double lat;
  late double long;

  MyUser.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
    about = json['about'] ?? '';
    name = json['name'] ?? '';
    createdAt = json['created_at'] ?? '';
    lastActive = json['last_active'] ?? '';
    isOnline = json['is_online'] ?? false;
    id = json['id'] ?? '';
    email = json['email'] ?? '';
    pushToken = json['push_token'] ?? '';
    lat = json['lat'] ?? 0.00000;
    long = json['long'] ?? 0.00000;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['about'] = about;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['last_active'] = lastActive;
    data['is_online'] = isOnline;
    data['id'] = id;
    data['email'] = email;
    data['push_token'] = pushToken;
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}