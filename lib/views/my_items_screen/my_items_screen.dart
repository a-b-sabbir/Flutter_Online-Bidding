import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebay_auction/controller/product_controller.dart';
import 'package:ebay_auction/views/category_screen/item_details.dart';
import 'package:ebay_auction/widgets/loading_indication.dart';
import 'package:flutter/material.dart';
import 'package:ebay_auction/consts/consts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';

import '../../widgets/text_style.dart';

class MyItemScreen extends StatelessWidget {
  const MyItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Scaffold(
        appBar: AppBar(
          title: 'My Items'.text.make(),
        ),
        body: StreamBuilder(
          stream: controller.getProducts(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                  onTap: () {
                                    Get.to(() => ItemDetails(
                                        title: data[index]['p_name'],
                                        data: data[index]));
                                  },
                                  leading: Image.network(
                                    '${data[index]['p_imgs'][0]}',
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  title: boldText(
                                      text: '${data[index]['p_name']}',
                                      color: fontGrey),
                                  subtitle: Row(
                                    children: [
                                      normalText(
                                          text: '${data[index]['p_price']}',
                                          color: darkGrey),
                                      10.widthBox,
                                    ],
                                  ),
                                ),
                              )),
                    )
                  ]),
                ),
              );
            }
          },
        ));
  }
}
