import 'package:marketing_dentista/core/core.dart';
import 'package:marketing_dentista/core/theme/app_colors.dart';
import 'package:marketing_dentista/core/theme/app_text_style.dart';
import 'package:marketing_dentista/features/categorias/view_model/categoria_view_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoriaView extends StatefulWidget {
  const CategoriaView({super.key});

  @override
  State<CategoriaView> createState() => _CategoriaViewState();
}

class _CategoriaViewState extends State<CategoriaView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchCategorias();
    });
    super.initState();
  }

  _fetchCategorias() async {
    final viewModel = context.read<CategoriaViewModel>();
    if (viewModel.categorias.isNotEmpty) {
      return;
    }

    await viewModel.fetchCategorias();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<CategoriaViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 120,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: AppColors.onContainer,
          child: const Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              'Categorias',
              style: AppTextStyle.title,
            ),
          ),
        ),
        Expanded(
          child: AnimatedBuilder(
              animation: viewModel,
              builder: (context, _) {
                return _buildBody(viewModel);
              }),
        ),
      ],
    );
  }

  Widget _buildBody(CategoriaViewModel viewModel) {
    switch (viewModel.state) {
      case ViewState.initial:
        return const ViewInitial();
      case ViewState.loading:
        return const ViewLoading();
      case ViewState.loaded:
        return const ViewLoaded();
      case ViewState.error:
        return const ViewError();
      default:
        return const SizedBox();
    }
  }
}

class ViewError extends StatelessWidget {
  const ViewError({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CategoriaViewModel>();
    return Center(
      child: Text(viewModel.errorMessage),
    );
  }
}

class ViewLoaded extends StatelessWidget {
  const ViewLoaded({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CategoriaViewModel>();
    return ListView.separated(
      itemCount: viewModel.categorias.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final categoria = viewModel.categorias[index];
        return InkWell(
          onTap: () {
            viewModel.filterCategory(context, categoria.name);
          },
          child: ListTile(
            title: Text(categoria.name,
                style: AppTextStyle.body.copyWith(
                  color: AppColors.primary,
                )),
          ),
        );
      },
    );
  }
}

class ViewLoading extends StatelessWidget {
  const ViewLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 4,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (contex, index) {
        return const Skeletonizer(
          enabled: true,
          child: ListTile(
            title: Text('Example Example Example'),
          ),
        );
      },
    );
  }
}

class ViewInitial extends StatelessWidget {
  const ViewInitial({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
