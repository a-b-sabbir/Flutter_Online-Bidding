import 'package:ebay_auction/consts/consts.dart';
import 'package:ebay_auction/views/auth_screen/login_screen.dart';
import 'package:ebay_auction/views/home_screen.dart/home.dart';
import 'package:ebay_auction/widgets/app_logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //? Creating a method to change screen

  changeScreen() {
    Future.delayed(const Duration(seconds: 2), () {
      //using getx

      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(() => const LoginScreen());
        } else {
          Get.to(() => const Home());
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    changeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purple2,
      body: Center(
          child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              icSplashBg,
              width: 300,
            ),
          ),
          20.heightBox,
          applogoWidget(),
          10.heightBox,
          appname.text.size(22).white.bold.make(),
          15.heightBox,
          appversion.text.size(15).red200.make(),
          Spacer(),
          credits.text.white.semiBold.make(),
          25.heightBox
        ],
      )),
    );
  }
}
