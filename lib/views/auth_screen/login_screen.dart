import 'package:ebay_auction/consts/consts.dart';
import 'package:ebay_auction/controller/auth_controller.dart';
import 'package:ebay_auction/views/home_screen.dart/home.dart';
import 'package:ebay_auction/widgets/app_logo.dart';
import 'package:ebay_auction/widgets/bg_widget.dart';
import 'package:ebay_auction/widgets/custom_textfield.dart';
import 'package:ebay_auction/widgets/buttons.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return bgWidget(
        bgWidget_child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Column(
                children: [
                  (context.screenHeight * 0.1).heightBox,
                  applogoWidget(),
                  10.heightBox,
                  "log in to $appname".text.white.bold.size(18).make(),
                  40.heightBox,
                  Obx(
                    () => Column(
                      children: [
                        customTextField(
                          hint: EmailHint,
                          title: Email,
                          isPass: false,
                          // controller: controller.emailController,
                        ),
                        customTextField(
                          hint: PassHint,
                          title: Pass,
                          isPass: true,
                          // controller: controller.passwordController,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              child: ForgetPass.text.blue600.make()),
                        ),
                        5.heightBox,
                        controller.isLoading.value
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(purple2),
                              )
                            : shortButton(
                                    our_color: purple2,
                                    our_title: Login,
                                    our_textColor: whiteColor,
                                    our_onPress: () async {
                                      controller.isLoading(true);
                                      await controller
                                          .loginMethod(context: context)
                                          .then((value) {
                                        if (value != null) {
                                          VxToast.show(context, msg: loggedIn);
                                          Get.offAll(() => Home());
                                        } else {
                                          controller.isLoading(false);
                                        }
                                      });
                                    })
                                .box
                                .rounded
                                .width(context.screenWidth - 50)
                                .make(),
                        20.heightBox,
                        CreateNewAccount.text.make(),
                        10.heightBox,
                        ElevatedButton.icon(
                          onPressed: () {
                            AuthController().signInWithGoogle();
                          },

                          style: ElevatedButton.styleFrom(
                              backgroundColor: redGolden,
                              padding: EdgeInsets.all(14)),
                          icon: Image.asset(
                            icGoogleLogo,
                            width: 30,
                            height: 30,
                          ),
                          label: SignUp.text.bold.black.size(16).make(),

                          //? We had to use String? in the parameter to use our_title! as text
                        ).box.rounded.width(context.screenWidth - 50).make(),
                        5.heightBox,
                        15.heightBox,
                      ],
                    )
                        .box
                        .white
                        .rounded
                        .padding(const EdgeInsets.all(16))
                        .width(context.screenWidth - 70)
                        .shadowSm
                        .make(),
                  ),
                ],
              ),
            )));
  }
}
