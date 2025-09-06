import 'package:flutter/material.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';

class InstructionsScreen extends StatelessWidget {
  const InstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),

          child: Column(
            children: <Widget>[
              // Título da página
              Text(
                'Instruções',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 20),

              Expanded(child: _buildMainContent(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    final scrollController = ScrollController();

    return Scrollbar(
      thickness: 2.0,
      radius: Radius.circular(8),

      child: FadingEdgeScrollView.fromSingleChildScrollView(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5),
          controller: scrollController,

          child: Column(
            children: <Widget>[
              // Parágrafo introdutório
              Text.rich(
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.justify,

                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          'O Puxa-Conversa é um jogo diferente e sem regras, com perguntas abertas que visam estimular boas conversas em torno do tema: ',
                    ),
                    TextSpan(
                      text: 'envelhecimento humano e qualidade de vida',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: '.\n'),
                  ],
                ),
              ),

              // Seção de orientações
              Text(
                'Como jogar\n',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),

              Text.rich(
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.justify,

                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: '1. ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: 'No menu principal, clique em '),
                    TextSpan(
                      text: 'Jogar',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: '.\n\n'),

                    TextSpan(
                      text: '2. ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          'Selecione as categorias de perguntas sobre as quais quer conversar e clique em ',
                    ),
                    TextSpan(
                      text: 'Começar',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: '.\n\n'),

                    TextSpan(
                      text: '3. ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          'Pense nas perguntas como uma pilha de cartas: ao arrastar uma carta, outra pergunta aparece!\n',
                    ),
                    TextSpan(
                      text:
                          'Você também pode voltar para perguntas anteriores ou encerrar o jogo a qualquer momento.\n',
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
