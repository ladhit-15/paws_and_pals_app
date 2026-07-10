import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // DIKUNCI: Memasukkan package format input
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DonationScreen extends StatefulWidget {
  const DonationScreen({Key? key}) : super(key: key);

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _wishesController = TextEditingController();
  String _selectedMethod = 'Transfer Bank (VA)';
  File? _proofImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickProofImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _proofImage = File(pickedFile.path);
      });
    }
  }

  String _getPaymentInstruction() {
    if (_selectedMethod == 'Transfer Bank (VA)') {
      return "Bank Mandiri Virtual Account:\n8879 0818 7241 064 a.n Peduli Paws";
    } else {
      return "E-Wallet (Gopay / OVO):\n0812-3456-7890 a.n Yayasan Paws & Pals";
    }
  }

  void _submitDonation() {
    if (_formKey.currentState!.validate()) {
      if (_proofImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("⚠️ Mohon unggah bukti transfer terlebih dahulu!")),
        );
        return;
      }

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Row(
              children: const [
                Icon(Icons.volunteer_activism, color: Colors.pink),
                SizedBox(width: 10),
                Text("Donasi Berhasil! ❤️"),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Terima kasih atas bantuan Anda sebesar Rp ${_amountController.text}."),
                const SizedBox(height: 12),
                if (_wishesController.text.isNotEmpty) ...[
                  const Text("Pesan/Harapan Anda:", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('"${_wishesController.text}"', style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.grey)),
                ]
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Tutup dialog
                  Navigator.pop(context); // Kembali ke Beranda
                },
                child: const Text("Sama-sama", style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold)),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: const Text("Donasi Peduli Paws", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.pink,
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
              const Text("Dukung Operasional Penyelamatan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              const Text("Setiap rupiah yang Anda donasikan sangat berarti bagi hewan terlantar.", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 25),
              
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number, // Membuka keyboard angka murni
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly // SYSTEM LOCK: Hanya mengizinkan angka, titik otomatis diblokir!
                ],
                decoration: InputDecoration(
                  labelText: "Nominal Donasi (Masukkan Angka Saja, Misal: 10000)",
                  prefixIcon: const Icon(Icons.money, color: Colors.pink),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan nominal donasi';
                  }
                  return null; // Pengaman lolos validasi sukses
                },
              ),
              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                value: _selectedMethod,
                decoration: InputDecoration(
                  labelText: "Metode Pembayaran",
                  prefixIcon: const Icon(Icons.payment, color: Colors.pink),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
                items: ['Transfer Bank (VA)', 'E-Wallet (Gopay/OVO)']
                    .map((method) => DropdownMenuItem(value: method, child: Text(method)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedMethod = value!),
              ),
              const SizedBox(height: 15),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.pink.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.pink.withOpacity(0.2)),
                ),
                child: Text(_getPaymentInstruction(), style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 25),

              const Text("Upload Bukti Transfer", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 10),
              if (_proofImage != null)
                Container(
                  height: 180,
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(image: FileImage(_proofImage!), fit: BoxFit.cover),
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[800], foregroundColor: Colors.white),
                      onPressed: () => _pickProofImage(ImageSource.camera),
                      icon: const Icon(Icons.camera_alt),
                      label: const Text("Kamera"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[600], foregroundColor: Colors.white),
                      onPressed: () => _pickProofImage(ImageSource.gallery),
                      icon: const Icon(Icons.photo),
                      label: const Text("Galeri"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              TextFormField(
                controller: _wishesController,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: "Kata Harapan / Doa Anda (Opsional)",
                  prefixIcon: const Icon(Icons.favorite, color: Colors.pink),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pink, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                  onPressed: _submitDonation,
                  icon: const Icon(Icons.send, color: Colors.white),
                  label: const Text("Kirim Donasi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}