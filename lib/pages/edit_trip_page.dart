import 'package:flutter/material.dart';
import '../models/trip.dart';

class EditTripPage extends StatefulWidget {
  final Trip trip;

  const EditTripPage({super.key, required this.trip});

  @override
  State<EditTripPage> createState() => _EditTripPageState();
}

class _EditTripPageState extends State<EditTripPage> {
  late TextEditingController _imageController;
  late TextEditingController _descController;
  late TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _imageController = TextEditingController(text: widget.trip.imagePath);
    _descController = TextEditingController(text: widget.trip.description);
    _locationController = TextEditingController(text: widget.trip.location);
  }

  void _saveTrip() {
    if (_imageController.text.isNotEmpty &&
        _descController.text.isNotEmpty &&
        _locationController.text.isNotEmpty) {
      final updatedTrip = Trip(
        id: widget.trip.id,
        imagePath: _imageController.text,
        description: _descController.text,
        location: _locationController.text,
      );

      Navigator.pop(context, {'action': 'edit', 'trip': updatedTrip});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha todos os campos')),
      );
    }
  }

  void _deleteTrip() {
    Navigator.pop(context, {'action': 'delete', 'trip': widget.trip});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar Viagem')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _imageController,
              decoration: InputDecoration(
                labelText: 'URL da Foto',
                hintText: 'https://exemplo.com/foto.jpg',
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
            ElevatedButton(
              onPressed: _saveTrip,
              child: Text('Salvar Alterações'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _deleteTrip,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Excluir Viagem'),
            ),
          ],
        ),
      ),
    );
  }
}
