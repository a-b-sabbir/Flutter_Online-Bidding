import 'package:ebay_auction/consts/lists.dart';
import 'package:ebay_auction/controller/product_controller.dart';
import 'package:ebay_auction/views/add_screen/add_screen.dart';
import 'package:ebay_auction/views/category_screen/category_details.dart';
import 'package:ebay_auction/widgets/bg_widget.dart';
import 'package:get/get.dart';
import '../../consts/consts.dart';

class ItemGallery extends StatelessWidget {
  const ItemGallery({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return bgWidget(
        bgWidget_child: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await controller.getCategories();
          controller.populateCategoryList();
          Get.to(() => const AddScreen());
        },
        backgroundColor: purpleColor,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: gallery.text.bold.make(),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.fromLTRB(5, 20, 5, 20),
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 12,
                mainAxisExtent: 250),
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  Image.asset(
                    categoriesImages[index],
                    height: 150,
                  ),
                  20.heightBox,
                  categoriesList[index]
                      .toString()
                      .text
                      .semiBold
                      .align(TextAlign.center)
                      .make(),
                ],
              )
                  .box
                  .white
                  .outerShadowSm
                  .rounded
                  .clip(Clip.antiAlias)
                  .make()
                  .onTap(() {
                controller.getSubCategories(categoriesList[index]);
                Get.to(
                  CategoryDetails(title: categoriesList[index]),
                );
              });
            })),
      ),
    ));
  }
}
