import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:puxaconversa_app/ui/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const PuxaConversaApp());
}

class PuxaConversaApp extends StatelessWidget {
  const PuxaConversaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Puxa-Conversa',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff90c54c)),
        scaffoldBackgroundColor: Colors.grey[100],
        fontFamily: 'Geomatrix',
      ),
      home: const HomeScreen(),
    );
  }
}
