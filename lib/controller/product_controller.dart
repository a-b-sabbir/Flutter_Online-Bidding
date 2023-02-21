import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebay_auction/models/category_model.dart';
import 'package:ebay_auction/consts/consts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;
  var subcat = [];
  var quantity = 0.obs;

  var pnameController = TextEditingController();
  var pdescController = TextEditingController();
  var ppriceController = TextEditingController();
  var pquantityController = TextEditingController();
  var pendDateController = TextEditingController();
  var bidsController = TextEditingController();

  var categoryList = <String>[].obs;
  var subcategoryList = <String>[].obs;
  List<Category> category = [];

  var pImagesList = RxList<dynamic>.generate(3, (index) => null);

  var categoryValue = ''.obs;
  var subcategoryValue = ''.obs;

  getCategories() async {
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var cat = categoryModelFromJson(data);
    category = cat.categories;
  }

  populateCategoryList() {
    categoryList.clear();

    for (var item in category) {
      categoryList.add(item.name);
    }
  }

  populateSubcategory(cat) {
    subcategoryList.clear();

    var data = category.where((element) => element.name == cat).toList();

    for (var i = 0; i < data.first.subcategories.length; i++) {
      subcategoryList.add(data.first.subcategories[i]);
    }
  }

  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    //? here, data are passed to categoryModelFromJson, then all are returned to decoded

    //? categoryModelFromJson is the codes we got from the website quicktype
    var s =
        decoded.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcategories) {
      subcat.add(e); // adding e in subcat
    }
  }

  pickImage(index, context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (img == null) {
        return;
      } else {
        pImagesList[index] = File(img.path);
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  List<String> pImagesLinks = [];

  uploadImages() async {
    pImagesLinks.clear();
    for (var item in pImagesList) {
      if (item != null) {
        var fileName = basename(item.path);
        var destination = 'images/sellers/${currentUser!.uid}/$fileName';
        Reference reference = FirebaseStorage.instance.ref().child(destination);
        await reference.putFile(item);
        var n = await reference.getDownloadURL();
        pImagesLinks.add(n);
        print(pImagesLinks);
      }
    }
  }

  uploadProducts(context) async {
    var store = firestore.collection(productsCollection).doc();
    String productId =
        FirebaseFirestore.instance.collection('products').doc().id;
    await store.set({
      'p_id': productId,
      'p_category': categoryValue.value,
      'p_subcategory': subcategoryValue.value,
      'p_imgs': FieldValue.arrayUnion(pImagesLinks),
      'p_name': pnameController.text,
      'p_desc': pdescController.text,
      'p_price': ppriceController.text,
      'p_seller': FirebaseAuth.instance.currentUser!.displayName!,
      'seller_id': currentUser!.uid,
      'last_date': pendDateController.text
    });
    isLoading(false);
    VxToast.show(context, msg: 'Product Uploaded');
  }

  getProducts(uid) {
    return firestore
        .collection(productsCollection)
        .where('seller_id', isEqualTo: uid)
        .snapshots();
  }

  doBid(context, p_id, p_price) async {
    var store = firestore.collection(bidsCollection).doc();
    try {
      if (p_price < bidsController.text) {
        await store.set({
          'p_id': p_id,
          'bidder_name': FirebaseAuth.instance.currentUser!.displayName!,
          'bid_price': bidsController.text,
          'bidder_id': currentUser!.uid,
        });

        isLoading(false);
        VxToast.show(context, msg: 'Bid done');
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  bidRecords(p_id) {
    return firestore
        .collection(bidsCollection)
        .where('p_id', isEqualTo: p_id)
        .snapshots();
  }
}
