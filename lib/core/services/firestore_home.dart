import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHome {
  final CollectionReference _categoriesCollection =
      FirebaseFirestore.instance.collection('categories');

  final CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection('products');

  final CollectionReference _offerCollection =
      FirebaseFirestore.instance.collection('offers');

  Future<List<QueryDocumentSnapshot>> getCategoriesFromFirestore() async {
    var categories = await _categoriesCollection.get();
    return categories.docs;
  }

  Future<List<QueryDocumentSnapshot>> getProductsFromFirestore() async {
    var products = await _productsCollection.get();
    return products.docs;
  }

  Future<List<QueryDocumentSnapshot>> getOffersFromFirestore() async {
    var offers = await _offerCollection.get();
    return offers.docs;
  }
}
