class ProdukModel {
  int? id;
  String? namaProduk;
  String? hargaProduk;
  String? deskripsiProduk;

  ProdukModel({this.id, this.namaProduk, this.hargaProduk, this.deskripsiProduk});

  ProdukModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    namaProduk = json["name"];
    hargaProduk = json["price"].toString();
    deskripsiProduk = json["description"];
  }
}