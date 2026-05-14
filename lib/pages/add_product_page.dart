import "package:flutter/material.dart";
import "../services/api_service.dart";

class AddPage extends StatelessWidget {
  final String token;
  AddPage({required this.token});

  final namaController = TextEditingController();
  final hargaController = TextEditingController();
  final descController = TextEditingController();

  void simpan(BuildContext context) async {
    bool ok = await ApiService().simpanDraft(token, namaController.text, hargaController.text, descController.text);
    if (ok) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah Produk")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: namaController, decoration: InputDecoration(labelText: "Nama")),
            TextField(controller: hargaController, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: "Harga")),
            TextField(controller: descController, decoration: InputDecoration(labelText: "Deskripsi")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () => simpan(context), child: Text("SIMPAN KE DRAFT"))
          ],
        ),
      ),
    );
  }
}