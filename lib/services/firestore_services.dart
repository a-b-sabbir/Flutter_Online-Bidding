import 'package:ebay_auction/consts/consts.dart';

class FirestoreServices {
// Get Users Data
  static getUser(uid) {
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  //get products according to category
  static getProducts(category) {
    return firestore
        .collection(productsCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  static getSubCategoryProducts(title) {
    return firestore
        .collection(productsCollection)
        .where('p_subcategory', isEqualTo: title)
        .snapshots();
  }

  static allProducts() {
    return firestore.collection(productsCollection).snapshots();
  }

  //get featured products
  static getFeaturedProducts() {
    return firestore
        .collection(productsCollection)
        .where('is_featured', isEqualTo: true)
        .get();
    //? used get(), because of using FutureBuilder where the method is used
  }

  static searchProducts(title) {
    return firestore.collection(productsCollection).get();
  }
}
