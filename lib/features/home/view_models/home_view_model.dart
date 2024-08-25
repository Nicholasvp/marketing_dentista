import 'package:marketing_dentista/core/core.dart';
import 'package:marketing_dentista/features/home/models/home_model.dart';

class HomeViewModel extends ChangeNotifier {
  HomeModel _model = HomeModel(currentIndex: 0);

  HomeModel get model => _model;

  void setIndex(int index) {
    _model = HomeModel(currentIndex: index);
    notifyListeners();
  }
}
