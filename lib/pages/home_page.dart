import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travellife_mobile/pages/edit_trip_page.dart';
import 'package:travellife_mobile/pages/favorites_page.dart';
import 'dart:convert';
import 'create_trip_page.dart';
import 'profile_page.dart';
import '../models/trip.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDarkMode = false;
  int _currentIndex = 0;

  List<Trip> trips = [];
  Set<int> favoriteTrips = {};
  int _lastId = 0;

  final Color offWhite = const Color(0xFFF5F5F5);
  final Color black = Colors.black;

  @override
  void initState() {
    super.initState();
    _loadTrips();
  }

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  void _addNewTrip(Trip trip) {
    setState(() {
      _lastId++;
      final tripWithId = Trip(
        id: _lastId,
        imagePath: trip.imagePath,
        description: trip.description,
        location: trip.location,
      );
      trips.add(tripWithId);
      _saveTrips();
    });
  }

  void _editTrip(Trip updatedTrip) {
    setState(() {
      final index = trips.indexWhere((t) => t.id == updatedTrip.id);
      if (index != -1) {
        trips[index] = updatedTrip;
        _saveTrips();
      }
    });
  }

  void _deleteTrip(Trip trip) {
    setState(() {
      trips.removeWhere((t) => t.id == trip.id);
      favoriteTrips.remove(trip.id);
      _saveTrips();
    });
  }

  Future<void> _saveTrips() async {
    final prefs = await SharedPreferences.getInstance();
    final tripList = trips.map((t) => jsonEncode(t.toJson())).toList();
    await prefs.setStringList('trips', tripList);
    await prefs.setInt('lastId', _lastId);
  }

  Future<void> _loadTrips() async {
    final prefs = await SharedPreferences.getInstance();
    final tripList = prefs.getStringList('trips') ?? [];

    setState(() {
      trips = tripList.map((t) => Trip.fromJson(jsonDecode(t))).toList();
      _lastId = prefs.getInt('lastId') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme =
        isDarkMode
            ? ThemeData.dark().copyWith(
              scaffoldBackgroundColor: black,
              appBarTheme: AppBarTheme(
                backgroundColor: black,
                foregroundColor: offWhite,
                elevation: 0,
              ),
              textTheme: TextTheme(
                bodyLarge: TextStyle(color: offWhite),
                bodyMedium: TextStyle(color: offWhite),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: offWhite,
                  foregroundColor: black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            )
            : ThemeData.light().copyWith(
              scaffoldBackgroundColor: offWhite,
              appBarTheme: AppBarTheme(
                backgroundColor: offWhite,
                foregroundColor: black,
                elevation: 0,
              ),
              textTheme: TextTheme(
                bodyLarge: TextStyle(color: black),
                bodyMedium: TextStyle(color: black),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: black,
                  foregroundColor: offWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            isDarkMode ? 'assets/logo_claro.png' : 'assets/logo_escuro.png',
            height: 42,
          ),
          backgroundColor: theme.appBarTheme.backgroundColor,
          foregroundColor: theme.appBarTheme.foregroundColor,
          actions: [
            IconButton(
              icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: toggleTheme,
            ),
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => ProfilePage(
                          isDarkMode: isDarkMode,
                          toggleTheme: toggleTheme,
                        ),
                  ),
                );
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: trips.length,
          itemBuilder: (context, index) {
            final trip = trips[index];
            final isFavorite = favoriteTrips.contains(trip.id);

            return GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EditTripPage(trip: trip)),
                );

                if (result != null && result is Map) {
                  if (result['action'] == 'edit') {
                    _editTrip(result['trip']);
                  } else if (result['action'] == 'delete') {
                    _deleteTrip(trip);
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          trip.location,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: isDarkMode ? Colors.white70 : Colors.black87,
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          trip.imagePath,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 250,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return Container(
                              height: 250,
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 250,
                              color: Colors.grey[300],
                              alignment: Alignment.center,
                              child: Icon(Icons.broken_image, size: 50),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          trip.description,
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                isDarkMode
                                    ? const Color.fromRGBO(224, 224, 224, 1)
                                    : Colors.black87,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color:
                                  isFavorite
                                      ? const Color.fromARGB(255, 0, 0, 0)
                                      : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                if (isFavorite) {
                                  favoriteTrips.remove(trip.id);
                                } else {
                                  favoriteTrips.add(trip.id);
                                }
                              });
                            },
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) async {
            setState(() {
              _currentIndex = index;
            });

            if (index == 1) {
              final newTrip = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CreateTripPage()),
              );

              if (newTrip != null && newTrip is Trip) {
                _addNewTrip(newTrip);
              }
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => FavoriteTripsPage(
                        isDarkMode: isDarkMode,
                        trips: trips,
                        favoriteTrips: favoriteTrips,
                      ),
                ),
              );
            }
          },
          backgroundColor: offWhite,
          selectedItemColor: black,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Criar'),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favoritos',
            ),
          ],
        ),
      ),
    );
  }
}
