class MyUser {
  static const String collectionName = 'users';
  final String? id, created_at, email, image, last_active, name, push_token;
  final bool? is_online;

  MyUser(
      {this.created_at,
      this.email,
      this.image,
      this.is_online,
      this.last_active,
      this.name,
      this.push_token,
      this.id});

  MyUser.fromFirestore(Map<String, dynamic> data)
      : this(
            id: data['id'],
            name: data['name'],
            image: data['image'],
            created_at: data['created_at'],
            email: data['email'],
            is_online: data['is_online'],
            last_active: data['last_active'],
            push_token: data['push_token']);

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'created_at': created_at,
      'email': email,
      'is_online': is_online,
      'last_active': last_active,
      'push_token': push_token
    };
  }
}
