import "package:flutter/material.dart";
import "../services/api_service.dart";
import "home_page.dart";

class login_page extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<login_page> {
  final nimController = TextEditingController();
  final passController = TextEditingController();
  bool isLoading = false;

  void aksiLogin() async {

    if (nimController.text.isEmpty || passController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("NIM sama Password diisi dulu ya!"))
      );
      return;
    }

    setState(() => isLoading = true);
    String? token = await ApiService().loginUser(nimController.text);
    setState(() => isLoading = false);

    if (token != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage(token: token)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login gagal, cek NIM lagi")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Masuk Praktikum PBM")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: nimController, decoration: InputDecoration(labelText: "Masukkan NIM")),
            TextField(controller: passController, obscureText: true, decoration: InputDecoration(labelText: "Masukkan Password")),
            SizedBox(height: 20),
            isLoading ? CircularProgressIndicator() : ElevatedButton(onPressed: aksiLogin, child: Text("LOGIN"))
          ],
        ),
      ),
    );
  }
}