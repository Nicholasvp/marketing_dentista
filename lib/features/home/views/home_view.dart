import 'package:flutter_svg/svg.dart';
import 'package:marketing_dentista/core/core.dart';
import 'package:marketing_dentista/core/theme/app_assets.dart';
import 'package:marketing_dentista/features/categorias/view/categoria_view.dart';
import 'package:marketing_dentista/features/home/view_models/home_view_model.dart';
import 'package:marketing_dentista/features/product_search/views/product_search_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomeViewModel>();
    return Scaffold(
      body: AnimatedBuilder(
        animation: viewModel,
        builder: (context, _) {
          return _buildBody(viewModel.model.currentIndex);
        },
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: viewModel,
        builder: (context, _) {
          return AppBottomNavigation(
            currentIndex: viewModel.model.currentIndex,
            onTap: viewModel.setIndex,
          );
        },
      ),
    );
  }

  Widget _buildBody(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return const ProductSearchView();
      case 1:
        return const CategoriaView();
      case 2:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppAssets.add),
              const Text('Anunciar'),
            ],
          ),
        );
      case 3:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppAssets.favorite),
              const Text('Favoritos'),
            ],
          ),
        );
      case 4:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppAssets.user),
              const Text('Conta'),
            ],
          ),
        );
      default:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppAssets.add),
              const Text('Anunciar'),
            ],
          ),
        );
    }
  }
}
