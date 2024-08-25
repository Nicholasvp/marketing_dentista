import 'package:flutter_test/flutter_test.dart';
import 'package:marketing_dentista/core/utils/enums.dart';
import 'package:marketing_dentista/features/product_search/product_search_export.dart';

void main() {
  late ProductViewModel viewModel;

  setUp(() {
    viewModel = ProductViewModel();
  });

  group('ProductViewModel Tests', () {
    test('Inicialmente, o estado deve ser initial', () {
      expect(viewModel.state, ViewState.initial);
    });

    test('Deve atualizar o estado para loading e depois para loaded', () async {
      await viewModel.fetchProducts();

      expect(viewModel.state, ViewState.loaded);
      expect(viewModel.products, isNotEmpty);
    });

    test('Deve definir mensagem de erro se não encontrar nenhum produto', () async {
      // Simula uma exceção
      final viewModel = ProductViewModel();

      await viewModel.searchProducts('error');

      expect(viewModel.state, ViewState.error);
      expect(viewModel.errorMessage, 'Nenhum produto encontrado.');
    });
  });
}
