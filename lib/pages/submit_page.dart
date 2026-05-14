import "package:flutter/material.dart";
import "../services/api_service.dart";

class SubmitPage extends StatelessWidget {
  final String token;
  SubmitPage({required this.token});

  final namaController = TextEditingController();
  final hargaController = TextEditingController();
  final descController = TextEditingController();
  final githubController = TextEditingController();

  void kirim(BuildContext context) async {
    if (!githubController.text.contains("github.com")) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Link GitHub tidak valid!")));
      return;
    }
    bool ok = await ApiService().submitFinal(token, namaController.text, hargaController.text, descController.text, githubController.text);
    if (ok) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Tugas Berhasil Disubmit!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Submit Tugas")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: namaController, decoration: InputDecoration(labelText: "Nama")),
            TextField(controller: hargaController, decoration: InputDecoration(labelText: "Harga")),
            TextField(controller: descController, decoration: InputDecoration(labelText: "Deskripsi")),
            TextField(controller: githubController, decoration: InputDecoration(labelText: "GitHub URL")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () => kirim(context), child: Text("SUBMIT TUGAS SEKARANG"))
          ],
        ),
      ),
    );
  }
}