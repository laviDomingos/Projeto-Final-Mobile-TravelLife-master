import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://auosiyxfbtndyqrwrydw.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF1b3NpeXhmYnRuZHlxcndyeWR3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDg1NTQ1NjQsImV4cCI6MjA2NDEzMDU2NH0.d7rT64rPerePGrCpXDzuTlkGdns13F_0083ay2n2aUM',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color offWhite = const Color(0xFFF5F5F5);
  final Color offWhiteText = const Color(0xFFE0E0E0);
  final Color black = Colors.black;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diário de Bordo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: offWhite,
        primaryColor: black,
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
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: black,
        primaryColor: offWhite,
        appBarTheme: AppBarTheme(
          backgroundColor: black,
          foregroundColor: offWhite,
          elevation: 0,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: offWhiteText),
          bodyMedium: TextStyle(color: offWhiteText),
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
      ),
      themeMode: ThemeMode.system,
      home: LoginPage(),
    );
  }
}
