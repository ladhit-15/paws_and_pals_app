import 'package:flutter/material.dart';
import '../models/animal.dart';
import '../services/api_service.dart';
import 'animal_detail_screen.dart'; // DIKUNCI: Memastikan import mengarah ke file baru
import 'report_screen.dart';
// Menghubungkan navigasi ke 3 fitur form baru pendukung laporan praktikum
import 'profile_screen.dart';
import 'donation_screen.dart';
import 'rescue_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Animal>> _futureAnimals;

  @override
  void initState() {
    super.initState();
    _futureAnimals = _apiService.fetchAnimals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: const Text("Paws & Pals", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.deepOrangeAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      
      // ===================================================================
      // SIDEBAR MENU / DRAWER SUPER LENGKAP & INTERAKTIF (Materi 4, 8, & 9)
      // ===================================================================
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepOrangeAccent, Colors.orange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.pets, size: 40, color: Colors.deepOrangeAccent),
              ),
              accountName: const Text(
                "Radhitya Prasetjadi", 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
              ),
              accountEmail: const Text("radhitya@student.univ.ac.id"),
            ),
            
            // KELOMPOK MENU 1: AKTIVITAS UTAMA
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 10, bottom: 5),
              child: Text("MENU UTAMA", style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 1)),
            ),
            ListTile(
              leading: const Icon(Icons.home_rounded, color: Colors.deepOrangeAccent),
              title: const Text("Beranda Adopsi", style: TextStyle(fontWeight: FontWeight.w500)),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.add_a_photo_rounded, color: Colors.teal),
              title: const Text("Form Lapor Hewan", style: TextStyle(fontWeight: FontWeight.w500)),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportScreen()));
              },
            ),
            
            const Divider(indent: 16, endIndent: 16),
            
            // KELOMPOK MENU 2: FITUR PENDUKUNG REAL FORM (Materi 9 - Routing Halaman Baru)
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 5, bottom: 5),
              child: Text("FITUR PENDUKUNG", style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 1)),
            ),
            ListTile(
              leading: const Icon(Icons.account_box_rounded, color: Colors.blue),
              title: const Text("Profil Saya", style: TextStyle(fontWeight: FontWeight.w500)),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.volunteer_activism_rounded, color: Colors.pink),
              title: const Text("Donasi Peduli Paws", style: TextStyle(fontWeight: FontWeight.w500)),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DonationScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_support_rounded, color: Colors.purple),
              title: const Text("Hubungi Rescue Team", style: TextStyle(fontWeight: FontWeight.w500)),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RescueScreen()));
              },
            ),
            
            const Divider(indent: 16, endIndent: 16),
            
            // KELOMPOK MENU 3: SISTEM & INFORMASI
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 5, bottom: 5),
              child: Text("SISTEM", style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 1)),
            ),
            ListTile(
              leading: const Icon(Icons.settings_rounded, color: Colors.blueGrey),
              title: const Text("Pengaturan Aplikasi", style: TextStyle(fontWeight: FontWeight.w500)),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Aplikasi saat ini dikunci menggunakan Light Theme bawaan.")),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline_rounded, color: Colors.orange),
              title: const Text("Tentang Aplikasi", style: TextStyle(fontWeight: FontWeight.w500)),
              onTap: () {
                Navigator.pop(context);
                showAboutDialog(
                  context: context,
                  applicationName: 'Paws & Pals App',
                  applicationVersion: '1.4.0 (Full Features Build)',
                  applicationIcon: const Icon(Icons.pets, color: Colors.deepOrangeAccent),
                  children: [
                    const Text("Aplikasi Tugas Mandiri Pemrograman Mobile Cross-Platform dengan Integrasi Komponen Multi-form, Akses Penyimpanan Media Lokal, dan State Management Dinamis."),
                  ],
                );
              },
            ),
          ],
        ),
      ),

      body: FutureBuilder<List<Animal>>(
        future: _futureAnimals,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Gagal mengambil data server API"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Data kosong"));
          }

          List<Animal> animals = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Colors.orange, Colors.deepOrangeAccent]),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Temukan Sahabat Baru", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                            SizedBox(height: 5),
                            Text("Adopsi hewan terlantar di sekitar Anda.", style: TextStyle(color: Colors.white70)),
                          ],
                        ),
                      ),
                      Icon(Icons.pets, size: 50, color: Colors.white24)
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Text("Hewan Tersedia", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey[900])),
                const SizedBox(height: 15),
                
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: animals.length,
                  itemBuilder: (context, index) {
                    final pet = animals[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            // SYSTEM FIX: Menghubungkan klik card utama ke halaman AnimalDetailScreen baru
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AnimalDetailScreen(
                                  name: pet.name,
                                  breed: pet.breed,
                                  age: pet.age,
                                  description: pet.description,
                                  imageUrl: pet.image,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Image.network(pet.image, fit: BoxFit.cover, width: double.infinity),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(pet.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                        IconButton(
                                          constraints: const BoxConstraints(),
                                          padding: EdgeInsets.zero,
                                          icon: Icon(
                                            pet.isFavorite ? Icons.favorite : Icons.favorite_border,
                                            color: pet.isFavorite ? Colors.red : Colors.grey,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              pet.isFavorite = !pet.isFavorite;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Text(pet.breed, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportScreen()));
        },
        label: const Text("Lapor Hewan", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.add_a_photo, color: Colors.white),
        backgroundColor: Colors.teal,
      ),
    );
  }
}