import "dart:convert";
import "package:http/http.dart" as http;
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "../models/product_model.dart";

class ApiService {
  final String baseUrl = "https://task.itprojects.web.id";
  final storage = const FlutterSecureStorage();

  Future<String?> loginUser(String nim) async {
    var url = Uri.parse("$baseUrl/api/auth/login");
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json", "Accept": "application/json"},
      body: jsonEncode({"username": nim, "password": nim}),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String token = data["data"]["token"];
      await storage.write(key: "token_praktikum", value: token);
      return token;
    }
    return null;
  }

  Future<List<ProdukModel>> getProduk(String token) async {
    var url = Uri.parse("$baseUrl/api/products");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token", "Accept": "application/json"},
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      List rawData = jsonResponse["data"]["products"];
      
      List<ProdukModel> hasil = [];
      for (int i = 0; i < rawData.length; i++) {
        var item = rawData[i];
        hasil.add(ProdukModel.fromJson(item));
      }
      return hasil;
    }
    return [];
  }

  Future<bool> simpanDraft(String token, String nama, String harga, String desc) async {
    var url = Uri.parse("$baseUrl/api/products");
    var response = await http.post(
      url,
      headers: {"Authorization": "Bearer $token", "Content-Type": "application/json"},
      body: jsonEncode({
        "name": nama,
        "price": int.tryParse(harga) ?? 0,
        "description": desc,
      }),
    );
    return response.statusCode == 200 || response.statusCode == 201;
  }

  Future<bool> hapusProduk(String token, int id) async {
    var url = Uri.parse("$baseUrl/api/products/$id");
    var response = await http.delete(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    return response.statusCode == 200;
  }
  
  Future<bool> submitFinal(String token, String nama, String harga, String desc, String github) async {
    var url = Uri.parse("$baseUrl/api/products/submit");
    var response = await http.post(
      url,
      headers: {"Authorization": "Bearer $token", "Content-Type": "application/json"},
      body: jsonEncode({
        "name": nama,
        "price": int.tryParse(harga) ?? 0,
        "description": desc,
        "github_url": github,
      }),
    );
    return response.statusCode == 200 || response.statusCode == 201;
  }
}