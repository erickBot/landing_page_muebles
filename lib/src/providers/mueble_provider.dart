import 'package:flutter/widgets.dart';
import 'package:laning_page/src/models/mueble.dart';
import 'package:laning_page/src/models/product.dart';
import 'package:laning_page/src/services/product_service.dart';

class MuebleProvider extends ChangeNotifier {
  ProductService productService = ProductService();
  Mueble? _mueble;
  List<Product> _products = [];

  init(BuildContext context, String idMueble) {
    productService.init(context);
    getProductByIdMueble(idMueble);
  }

  Mueble get currentMueble => _mueble!;

  List<Product> get currentProducts => _products;

  void setMueble(Mueble mueble) {
    _mueble = mueble;
    notifyListeners();
  }

  void getProductByIdMueble(String idMueble) async {
    _products = await productService.getByIdMueble(idMueble);
    notifyListeners();
  }
}
