import 'package:ebay_auction/consts/consts.dart';
import 'package:ebay_auction/controller/product_controller.dart';
import 'package:ebay_auction/widgets/buttons.dart';
import 'package:ebay_auction/widgets/custom_textfield.dart';
import 'package:get/get.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({required this.title, required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(title: title!.text.make(), actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
      ]),
      body: Column(children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //vs
                VxSwiper.builder(
                  autoPlay: true,
                  height: 350,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1.0,
                  itemCount: data['p_imgs'].length,
                  itemBuilder: (context, index) {
                    return Image.network(data['p_imgs'][index],
                        width: double.infinity, fit: BoxFit.cover);
                  },
                ),
                10.heightBox,
                title!.text.color(darkFontGrey).bold.size(16).make(),
                10.heightBox,
                'Date: ------------'.text.bold.size(19.0).make(),

                10.heightBox,
                'Min: \$${data['p_price']}'
                    .text
                    .color(redColor)
                    .bold
                    .size(20)
                    .make(),

                10.heightBox,
                'Description'.text.color(darkFontGrey).semiBold.make(),
                10.heightBox,
                '${data['p_desc']}'.text.color(darkFontGrey).make(),
                10.heightBox,
                customTextField(
                    hint: 'eg. \$4000',
                    title: 'Your Bidding Price',
                    isDesc: true,
                    isPass: false,
                    inputType: TextInputType.number),
                10.heightBox,
                LongButton(
                        our_title: 'B I D',
                        our_onPress: () {},
                        our_color: purple2)
                    .box
                    .makeCentered()
              ],
            ).box.make(),
          ),
        )),
      ]),
    );
  }
}
