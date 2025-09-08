import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:puxaconversa_app/ui/game/game_screen.dart';
import 'category_selection_viewmodel.dart';

class CategorySelectionScreen extends StatelessWidget {
  const CategorySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Após instanciar a ViewModel, é necessário chamar a função para carregar
      // as categorias na variável presente nele (_allCategories, na ViewModel)
      create: (context) => CategorySelectionViewModel()..loadAllCategories(),
      // Consome o ViewModel, aguardando mudanças no estado para mudar a UI
      child: Consumer<CategorySelectionViewModel>(
        builder: (context, viewModel, child) {
          return _buildScreen(context, viewModel);
        },
      ),
    );
  }

  Widget _buildScreen(
    BuildContext context,
    CategorySelectionViewModel viewModel,
  ) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[
              AutoSizeText(
                'Selecione as categorias de perguntas',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                wrapWords: false,
                maxLines: 2,
              ),

              const SizedBox(height: 20), // Espaçamento

              _buildMainOptions(context, viewModel),

              const SizedBox(height: 10), // Espaçamento
              // Ocupa o espaço após as opções OU com um espaço vazio OU com a lista de categorias
              Expanded(
                child: viewModel.selectionMode == SelectionMode.custom
                    ? _buildCustomCategoryList(context, viewModel)
                    : SizedBox(),
              ),

              const SizedBox(height: 40), // Espaçamento

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  disabledBackgroundColor: Colors.grey.shade300,
                  disabledForegroundColor: Colors.grey.shade500,
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                // Só começa o jogo quando o botão está ativo (categorias selecionadas)
                onPressed: viewModel.isStartButtonDisabled
                    ? null
                    : () => _startGame(context, viewModel),

                child: AutoSizeText(
                  'Começar',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainOptions(
    BuildContext context,
    CategorySelectionViewModel viewModel,
  ) {
    final textSizeGroup = AutoSizeGroup();

    return Column(
      // Cria os selecionáveis com os valores do enum SelectionMode da ViewModel (all, custom)
      children: <Widget>[
        RadioListTile<SelectionMode>(
          title: AutoSizeText(
            'Todas as categorias',
            style: TextStyle(fontSize: 17.sp),
            maxLines: 1,
            group: textSizeGroup,
          ),
          groupValue: viewModel.selectionMode,
          value: SelectionMode.all,
          onChanged: (value) => viewModel.setSelectionMode(value!),
        ),

        RadioListTile<SelectionMode>(
          title: AutoSizeText(
            'Personalizar...',
            style: TextStyle(fontSize: 17.sp),
            maxLines: 1,
            group: textSizeGroup,
          ),
          groupValue: viewModel.selectionMode,
          value: SelectionMode.custom,
          onChanged: (value) => viewModel.setSelectionMode(value!),
        ),
      ],
    );
  }

  Widget _buildCustomCategoryList(
    BuildContext context,
    CategorySelectionViewModel viewModel,
  ) {
    final scrollController = ScrollController();

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(4.0),
      ),

      // Cria uma lista para as categorias existentes
      child: Scrollbar(
        controller: scrollController,
        thickness: 4.0,
        radius: Radius.circular(8.0),
        thumbVisibility: true,

        child: FadingEdgeScrollView.fromScrollView(
          child: ListView.builder(
            controller: scrollController,
            itemCount: viewModel.allCategories.length,
            // Detalhes de cada índice da lista (categoria, no caso)
            itemBuilder: (context, index) {
              final category = viewModel.allCategories[index];

              return CheckboxListTile(
                title: AutoSizeText(
                  category.name,
                  style: TextStyle(fontSize: 17.sp),
                  wrapWords: false,
                ),
                value: viewModel.isCategorySelected(category.id),
                activeColor: Theme.of(context).colorScheme.inverseSurface,
                onChanged: (value) => viewModel.toggleCategory(category.id),
              );
            },
          ),
        ),
      ),
    );
  }

  void _startGame(BuildContext context, CategorySelectionViewModel viewModel) {
    final categoryIds = viewModel.getCategoriesIdsForGame();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameScreen(categoryIds: categoryIds),
      ),
    );
  }
}
