import 'package:ebay_auction/consts/consts.dart';

Widget productImage({required label, onPress}) {
  return '$label'
      .text
      .bold
      .color(fontGrey)
      .size(16.0)
      .makeCentered()
      .box
      .color(lightGrey)
      .roundedSM
      .size(100, 100)
      .make();
}
