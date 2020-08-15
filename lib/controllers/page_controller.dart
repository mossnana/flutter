import 'package:get/get.dart';
import 'package:test_get_x/enums/page_enum.dart';
import 'package:test_get_x/models/page_model.dart';

class AppPageController extends GetxController {
  final page = PageModel(PageEnum.Home).obs;

  updatePage(PageEnum routeName) {
    page.update((newPage) {
      newPage.name = routeName;
    });
  }
}
