import 'package:ebay_auction/controller/auth_controller.dart';
import 'package:ebay_auction/views/auth_screen/login_screen.dart';
import 'package:ebay_auction/widgets/bg_widget.dart';
import 'package:ebay_auction/widgets/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../consts/consts.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return bgWidget(
        bgWidget_child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 90.0),
      child: Column(
        children: [
          Row(
            children: [
              Image.network(FirebaseAuth.instance.currentUser!.photoURL!)
                  .box
                  .roundedLg
                  .clip(Clip.antiAlias)
                  .make(),
              20.widthBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldText(
                      text: FirebaseAuth.instance.currentUser!.displayName!,
                      color: whiteColor,
                      size: 20.0),
                  5.heightBox,
                  normalText(
                      text: FirebaseAuth.instance.currentUser!.email!,
                      color: whiteColor,
                      size: 15.0)
                ],
              )
            ],
          ),
          15.heightBox,
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                  side: const BorderSide(color: redColor, width: 2)),
              onPressed: () async {
                await Get.put(AuthController().signOut(context));
                Get.offAll(() => const LoginScreen());
              },
              child: 'Log out'.text.semiBold.size(18).color(redColor).make())
        ],
      ),
    ));
  }
}
