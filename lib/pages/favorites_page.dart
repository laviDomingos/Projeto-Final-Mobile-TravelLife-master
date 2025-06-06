import 'package:flutter/material.dart';
import '../models/trip.dart';

class FavoriteTripsPage extends StatelessWidget {
  final List<Trip> trips;
  final Set<int> favoriteTrips;
  final bool isDarkMode;

  const FavoriteTripsPage({
    Key? key,
    required this.trips,
    required this.favoriteTrips,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteList =
        trips.where((trip) => favoriteTrips.contains(trip.id)).toList();

    final backgroundColor = isDarkMode ? Colors.black : const Color(0xFFF5F5F5);
    final cardColor = isDarkMode ? Colors.grey[900] : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        // REMOVIDO: botão de alternar tema
      ),
      backgroundColor: backgroundColor,
      body:
          favoriteList.isEmpty
              ? Center(
                child: Text(
                  'Nenhum favorito ainda!',
                  style: TextStyle(color: textColor),
                ),
              )
              : ListView.builder(
                itemCount: favoriteList.length,
                itemBuilder: (context, index) {
                  final trip = favoriteList[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    child: Card(
                      color: cardColor,
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
                                color: textColor,
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
                              style: TextStyle(fontSize: 16, color: textColor),
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
