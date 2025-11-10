import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:puxaconversa_app/ui/category_selection/category_selection_screen.dart';
import 'package:puxaconversa_app/ui/instructions/instructions_screen.dart';
import 'package:puxaconversa_app/ui/about/about_screen.dart';

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
              const Spacer(flex: 1), // Espaçamento

              // Logos da UEMS e PPGES em linha
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: <Widget>[
                  Flexible(
                    child: Image.asset(
                      'assets/images/uems-logo.png',
                      height: 5.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Flexible(
                    child: Image.asset(
                      'assets/images/ppges-logo.jpg',
                      height: 5.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),

              const Spacer(flex: 1), // Espaçamento

              AutoSizeText(
                'PUXA-CONVERSA',
                style: TextStyle(fontSize: 26.sp, fontFamily: 'Tendang'),
                textAlign: TextAlign.center,
                maxLines: 1,
                wrapWords: false,
              ),

              const Spacer(flex: 1), // Espaçamento

              Image.asset('assets/images/app-logo.png', height: 20.h),

              AutoSizeText.rich(
                textAlign: TextAlign.center,
                wrapWords: false,

                TextSpan(
                  style: TextStyle(
                    fontSize: 19.sp,
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
              ),

              Align(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Color(0xff5f684b),
                    borderRadius: BorderRadius.circular(8.0),
                  ),

                  child: AutoSizeText(
                    'QUALIDADE DE VIDA',
                    style: TextStyle(
                      fontSize: 15.sp,
                      letterSpacing: 4.0,
                      color: Colors.white,
                      fontFamily: 'Gnuolane',
                    ),
                    maxLines: 1,
                    wrapWords: false,
                  ),
                ),
              ),

              const Spacer(flex: 1), // Espaçamento

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  padding: EdgeInsets.symmetric(vertical: 14.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CategorySelectionScreen(),
                    ),
                  );
                },

                child: AutoSizeText(
                  'Jogar',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 16), // Espaçamento fixo entre os botões

              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  side: BorderSide(color: Theme.of(context).colorScheme.primary),
                  padding: EdgeInsets.symmetric(vertical: 14.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InstructionsScreen(),
                    ),
                  );
                },

                child: AutoSizeText(
                  'Instruções',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const Spacer(flex: 1), // Espaçamento

              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  side: BorderSide(color: Theme.of(context).colorScheme.primary),
                  padding: EdgeInsets.symmetric(vertical: 7.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutScreen(),
                    ),
                  );
                },

                child: AutoSizeText(
                  'Sobre',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const Spacer(flex: 1), // Espaçamento
            ],
          ),
        ),
      ),
    );
  }
}
