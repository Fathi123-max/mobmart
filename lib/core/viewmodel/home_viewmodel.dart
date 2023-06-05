import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../model/category_model.dart';
import '../../model/offer_model.dart';
import '../../model/product_model.dart';
import '../services/firestore_home.dart';

class HomeViewModel extends GetxController {
  List<CategoryModel> _categories = [];
  List<ProductModel> _products = [];
  List<offerModel> _offers = [];

  List<CategoryModel> get categories => _categories;

  List<ProductModel> get products => _products;
  List<offerModel> get offers => _offers;

  bool _loading = false;

  bool get loading => _loading;

  @override
  void onInit() {
    super.onInit();
    _getCategoriesFromFireStore();
    _getProductsFromFireStore();
    _getOffersFromFireStore();
  }

  _getCategoriesFromFireStore() async {
    _loading = true;
    List<QueryDocumentSnapshot> categoriesSnapshot =
        await FirestoreHome().getCategoriesFromFirestore();
    categoriesSnapshot.forEach((category) {
      _categories
          .add(CategoryModel.fromJson(category.data() as Map<String, dynamic>));
    });
    _loading = false;
    update();
  }

  _getOffersFromFireStore() async {
    _loading = true;
    List<QueryDocumentSnapshot> offersSnapshot =
        await FirestoreHome().getOffersFromFirestore();
    offersSnapshot.forEach((offer) {
      _offers.add(offerModel.fromMap(offer.data() as Map<String, dynamic>));
    });
    _loading = false;
    update();
  }

  _getProductsFromFireStore() async {
    _loading = true;
    List<QueryDocumentSnapshot> productsSnapshot =
        await FirestoreHome().getProductsFromFirestore();
    productsSnapshot.forEach((product) {
      _products
          .add(ProductModel.fromJson(product.data() as Map<String, dynamic>));
    });
    _loading = false;
    update();
  }
}
