import 'dart:convert';
import '../models/animal.dart';

class ApiService {
  // Simulasi mengambil data dari REST API Asynchronous
  Future<List<Animal>> fetchAnimals() async {
    // Meniru delay network internet selama 1 detik
    await Future.delayed(const Duration(seconds: 1));

    // Simulasi Response JSON String dari server API
    String responseBody = '''
    [
      {
        "id": 1,
        "name": "Milo",
        "breed": "Golden Retriever",
        "age": "2 Tahun",
        "image": "https://images.unsplash.com/photo-1552053831-71594a27632d?q=80&w=500",
        "description": "Anjing yang sangat ramah, suka bermain bola, sudah divaksin lengkap, dan sangat patuh pada perintah dasar."
      },
      {
        "id": 2,
        "name": "Luna",
        "breed": "Persian Cat",
        "age": "1 Tahun",
        "image": "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?q=80&w=500",
        "description": "Luna sangat tenang, suka bermanja-manja di sofa, mandiri, dan mencari rumah yang hangat."
      },
      {
        "id": 3,
        "name": "Oliver",
        "breed": "Beagle",
        "age": "6 Bulan",
        "image": "https://images.unsplash.com/photo-1537151608828-ea2b11777ee8?q=80&w=500",
        "description": "Anak anjing yang aktif, penuh energi, dan sangat cocok untuk menemani aktivitas lari pagi keluarga Anda."
      }
    ]
    ''';

    // Parsing JSON ke dalam List Object Animal
    List<dynamic> parsedJson = jsonDecode(responseBody);
    return parsedJson.map((json) => Animal.fromJson(json)).toList();
  }
}