import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();

  void _login() {
    if (_usuarioController.text == 'teste' && _senhaController.text == '123') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuário ou senha inválidos')),
      );
    }
  }

@override
Widget build(BuildContext context) {
  return Theme(
    data: ThemeData.light(), // 👈 Força modo claro!
    child: Scaffold(
      // Retira o AppBar porque vamos botar o texto Travelife dentro do body
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo_escuro.png',
              height: 120,
              width: 120,
            ),
            SizedBox(height: 12), // espaçamento entre a logo e o texto
            Text(
              'Travelife',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 32),
            TextFormField(
              controller: _usuarioController,
              decoration: InputDecoration(
                labelText: 'Usuário',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _senhaController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                prefixIcon: Icon(Icons.lock_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
  onPressed: _login,
  style: ElevatedButton.styleFrom(
    minimumSize: Size(double.infinity, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    backgroundColor: Colors.black, // fundo preto
    foregroundColor: Colors.white, // texto branco
  ),
  child: Text('Entrar', style: TextStyle(fontSize: 18)),
),
            SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SignupPage()),
                );
              },
              child: Text('Cadastrar-se'),
            ),
          ],
        ),
      ),
    ),
  );
}
}