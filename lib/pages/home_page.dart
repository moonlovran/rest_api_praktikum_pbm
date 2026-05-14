import "package:flutter/material.dart";
import "../models/product_model.dart";
import "../services/api_service.dart";
import "add_product_page.dart";
import "submit_page.dart";

class HomePage extends StatefulWidget {
  final String token;
  HomePage({required this.token});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProdukModel> dataProduk = [];
  bool loading = true;

  void fetchData() async {
    setState(() => loading = true);

    var hasil = await ApiService().getProduk(widget.token);

    setState(() {
      dataProduk = hasil;
      loading = false;
    });
  }

  void klikHapus(int id) async {
    bool sukses = await ApiService().hapusProduk(widget.token, id);

    if (sukses) {
      fetchData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Berhasil dihapus")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Katalog Produk"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: fetchData,
          )
        ],
      ),

      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: dataProduk.length,
              itemBuilder: (ctx, i) {
                final item = dataProduk[i];

                return ListTile(
                  title: Text(item.namaProduk ?? "-"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Rp ${item.hargaProduk ?? '-'}"),
                      SizedBox(height: 4),
                      Text(
                        item.deskripsiProduk ?? "-",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      if (item.id != null) {
                        klikHapus(item.id!);
                      }
                    },
                  ),
                );
              },
            ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "1",
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddPage(token: widget.token),
                ),
              ).then((_) => fetchData());
            },
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "2",
            backgroundColor: Colors.teal,
            child: Icon(Icons.send),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SubmitPage(token: widget.token),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}