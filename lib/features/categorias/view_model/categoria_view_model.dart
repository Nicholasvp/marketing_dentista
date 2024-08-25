import 'package:marketing_dentista/core/core.dart';
import 'package:marketing_dentista/core/utils/mock/categorias_mock.dart';
import 'package:marketing_dentista/features/categorias/model/categoria_model.dart';
import 'package:marketing_dentista/features/home/view_models/home_view_model.dart';
import 'package:marketing_dentista/features/product_search/view_models/product_view_model.dart';

class CategoriaViewModel extends ChangeNotifier {
  ViewState _state = ViewState.initial;
  List<CategoriaModel> _categorias = [];
  String _errorMessage = '';

  ViewState get state => _state;
  List<CategoriaModel> get categorias => _categorias;
  String get errorMessage => _errorMessage;

  Future<void> fetchCategorias() async {
    _setState(ViewState.loading);

    try {
      await Future.delayed(const Duration(seconds: 2));
      final respose = categoriasMock();
      _categorias = List<CategoriaModel>.from(
        respose.map((categoria) => CategoriaModel.fromMap(categoria)),
      );
      _setState(ViewState.loaded);
    } catch (e) {
      _errorMessage = 'Ocorreu um erro ao carregar as categorias.';
      _setState(ViewState.error);
    }
  }

  Future<void> filterCategory(BuildContext context, String category) async {
    final productViewModel = context.read<ProductViewModel>();
    final homeViewModel = context.read<HomeViewModel>();
    homeViewModel.setIndex(0);
    productViewModel.query = category;
  }

  void _setState(ViewState state) {
    _state = state;
    notifyListeners();
  }
}
