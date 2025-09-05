import 'package:flutter/material.dart';
import 'package:puxaconversa_app/ui/category_selection/category_selection_screen.dart';
import 'package:puxaconversa_app/ui/instructions/instructions_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[
              const Spacer(flex: 2), // Espaçamento

              Text(
                'PUXA-CONVERSA',
                style: TextStyle(fontSize: 42, fontFamily: 'Tendang'),
                textAlign: TextAlign.center,
                textScaler: TextScaler.noScaling,
              ),

              const Spacer(flex: 1), // Espaçamento

              Image.asset(
                'assets/images/app-logo.png',
                height: 140,
              ),

              Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Geomatrix'
                  ),

                  children: <TextSpan>[
                    TextSpan(text: 'ENVELHECIMENTO', style: TextStyle(color: Colors.grey[700])),
                    TextSpan(text: ' HUMANO', style: TextStyle(color: Color(0xff77b155))),
                  ],
                ),
                textAlign: TextAlign.center,
                textScaler: TextScaler.noScaling,
              ),

              Align(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color(0xff5f684b),
                    borderRadius: BorderRadius.circular(8),
                  ),

                  child: Text(
                    'QUALIDADE DE VIDA',
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 4.0,
                      color: Colors.white,
                      fontFamily: 'Gnuolane',
                    ),
                    textScaler: TextScaler.noScaling,
                  ),
                ),
              ),
          
              const Spacer(flex: 1), // Espaçamento

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CategorySelectionScreen()),
                  );
                },

                child: const Text(
                  'Jogar',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 12), // Espaçamento fixo

              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const InstructionsScreen()),
                  );
                },

                child: const Text(
                  'Instruções',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              const Spacer(flex: 2), // Espaçamento
            ],
          ),
        )
        
      ),
    );
  }
}