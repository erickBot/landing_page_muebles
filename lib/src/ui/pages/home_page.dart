import 'package:flutter/material.dart';
import 'package:laning_page/src/models/image_slider.dart';
import 'package:laning_page/src/providers/data_provider.dart';
import 'package:laning_page/src/providers/page_provider.dart';
import 'package:laning_page/src/services/image_service.dart';
import 'package:laning_page/src/ui/pages/loading_page.dart';
import 'package:laning_page/src/ui/shared/custom_app_menu.dart';
import 'package:laning_page/src/ui/views/catalog_view.dart';
import 'package:laning_page/src/ui/views/contact_view.dart';
import 'package:laning_page/src/ui/views/home_view.dart';
import 'package:laning_page/src/ui/views/about_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImageService imageService = ImageService();

  List<ImageSlider> images = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    //imageService.init(context);
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    dataProvider.init(context);
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingPage()
        : Scaffold(
            body: Container(
              decoration: buildBoxDecoration(),
              child: Stack(
                children: [
                  _HomeBody(),
                  Positioned(right: 20, top: 20, child: CustomAppMenu()),
                  // Positioned(left: 20, top: 20, child: CustomAppBar()),
                ],
              ),
            ),
          );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.pink, Colors.purpleAccent],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.5, 0.5],
    ),
  );
}

class _HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageProvider>(context, listen: false);

    return PageView(
      controller: pageProvider.scrollController,
      scrollDirection: Axis.vertical,
      children: [HomeView(), CatalogView(), AboutView(), ContactView()],
    );
  }
}
