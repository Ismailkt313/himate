class User {
final String id;
final String phone;
final String? name;


User({required this.id, required this.phone, this.name});


factory User.fromJson(Map<String, dynamic> json) {
return User(
id: json['_id'] ?? json['id'] ?? '',
phone: json['phone'] ?? '',
name: json['name'],
);
}
}