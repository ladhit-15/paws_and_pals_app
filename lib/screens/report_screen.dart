import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _formKey = GlobalKey<FormState>();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _simulatedGalleryImage;
  bool _isUploading = false;

  @override
  void dispose() {
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Simulasi asinkronus memilih foto dari galeri HP
  void _pickSimulatedImage() async {
    setState(() {
      _isUploading = true;
    });

    await Future.delayed(const Duration(milliseconds: 1000));

    setState(() {
      _isUploading = false;
      _simulatedGalleryImage = "https://images.unsplash.com/photo-1543466835-00a7907e9de1?q=80&w=500";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Gambar galeri lokal berhasil dimuat ke sistem! 🖼️")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: const Text("Form Laporan Kasus", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Center(
                child: Text(
                  "UNGGAH BUKTI FOTO DARI HP",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.teal.shade900, letterSpacing: 1),
                ),
              ),
              const SizedBox(height: 12),
              
              GestureDetector(
                onTap: _pickSimulatedImage,
                child: Container(
                  width: double.infinity,
                  height: 190,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.teal.shade200, width: 2),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
                  ),
                  child: _isUploading
                      ? const Center(child: CircularProgressIndicator(color: Colors.teal))
                      : _simulatedGalleryImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(13),
                              child: Image.network(_simulatedGalleryImage!, fit: BoxFit.cover, width: double.infinity),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.collections, size: 50, color: Colors.teal.shade400),
                                const SizedBox(height: 8),
                                const Text("Klik untuk Pilih Foto dari Galeri Anda", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
                              ],
                            ),
                ),
              ),
              const SizedBox(height: 25),
              
              Text(
                "DETAIL ISIAN LAPORAN",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.teal.shade900, letterSpacing: 1),
              ),
              const SizedBox(height: 15),
              
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: "Lokasi Detail Penemuan Hewan",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.pin_drop, color: Colors.teal),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Lokasi tidak boleh kosong!';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Deskripsi Deskriptif Kondisi Hewan",
                  hintText: "Contoh: Mengalami luka di kaki sebelah kanan, lemas di pinggir jalan...",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.edit_note, color: Colors.teal),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Deskripsi wajib ditulis!';
                  if (value.length < 10) return 'Tulis deskripsi lebih detail minimal 10 karakter!';
                  return null;
                },
              ),
              const SizedBox(height: 35),
              
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  if (_simulatedGalleryImage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Gagal: Foto bukti dari galeri wajib dimasukkan!")),
                    );
                    return;
                  }
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Sukses: Data laporan tersimpan ke database!")),
                    );
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.cloud_done),
                label: const Text("Kirim Laporan Valid", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }
}