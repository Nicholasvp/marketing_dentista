import 'package:marketing_dentista/core/core.dart';
import 'package:marketing_dentista/core/service/secure_storage_service.dart';
import 'package:marketing_dentista/core/utils/mock/product_mock.dart';
import 'package:marketing_dentista/features/product_search/models/product_model.dart';

class ProductViewModel extends ChangeNotifier {
  ViewState _state = ViewState.initial;
  List<ProductModel> _products = [];
  String _errorMessage = '';
  String _query = '';

  ViewState get state => _state;
  List<ProductModel> get products => _products;
  String get errorMessage => _errorMessage;

  String get query => _query;
  set query(String value) {
    _query = value;
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    _setState(ViewState.loading);

    try {
      await Future.delayed(const Duration(seconds: 2));
      final response = productMock();
      _products = List<ProductModel>.from(
        response.map((product) => ProductModel.fromMap(product)),
      );
      _setState(ViewState.loaded);
    } catch (e) {
      _errorMessage = 'Ocorreu um erro ao carregar os produtos.';
      _setState(ViewState.error);
    }
  }

  Future<void> searchProducts(String query) async {
    _setState(ViewState.loading);

    _query = query;

    await Future.delayed(const Duration(seconds: 2));
    final response = productMock();

    if (query.isEmpty) {
      _products = List<ProductModel>.from(
        response.map((product) => ProductModel.fromMap(product)),
      );
      _setState(ViewState.loaded);
      return;
    }

    _products = List<ProductModel>.from(
      response
          .where((product) =>
              product['name'].toLowerCase().contains(query.toLowerCase()) ||
              product['category'].toLowerCase().contains(query.toLowerCase()))
          .map((product) => ProductModel.fromMap(product)),
    );

    if (_products.isEmpty) {
      _errorMessage = 'Não encontramos nenhum resultado parecido com "$query".';
      _setState(ViewState.error);
      return;
    }
    _saveSuggestions(query);

    _setState(ViewState.loaded);
  }

  Future<void> _saveSuggestions(String value) async {
    final secureStorage = SecureStorageService();
    final suggestions = (await secureStorage.read('suggestions'))?.split(',') ?? <String>[];
    if (suggestions.contains(value) || value.isEmpty) {
      return;
    }
    suggestions.add(value);
    await secureStorage.write('suggestions', suggestions.join(','));
  }

  void _setState(ViewState state) {
    _state = state;
    notifyListeners();
  }
}
