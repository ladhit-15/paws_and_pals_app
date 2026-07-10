import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = "Radhitya Prasetjadi Wahana";
  String _email = "radhityawahana@gmail.com";
  String _role = "Anggota Pengadopsi & Penyelamat";
  File? _avatarImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickAvatar(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _avatarImage = File(pickedFile.path);
      });
    }
  }

  void _showEditDialog() {
    final nameCtrl = TextEditingController(text: _name);
    final emailCtrl = TextEditingController(text: _email);
    final roleCtrl = TextEditingController(text: _role);
    final editFormKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("Edit Profil Saya", style: TextStyle(fontWeight: FontWeight.bold)),
          content: Form(
            key: editFormKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(labelText: "Nama Lengkap"),
                    validator: (v) => v!.isEmpty ? "Nama tidak boleh kosong" : null,
                  ),
                  TextFormField(
                    controller: emailCtrl,
                    decoration: const InputDecoration(labelText: "Email"),
                    validator: (v) => v!.isEmpty ? "Email tidak boleh kosong" : null,
                  ),
                  TextFormField(
                    controller: roleCtrl,
                    decoration: const InputDecoration(labelText: "Status Peran"),
                    validator: (v) => v!.isEmpty ? "Status tidak boleh kosong" : null,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrangeAccent),
              onPressed: () {
                if (editFormKey.currentState!.validate()) {
                  setState(() {
                    _name = nameCtrl.text;
                    _email = emailCtrl.text;
                    _role = roleCtrl.text;
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Profil berhasil diperbarui! 🎉")),
                  );
                }
              },
              child: const Text("Simpan", style: TextStyle(color: Colors.white)),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: const Text("Profil Saya", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.deepOrangeAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_note_rounded, size: 28),
            onPressed: _showEditDialog,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 65,
                    backgroundColor: Colors.deepOrangeAccent.withOpacity(0.2),
                    backgroundImage: _avatarImage != null ? FileImage(_avatarImage!) : null,
                    child: _avatarImage == null
                        ? const Icon(Icons.person, size: 75, color: Colors.deepOrangeAccent)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.deepOrangeAccent,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => SafeArea(
                              child: Wrap(
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.camera_alt),
                                    title: const Text('Ambil via Kamera'),
                                    onTap: () { Navigator.pop(context); _pickAvatar(ImageSource.camera); },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.photo_library),
                                    title: const Text('Pilih dari Galeri'),
                                    onTap: () { Navigator.pop(context); _pickAvatar(ImageSource.gallery); },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(_name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87), textAlign: TextAlign.center), // SUDAH DIPERBAIKI DI SINI
            const SizedBox(height: 25),

            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    ListTile(
                      leading: const CircleAvatar(backgroundColor: Color(0xFFFFF0EC), child: Icon(Icons.email, color: Colors.deepOrangeAccent)),
                      title: const Text("Email", style: TextStyle(fontSize: 13, color: Colors.grey)),
                      subtitle: Text(_email, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
                    ),
                    const Divider(height: 20),
                    ListTile(
                      leading: const CircleAvatar(backgroundColor: Color(0xFFFFF0EC), child: Icon(Icons.assignment_ind, color: Colors.deepOrangeAccent)),
                      title: const Text("Status Peran", style: TextStyle(fontSize: 13, color: Colors.grey)),
                      subtitle: Text(_role, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}