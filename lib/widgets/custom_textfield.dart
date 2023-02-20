import 'package:ebay_auction/consts/consts.dart';

Widget customTextField(
    {String? title, String? hint, isPass, inputType, controller, isDesc = false}) {
  return Column(
    children: [
      title!.text.orange600.semiBold.size(16).make(),
      5.heightBox,
      TextFormField(
        keyboardType: inputType,
        controller: controller,
        obscureText: isPass,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: textfieldGrey,
          ),
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: redColor)),
        ),
      ),
      15.heightBox,
    ],
  );
}
