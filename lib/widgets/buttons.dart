import 'package:ebay_auction/consts/consts.dart';

Widget shortButton({
  our_onPress,
  our_color,
  our_textColor,
  String? our_title,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: our_color, padding: EdgeInsets.all(14)),
    onPressed: our_onPress,
    child: our_title!.text.color(our_textColor).bold.size(16).make(),
    //? We had to use String? in the parameter to use our_title! as text
  );
}

Widget LongButton({
  our_onPress,
  our_color,
  our_textColor,
  String? our_title,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: our_color,
        padding: EdgeInsets.symmetric(horizontal: 150, vertical: 15)),
    onPressed: our_onPress,
    child: our_title!.text.color(our_textColor).bold.size(20).make(),
    //? We had to use String? in the parameter to use our_title! as text
  );
}
