import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebay_auction/consts/consts.dart';
import 'package:ebay_auction/controller/product_controller.dart';
import 'package:ebay_auction/widgets/buttons.dart';
import 'package:ebay_auction/widgets/custom_textfield.dart';
import 'package:ebay_auction/widgets/loading_indication.dart';
import 'package:ebay_auction/widgets/text_style.dart';
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
            physics: BouncingScrollPhysics(),
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
                title!.text.color(Colors.green).bold.size(23).make(),
                10.heightBox,
                'End Date:  ${data['last_date']}'.text.bold.size(19.0).make(),

                15.heightBox,
                'Min: \$ ${data['p_price']}'
                    .text
                    .color(redColor)
                    .bold
                    .size(30)
                    .make(),

                10.heightBox,
                'Description'
                    .text
                    .color(darkFontGrey)
                    .size(17.0)
                    .semiBold
                    .make(),
                10.heightBox,
                '${data['p_desc']}'.text.color(darkFontGrey).make(),
                10.heightBox,
                customTextField(
                    hint: 'eg. \$4000',
                    title: 'Your Bidding Price',
                    isDesc: true,
                    isPass: false,
                    inputType: TextInputType.number,
                    controller: controller.bidsController),

                '(Bid price should be above Minimun Price)'
                    .text
                    .color(fontGrey)
                    .make(),
                15.heightBox,
                LongButton(
                        our_title: 'B I D',
                        our_onPress: () async {
                          await controller.doBid(
                              context, '${data['p_id']}', '${data['p_price']}');
                        },
                        our_color: purple2)
                    .box
                    .makeCentered(),
                //
                //
                //
                //
                //
                //
                //
                20.heightBox,
                StreamBuilder(
                  stream: controller.bidRecords('${data['p_id']}'),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return loadingIndicator();
                    } else {
                      var data = snapshot.data!.docs;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(children: [
                            ListView(
                              shrinkWrap: true,
                              children: List.generate(
                                  data.length,
                                  (index) => Card(
                                        child: ListTile(
                                          title: boldText(
                                              text:
                                                  '${data[index]['bidder_name']}',
                                              color: fontGrey),
                                          trailing: boldText(
                                              text:
                                                  '\$ ${data[index]['bid_price']}',
                                              color: redColor,
                                              size: 20.0),
                                        ),
                                      )),
                            )
                          ]),
                        ),
                      );
                    }
                  },
                )
                //
                //
                //
                //

                //
              ],
            ).box.make(),
          ),
        )),
      ]),
    );
  }
}
