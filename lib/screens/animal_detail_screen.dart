import 'package:flutter/material.dart';

class AnimalDetailScreen extends StatelessWidget {
  final String name;
  final String breed;
  final String age;
  final String description;
  final String imageUrl;

  const AnimalDetailScreen({
    Key? key,
    required this.name,
    required this.breed,
    required this.age,
    required this.description,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: Text("Detail $name", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.deepOrangeAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Bagian Konten Detail (Bisa di-scroll)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gambar Hewan Utama
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageUrl.startsWith('http') 
                            ? NetworkImage(imageUrl) as ImageProvider
                            : AssetImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                  // Konten Informasi teks
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        Text(
                          breed,
                          style: const TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 12),
                        
                        // Label Umur Hewan
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFEBE5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            age,
                            style: const TextStyle(color: Colors.deepOrangeAccent, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 10),
                        
                        const Text(
                          "Deskripsi",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          description,
                          style: const TextStyle(fontSize: 15, color: Colors.black54, height: 1.5),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Tombol Adopsi yang Menggantung di Bagian Bawah Layar
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 0,
                ),
                onPressed: () {
                  // Berpindah ke Halaman Form Adopsi
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdoptionFormScreen(animalName: name),
                    ),
                  );
                },
                icon: const Icon(Icons.pets, color: Colors.white),
                label: const Text(
                  "Adopsi Sekarang",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 2. HALAMAN FORM ADOPSI YANG BERFUNGSI TOTAL
// ==========================================
class AdoptionFormScreen extends StatefulWidget {
  final String animalName;
  const AdoptionFormScreen({Key? key, required this.animalName}) : super(key: key);

  @override
  State<AdoptionFormScreen> createState() => _AdoptionFormScreenState();
}

class _AdoptionFormScreenState extends State<AdoptionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _reasonController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Jika semua form valid, munculkan pop-up berhasil
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Row(
              children: const [
                Icon(Icons.check_circle, color: Colors.green, size: 28),
                SizedBox(width: 10),
                Text("Pengajuan Berhasil!", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Halo ${_nameController.text}, formulir adopsi Anda untuk ${widget.animalName} telah kami terima."),
                const SizedBox(height: 12),
                const Text(
                  "Tim kami akan segera memverifikasi data Anda dan menghubungi via WhatsApp. Terima kasih! 🐾",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Tutup dialog pop-up
                  Navigator.pop(context); // Kembali dari form ke halaman detail
                },
                child: const Text(
                  "Selesai",
                  style: TextStyle(color: Colors.deepOrangeAccent, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: const Text("Formulir Adopsi", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.deepOrangeAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ajukan Adopsi untuk ${widget.animalName}",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 6),
              const Text(
                "Lengkapi data di bawah ini untuk memulai proses adopsi resmi.",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),

              // Input Nama Lengkap
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Nama Lengkap Anda",
                  prefixIcon: const Icon(Icons.person_outline, color: Colors.deepOrangeAccent),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Mohon masukkan nama lengkap Anda';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Input Nomor WhatsApp
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Nomor WhatsApp Aktif",
                  prefixIcon: const Icon(Icons.phone_android_outlined, color: Colors.deepOrangeAccent),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Mohon masukkan nomor WhatsApp Anda';
                  }
                  if (value.length < 9) {
                    return 'Masukkan nomor WhatsApp yang valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Input Alasan
              TextFormField(
                controller: _reasonController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Alasan Ingin Mengadopsi",
                  prefixIcon: const Icon(Icons.chat_bubble_outline, color: Colors.deepOrangeAccent),
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Mohon berikan alasan singkat Anda';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 35),

              // Tombol Kirim Form Data
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrangeAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: _submitForm,
                  child: const Text(
                    "Kirim Pengajuan Adopsi",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}