import 'package:flutter/material.dart';
import '../models/trip.dart';

class FavoriteTripsPage extends StatelessWidget {
  final List<Trip> trips;
  final Set<int> favoriteTrips;

  const FavoriteTripsPage({
    Key? key,
    required this.trips,
    required this.favoriteTrips,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteList = trips.where((trip) => favoriteTrips.contains(trip.id)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
      ),
      body: favoriteList.isEmpty
          ? Center(child: Text('Nenhum favorito ainda!'))
          : ListView.builder(
              itemCount: favoriteList.length,
              itemBuilder: (context, index) {
                final trip = favoriteList[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Localização
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            trip.location,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        // Imagem
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            trip.imagePath,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 250,
                          ),
                        ),
                        // Descrição
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            trip.description,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}