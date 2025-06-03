import 'package:flutter/material.dart';
import '../models/trip.dart';

class CreateTripPage extends StatefulWidget {
  @override
  _CreateTripPageState createState() => _CreateTripPageState();
}

class _CreateTripPageState extends State<CreateTripPage> {
  final _imageController = TextEditingController();
  final _descController = TextEditingController();
  final _locationController = TextEditingController();

  void _saveTrip() {
    if (_imageController.text.isNotEmpty &&
        _descController.text.isNotEmpty &&
        _locationController.text.isNotEmpty) {

      // ⚠️ Criando Trip com ID "temporário", Home vai corrigir
      final newTrip = Trip(
        id: -1, // Placeholder, será substituído na HomePage
        imagePath: _imageController.text,
        description: _descController.text,
        location: _locationController.text,
      );

      Navigator.pop(context, newTrip);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha todos os campos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nova Viagem')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _imageController,
              decoration: InputDecoration(
                labelText: 'URL da Foto',
                hintText: 'https://example.com/foto.jpg',
              ),
            ),
            TextField(
              controller: _descController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Localização'),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _saveTrip, child: Text('Salvar')),
          ],
        ),
      ),
    );
  }
}