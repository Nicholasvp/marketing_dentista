import 'package:marketing_dentista/core/core.dart';
import 'package:marketing_dentista/features/categorias/view_model/categoria_view_model.dart';
import 'package:marketing_dentista/features/home/view_models/home_view_model.dart';
import 'package:marketing_dentista/features/product_search/product_search_export.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => CategoriaViewModel()),
      ],
      child: const App(),
    ),
  );
}
