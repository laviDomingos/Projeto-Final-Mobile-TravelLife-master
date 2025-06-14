import 'package:flutter/material.dart';
import 'login_page.dart';
import '../services/auth_service.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _usuarioController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  bool _isLoading = false;

  Future<void> _signup() async {
    final usuario = _usuarioController.text.trim();
    final email = _emailController.text.trim();
    final senha = _senhaController.text.trim();

    if (usuario.isEmpty || email.isEmpty || senha.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Preencha todos os campos')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await AuthService.signUp(usuario, email, senha);

      setState(() => _isLoading = false);

      if (response.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cadastro realizado! Agora faça login.')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginPage()),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro no cadastro: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Cadastrar')),
        body: Padding(
          padding: EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
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
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
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
                  onPressed: _isLoading ? null : _signup,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child:
                      _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('Cadastrar', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
