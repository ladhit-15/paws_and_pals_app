// Materi 6: Membuat Mixin untuk kapabilitas pencatatan waktu otomatis
mixin Identifiable {
  String getTimestamp() {
    return DateTime.now().toString().split('.')[0];
  }
}

// Materi 6: Base Class dengan Inheritance mendasar
class BaseEntity {
  final int id;
  BaseEntity({required this.id});
}

// Materi 6: Class Animal mewarisi BaseEntity dan mengimplementasikan Mixin Identifiable
class Animal extends BaseEntity with Identifiable {
  final String name;
  final String breed;
  final String age;
  final String image;
  final String description;
  bool isFavorite;
  late String createdAt;

  Animal({
    required int id,
    required this.name,
    required this.breed,
    required this.age,
    required this.image,
    required this.description,
    this.isFavorite = false,
  }) : super(id: id) {
    createdAt = getTimestamp(); // Memanfaatkan fungsi milik mixin
  }

  // Materi 12: Konversi REST API Dummy JSON ke Object
  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      id: json['id'],
      name: json['name'],
      breed: json['breed'],
      age: json['age'],
      image: json['image'],
      description: json['description'],
    );
  }
}