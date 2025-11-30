import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puxaconversa_app/ui/home/home_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:puxaconversa_app/data/models/question_model.dart';
import 'game_viewmodel.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key, required this.categoryIds});

  final List<int> categoryIds;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Após instanciar a ViewModel, é necessário chamar a função para carregar
      // as categorias na variável presente nele (_allCategories, na ViewModel)
      create: (context) => GameViewModel()..loadQuestions(categoryIds),
      // Consome o ViewModel, aguardando mudanças no estado para mudar a UI
      child: Consumer<GameViewModel>(
        builder: (context, viewModel, child) {
          return _buildScreen(context, viewModel);
        },
      ),
    );
  }

  Widget _buildScreen(BuildContext context, GameViewModel viewModel) {
    // Para o controle do botão de "voltar" do dispositivo móvel
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        // Como canPop é falso (não volta automaticamente, exibe tela de confirmação)
        if (!didPop) {
          _onExitGamePressed(context);
        }
      },

      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.0),

            child: Column(
              // Duas porções principais da UI: botões de header e cartas
              children: <Widget>[
                _buildHeaderOptions(context, viewModel),
                Expanded(child: _buildCardArea(context, viewModel)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderOptions(BuildContext context, GameViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: <Widget>[
        Flexible(
          child: TextButton.icon(
            icon: Icon(Icons.undo, applyTextScaling: true),
            label: AutoSizeText(
              'Pergunta anterior',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
              wrapWords: false,
              maxLines: 2,
            ),
            style: TextButton.styleFrom(
              disabledForegroundColor: Colors.grey.shade500,
            ),
            onPressed: viewModel.isPreviousButtonDisabled
                ? null
                : () => viewModel.unswipeCard(),
          ),
        ),

        Flexible(
          child: TextButton.icon(
            icon: Icon(Icons.exit_to_app, applyTextScaling: true),
            label: AutoSizeText(
              'Encerrar partida',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                height: 1.2,
                color: Colors.red.shade800,
              ),
              textAlign: TextAlign.center,
              wrapWords: false,
              maxLines: 2,
            ),
            style: TextButton.styleFrom(iconColor: Colors.red.shade800),
            onPressed: () => _onExitGamePressed(context),
          ),
        ),
      ],
    );
  }

  Widget _buildCardArea(BuildContext context, GameViewModel viewModel) {
    // Caso a busca inicial das perguntas em loadQuestions ainda esteja sendo
    // feita, espera pela mudança de estado (notificada pela função)
    if (viewModel.shuffledQuestions.isEmpty && !viewModel.isFinished) {
      return Center(child: CircularProgressIndicator());
    }
    // Stack para permitir Widgets sobrepostos (carta e mensagem de fim)
    return Stack(
      alignment: Alignment.center,

      children: <Widget>[
        // Carta
        AppinioSwiper(
          controller: viewModel.swiperController,
          cardCount: viewModel.shuffledQuestions.length,
          backgroundCardOffset: Offset(0, 45),
          cardBuilder: (context, index) {
            // Cada carta possui a pergunta e a ordem dela no baralho
            return QuestionCard(
              question: viewModel.shuffledQuestions[index],
              cardIndex: index + 1,
              totalCards: viewModel.shuffledQuestions.length,
            );
          },
          onSwipeEnd: viewModel.onCardSwiped,
          onEnd: viewModel.onCardsEnd,
        ),

        // Mensagem de fim
        if (viewModel.isFinished)
          AutoSizeText(
            'Fim das cartas!',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
      ],
    );
  }

  void _onExitGamePressed(BuildContext context) {
    // Exibe um diálogo de confirmação
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          elevation: 10.0,
          shadowColor: Colors.black,
          actionsAlignment: MainAxisAlignment.spaceAround,
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.red.shade800,
            applyTextScaling: true,
          ),
          title: Text(
            'Deseja encerrar a partida atual?',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),

          actions: <Widget>[
            TextButton(
              // Fecha o diálogo
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },

              child: Text(
                'Não',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ),

            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red.shade800),
              // Fecha o diálogo e a tela de jogo, voltando à tela inicial
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (Route<dynamic> route) => false,
                );
              },

              child: Text(
                'Sim',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
      barrierDismissible: true,
    );
  }
}

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.question,
    required this.cardIndex,
    required this.totalCards,
  });
  final Question question;
  final int cardIndex;
  final int totalCards;

  @override
  Widget build(BuildContext context) {
    // Estilização da carta
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25),

      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 5),
              blurRadius: 7,
              spreadRadius: 1,
            ),
          ],
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(25),

        // Conteúdo escrito na carta
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: AutoSizeText(
                  question.content,
                  style: TextStyle(fontSize: 18.sp, height: 1.3),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                  wrapWords: false,
                ),
              ),
            ),

            AutoSizeText(
              '$cardIndex/$totalCards',
              style: TextStyle(fontSize: 16.sp, color: Colors.grey),
              textScaleFactor: 1.0,
            ),
          ],
        ),
      ),
    );
  }
}
