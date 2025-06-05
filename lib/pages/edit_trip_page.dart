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
    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(title: Text('Editar Viagem')),
        body: Padding(
          padding: EdgeInsets.all(24),
          child: ListView(
            children: [
              SizedBox(height: 16),
              TextFormField(
                controller: _imageController,
                decoration: InputDecoration(
                  labelText: 'URL da Foto',
                  hintText: 'https://exemplo.com/foto.jpg',
                  prefixIcon: Icon(Icons.image_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descController,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  prefixIcon: Icon(Icons.description_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Localização',
                  prefixIcon: Icon(Icons.location_on_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveTrip,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('Salvar Alterações', style: TextStyle(fontSize: 18)),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: _deleteTrip,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('Excluir Viagem', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
