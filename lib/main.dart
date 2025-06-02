import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diário de Bordo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),  // começa na tela de login
      debugShowCheckedModeBanner: false,
    );
  }
}
