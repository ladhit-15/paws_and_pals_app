import 'package:flutter/material.dart';

class RescueScreen extends StatefulWidget {
  const RescueScreen({Key? key}) : super(key: key);

  @override
  State<RescueScreen> createState() => _RescueScreenState();
}

class _RescueScreenState extends State<RescueScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: const Text("Hubungi Rescue Team", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.purple,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Laporan Darurat / Rescue",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text("Gunakan form ini jika melihat hewan dalam kondisi kritis, terluka parah, atau terjebak berbahaya yang butuh evakuasi segera.", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 25),

              // Input Nomor Telepon Pelapor
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Nomor Telepon Anda (WhatsApp)",
                  prefixIcon: const Icon(Icons.phone, color: Colors.purple),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan nomor telepon aktif';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Input Kondisi & Detail Lokasi
              TextFormField(
                controller: _descController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Deskripsi Kondisi & Patokan Lokasi",
                  prefixIcon: const Icon(Icons.location_on, color: Colors.purple),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon berikan detail kondisi singkat dan lokasi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              // Tombol Panggil
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Laporan Darurat Terkirim! Tim Evakuasi menuju lokasi. 🚨")),
                      );
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.contact_phone, color: Colors.white),
                  label: const Text("Hubungi Sekarang 📞", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}