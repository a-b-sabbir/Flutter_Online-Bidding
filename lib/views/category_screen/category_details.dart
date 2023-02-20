import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebay_auction/consts/consts.dart';
import 'package:ebay_auction/controller/product_controller.dart';
import 'package:ebay_auction/services/firestore_services.dart';
import 'package:ebay_auction/views/category_screen/item_details.dart';
import 'package:ebay_auction/widgets/bg_widget.dart';
import 'package:ebay_auction/widgets/loading_indication.dart';
import 'package:get/get.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;
  const CategoryDetails({required this.title, super.key});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subcat.contains(title)) {
      productMethod = FirestoreServices.getSubCategoryProducts(title);
    } else {
      productMethod = FirestoreServices.getProducts(title);
    }
  }

  var controller = Get.find<ProductController>();
  dynamic productMethod;
  @override
  Widget build(BuildContext context) {
    return bgWidget(
      bgWidget_child: Scaffold(
          appBar: AppBar(
            title: widget.title!.text.bold.white.make(),
          ),
          //title is passed in the following line
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      controller.subcat.length,
                      
                      (index) => '${controller.subcat[index]}'
                              .text
                              .size(12)
                              .semiBold
                              .makeCentered()
                              .box
                              .white
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .padding(const EdgeInsets.all(15))
                              .rounded
                              .size(120, 50)
                              .make()
                              .onTap(() {
                            switchCategory('${controller.subcat[index]}');
                            setState(() {});
                          })),
                ),
              ),
              20.heightBox,
              StreamBuilder(
                stream: productMethod,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: loadingIndicator(),
                    );
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Expanded(
                      child: "No products found!"
                          .text
                          .color(darkFontGrey)
                          .size(20)
                          .makeCentered(),
                    );
                  } else {
                    var data = snapshot.data!.docs;

                    return Expanded(
                        child: GridView.builder(
                            itemCount: data.length,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 12,
                                    mainAxisExtent: 220),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(data[index]['p_imgs'][0],
                                      height: 150,
                                      width: 200,
                                      fit: BoxFit.cover),
                                  Spacer(),
                                  '${data[index]['p_name']}'
                                      .text
                                      .semiBold
                                      .color(fontGrey)
                                      .make(),
                                  10.heightBox,
                                  '${data[index]['p_price']}'
                                      .numCurrency
                                      .text
                                      .color(redColor)
                                      .bold
                                      .size(16)
                                      .make()
                                ],
                              )
                                  .box
                                  .white
                                  .roundedSM
                                  .outerShadow
                                  .margin(const EdgeInsets.symmetric(horizontal: 6))
                                  .padding(const EdgeInsets.all(8))
                                  .make()
                                  .onTap(() {
                                Get.to(ItemDetails(
                                    title: data[index]['p_name'],
                                    data: data[index]));
                              });
                            }));
                  }
                },
              ),
            ],
          )),
    );
  }
}
