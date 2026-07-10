import 'package:flutter/material.dart';

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
                Text("Halo ${_nameController.text}, formulir adopsi Anda untuk **${widget.animalName}** telah diterima."),
                const SizedBox(height: 12),
                const Text(
                  "Tim Paws & Pals akan segera menghubungi Anda melalui WhatsApp untuk tahap verifikasi lanjutan. 🐾",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Tutup dialog formulir sukses
                  Navigator.pop(context); // Kembali ke halaman detail hewan
                  Navigator.pop(context); // Kembali ke halaman utama (home)
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
                "Form Adopsi untuk ${widget.animalName}",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 6),
              const Text(
                "Isi data Anda dengan benar agar tim kami dapat memproses pengajuan kepemilikan peliharaan.",
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
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.deepOrangeAccent, width: 2),
                  ),
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
                  labelText: "Nomor WhatsAppAktif",
                  prefixIcon: const Icon(Icons.phone_android_outlined, color: Colors.deepOrangeAccent),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.deepOrangeAccent, width: 2),
                  ),
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

              // Input Alasan Adopsi
              TextFormField(
                controller: _reasonController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Alasan Mengadopsi ${widget.animalName}",
                  prefixIcon: const Icon(Icons.chat_bubble_outline, color: Colors.deepOrangeAccent),
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.deepOrangeAccent, width: 2),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Mohon tuliskan alasan singkat Anda mengadopsi';
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
                    elevation: 1,
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