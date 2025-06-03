import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = AuthService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center( // centraliza o conteúdo na tela
          child: Column(
            mainAxisSize: MainAxisSize.min, // para a coluna ficar só no tamanho necessário
            crossAxisAlignment: CrossAxisAlignment.center, // centraliza horizontalmente
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.account_circle, size: 100, color: Colors.grey),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_a_photo, color: Colors.black),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Função de adicionar foto (em breve...)')),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                user?.email ?? 'Usuário desconhecido',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              ElevatedButton.icon(
                icon: Icon(Icons.logout),
                label: Text('Sair'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () async {
                  await AuthService.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => LoginPage()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}