import "package:flutter/material.dart";
import "pages/login_page.dart";

void main() {
  runApp(MaterialApp (
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.teal,
      useMaterial3: true,
    ),
    home:login_page(),
  ));
}