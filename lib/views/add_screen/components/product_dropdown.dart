import 'package:ebay_auction/consts/consts.dart';
import 'package:ebay_auction/controller/product_controller.dart';
import 'package:get/get.dart';

Widget productDropdown(
    hint, List<String> list, dropValue, ProductController controller) {
  return Obx(
    () => DropdownButtonHideUnderline(
            child: DropdownButton(
      hint: '$hint'.text.make(),
      isExpanded: true,
      value: dropValue == '' ? null : dropValue.value,
      items: list.map((e) {
        return DropdownMenuItem(value: e, child: e.toString().text.make());
      }).toList(),
      onChanged: (newValue) {
        if (hint == 'Category') {
          controller.subcategoryValue.value = '';
          controller.populateSubcategory(newValue.toString());
        }
        dropValue.value = newValue.toString();
      },
    ))
        .box
        .roundedSM
        .white
        .padding(const EdgeInsets.symmetric(horizontal: 8))
        .make(),
  );
}
