import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
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

              AutoSizeText(
                'PUXA-CONVERSA',
                style: TextStyle(fontSize: 42, fontFamily: 'Tendang'),
                textAlign: TextAlign.center,
                maxLines: 1,
              ),

              const Spacer(flex: 1), // Espaçamento

              Image.asset('assets/images/app-logo.png', height: 150),

              AutoSizeText.rich(
                TextSpan(
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Geomatrix',
                  ),

                  children: <TextSpan>[
                    TextSpan(
                      text: 'ENVELHECIMENTO',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    TextSpan(
                      text: ' HUMANO',
                      style: TextStyle(color: Color(0xff77b155)),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                textScaleFactor: 1.0,
              ),

              Align(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color(0xff5f684b),
                    borderRadius: BorderRadius.circular(8),
                  ),

                  child: AutoSizeText(
                    'QUALIDADE DE VIDA',
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 4.0,
                      color: Colors.white,
                      fontFamily: 'Gnuolane',
                    ),
                    textScaleFactor: 1.0,
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
                    MaterialPageRoute(
                      builder: (context) => const CategorySelectionScreen(),
                    ),
                  );
                },

                child: const AutoSizeText(
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
                    MaterialPageRoute(
                      builder: (context) => const InstructionsScreen(),
                    ),
                  );
                },

                child: const AutoSizeText(
                  'Instruções',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              const Spacer(flex: 2), // Espaçamento
            ],
          ),
        ),
      ),
    );
  }
}
