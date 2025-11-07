import 'package:flutter/widgets.dart';
import 'package:laning_page/src/models/product.dart';

class ProductProvider extends ChangeNotifier {
  Product? _product;

  Product get currentProduct => _product!;

  void setProduct(Product product) {
    _product = product;
    notifyListeners();
  }
}
