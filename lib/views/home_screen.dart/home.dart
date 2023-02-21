// ignore_for_file: unused_import

import 'package:ebay_auction/consts/consts.dart';
import 'package:bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:ebay_auction/controller/home_controller.dart';
import 'package:ebay_auction/controller/product_controller.dart';
import 'package:ebay_auction/views/category_screen/item_gallery.dart';
import 'package:ebay_auction/views/add_screen/add_screen.dart';
import 'package:ebay_auction/views/my_items_screen/my_items_screen.dart';
import 'package:ebay_auction/views/profile_screen/profile_screen.dart';
import 'package:ebay_auction/widgets/exit_dialog.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    //init home controller
    var controller = Get.put(HomeController());

    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 26,
          ),
          label: gallery),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCart,
            width: 26,
          ),
          label: myitems),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: account),
    ];

    var navbody = [
      const ItemGallery(),
      const MyItemScreen(),
      const ProfileScreen()
    ];

    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.amber[300],
        body: Column(
          children: [
            Obx(() => Expanded(
                child: navbody.elementAt(controller.CurentNavIndex.value)))
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.CurentNavIndex.value,
            items: navbarItem,
            selectedItemColor: redColor,
            backgroundColor: whiteColor,
            type: BottomNavigationBarType.fixed,
            onTap: (value) => controller.CurentNavIndex.value = value,
          ),
        ),
      ),
    );
  }
}
