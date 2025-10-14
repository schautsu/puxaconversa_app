import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),

          child: Column(
            children: <Widget>[
              AutoSizeText(
                'Créditos',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 1,
              ),

              const SizedBox(height: 20),

              Expanded(child: _buildMainContent(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    final scrollController = ScrollController();

    // Estilos de texto responsivos
    final defaultStyle = TextStyle(fontSize: 17.sp);
    final boldStyle = TextStyle(fontWeight: FontWeight.bold);
    final sectionTitleStyle = TextStyle(
      fontSize: 19.sp,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.primary,
    );

    return Scrollbar(
      thickness: 4.0,
      radius: const Radius.circular(8.0),

      child: FadingEdgeScrollView.fromSingleChildScrollView(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          controller: scrollController,

          child: Column(
            children: <Widget>[
              // Seção INSTITUIÇÃO
              AutoSizeText(
                'INSTITUIÇÃO',
                style: sectionTitleStyle,
                textAlign: TextAlign.center,
              ),
              AutoSizeText(
                'UNIVERSIDADE ESTADUAL DE MATO GROSSO DO SUL\n'
                'UNIDADE UNIVERSITÁRIA DE DOURADOS\n'
                'PROGRAMA DE PÓS-GRADUAÇÃO STRICTO SENSU ENSINO EM SAÚDE\n'
                'MESTRADO PROFISSIONAL\n',
                style: defaultStyle,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16), // Espaçamento entre seções
              // Seção JOGO EDUCATIVO
              AutoSizeText(
                'Jogo Educativo',
                style: sectionTitleStyle,
                textAlign: TextAlign.center,
              ),
              AutoSizeText.rich(
                style: defaultStyle,
                textAlign: TextAlign.center,

                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          'Produto Educativo: Jogo Puxa-Conversa: Envelhecimento Humano e Qualidade de Vida. 2024\n\n',
                    ),

                    TextSpan(
                      text: 'Roteiro/Design Gráfico/Revisão de conteúdo\n',
                      style: boldStyle,
                    ),
                    TextSpan(
                      text:
                          'Técnica em Enfermagem Mestre Walkiria Nascimento Valadares de Campos. Hospital Universitário da Universidade Federal da Grande Dourados (HU-UFGD)\n\n',
                    ),

                    TextSpan(
                      text: 'Orientadora/Revisão de conteúdo/Testes\n',
                      style: boldStyle,
                    ),
                    TextSpan(
                      text: 'Profa. Dra. Márcia Maria de Medeiros - UEMS\n',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16), // Espaçamento entre seções
              // Seção JOGO EDUCATIVO DIGITAL
              AutoSizeText(
                'Jogo Educativo Digital',
                style: sectionTitleStyle,
                textAlign: TextAlign.center,
              ),
              AutoSizeText.rich(
                style: defaultStyle,
                textAlign: TextAlign.center,

                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          'Puxa-Conversa: Envelhecimento Humano e Qualidade de Vida. 2025.\n\n',
                    ),

                    TextSpan(text: 'Programador/Testes\n', style: boldStyle),
                    TextSpan(
                      text:
                          'Vinícius Alves Schautz. Graduação em Ciência da Computação – UEMS\n\n',
                    ),

                    TextSpan(text: 'Orientadora\n', style: boldStyle),
                    TextSpan(text: 'Profa. Dra. Glaucia Gabriel – UEMS\n\n'),

                    TextSpan(text: 'Testes e Validação\n', style: boldStyle),
                    TextSpan(
                      text: 'Mestre Walkiria Nascimento Valadares de Campos.\n',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16), // Espaçamento entre seções
              // Seção TIPO DA LICENÇA
              AutoSizeText(
                'Tipo da Licença:',
                style: sectionTitleStyle,
                textAlign: TextAlign.center,
              ),
              AutoSizeText(
                'CC BY-NC-ND 4.0\n2025\n',
                style: defaultStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
