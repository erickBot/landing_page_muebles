import 'package:flutter/widgets.dart';
import 'package:laning_page/src/models/image_slider.dart';
import 'package:laning_page/src/models/mueble.dart';
import 'package:laning_page/src/models/util.dart';
import 'package:laning_page/src/services/image_service.dart';
import 'package:laning_page/src/services/mueble_service.dart';
import 'package:laning_page/src/services/util_service.dart';

class DataProvider extends ChangeNotifier {
  ImageService imageService = ImageService();
  MuebleService muebleService = MuebleService();
  UtilService utilService = UtilService();

  List<ImageSlider> _images = [];
  List<Mueble> _muebles = [];
  Util? _util;

  init(BuildContext context) {
    imageService.init(context);
    muebleService.init(context);
    utilService.init(context);
    getImageSlider();
    getMuebles();
    getUtil();
  }

  List<ImageSlider> get currentImages => _images;
  List<Mueble> get currentMuebles => _muebles;
  Util get currentUtil => _util!;

  void getImageSlider() async {
    _images = await imageService.getAll();
    //print(_images);
    notifyListeners();
  }

  void getMuebles() async {
    _muebles = await muebleService.getAll();
    //print(_muebles);
    notifyListeners();
  }

  void getUtil() async {
    _util = await utilService.getAll();
    //print(_util);
    notifyListeners();
  }
}
