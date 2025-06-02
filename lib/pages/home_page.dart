import 'package:flutter/material.dart';
import 'create_trip_page.dart';
import 'settings_page.dart';
import '../models/trip.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Trip> trips = [
    // Exemplo de viagem inicial
    Trip(
      imagePath: 'https://picsum.photos/200',
      description: 'Visita incrível na praia',
      location: 'Rio de Janeiro',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diário de Bordo'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SettingsPage()));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: trips.length,
        itemBuilder: (context, index) {
          final trip = trips[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(trip.imagePath),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(trip.description),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, bottom: 8),
                  child: Text(
                    'Local: ${trip.location}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final newTrip = await Navigator.push<Trip>(
            context,
            MaterialPageRoute(builder: (_) => CreateTripPage()),
          );
          if (newTrip != null) {
            setState(() {
              trips.add(newTrip);
            });
          }
        },
      ),
    );
  }
}
