import 'package:get/get.dart';
import 'package:ismmart_vms/screens/collection/collection_model.dart';

class CollectionViewModel extends GetxController {
  List<CollectionModel> collections = <CollectionModel>[
    CollectionModel(
        id: "1",
        name: "Fashion",
        media:
            "https://cdn.shopify.com/s/files/1/0817/7270/8137/files/Fashion.png?v=1696158117",
        noOfProducts: "25"),
    CollectionModel(
        id: "2",
        name: "Accessories",
        media:
            "https://cdn.shopify.com/s/files/1/0817/7270/8137/files/accessories-05.png?v=1696161111",
        noOfProducts: "10"),
    CollectionModel(
        id: "3",
        name: "Electronics",
        media:
            "https://cdn.shopify.com/s/files/1/0817/7270/8137/files/Electronics-2.png?v=1696159338",
        noOfProducts: "9"),
    CollectionModel(
        id: "4",
        name: "Sports & fitness",
        media:
            "https://cdn.shopify.com/s/files/1/0817/7270/8137/files/sportswear.png?v=1696158117",
        noOfProducts: "15"),
  ].obs;
}
