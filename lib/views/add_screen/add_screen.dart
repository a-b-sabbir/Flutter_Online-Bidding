import 'package:ebay_auction/consts/consts.dart';
import 'package:ebay_auction/controller/product_controller.dart';
import 'package:ebay_auction/views/add_screen/components/product_dropdown.dart';
import 'package:ebay_auction/views/add_screen/components/product_images.dart';
import 'package:ebay_auction/widgets/custom_textfield.dart';
import 'package:ebay_auction/widgets/loading_indication.dart';
import 'package:ebay_auction/widgets/text_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: darkGrey,
              )),
          title: boldText(text: "Add Product", size: 16.0),
          actions: [
            controller.isLoading.value
                ? loadingIndicator()
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      controller.uploadImages();
                      await controller.uploadProducts(context);
                      Get.back();
                    },
                    child: boldText(text: 'Save', size: 18.0))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField(
                    hint: 'eg. BMW',
                    title: 'Product Name',
                    isPass: false,
                    controller: controller.pnameController),
                10.heightBox,
                customTextField(
                    hint: 'eg. Nice Product',
                    title: 'Product Description',
                    isDesc: true,
                    isPass: false,
                    controller: controller.pdescController),
                10.heightBox,
                customTextField(
                    hint: 'eg. \$100',
                    title: 'Minimum Bid Price',
                    isPass: false,
                    inputType: TextInputType.number,
                    controller: controller.ppriceController),
                10.heightBox,
                'End Date Time'
                    .text
                    .orange600
                    .semiBold
                    .size(16.0)
                    .makeCentered(),
                5.heightBox,
                TextFormField(
                  controller: controller.pendDateController,
                  decoration: const InputDecoration(
                    hintText: 'Select Date',
                    hintStyle: TextStyle(
                      color: textfieldGrey,
                    ),
                    isDense: true,
                    fillColor: lightGrey,
                    filled: true,
                    prefixIcon: Icon(Icons.calendar_today_rounded),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: redColor)),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      controller.pendDateController.text =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                    }
                  },
                ),
                15.heightBox,
                productDropdown('Category', controller.categoryList,
                    controller.categoryValue, controller),
                10.heightBox,
                productDropdown('Sub Category', controller.subcategoryList,
                    controller.subcategoryValue, controller),
                15.heightBox,
                const Divider(color: whiteColor),
                boldText(text: 'Choose Product Images', color: whiteColor),
                10.heightBox,
                Obx(
                  () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                          3,
                          (index) => controller.pImagesList[index] != null
                              ? Image.file(
                                  controller.pImagesList[index],
                                  width: 90,
                                  height: 90,
                                ).onTap(() {
                                  controller.pickImage(index, context);
                                })
                              : productImage(label: "${index + 1}").onTap(() {
                                  controller.pickImage(index, context);
                                }))),
                ),
                5.heightBox,
                normalText(
                    text: 'First image will be your display image',
                    color: lightGrey),
                10.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
