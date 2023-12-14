import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/constants.dart';
import 'package:ismmart_vms/screens/collection/collection_model.dart';
import 'package:ismmart_vms/screens/collection/collection_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_appbar.dart';
import 'package:ismmart_vms/widgets/custom_text.dart';

class CollectionView extends StatelessWidget {
  CollectionView({super.key});
  final CollectionViewModel viewModel = Get.put(CollectionViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Collection'),
      body: ListView.builder(
          itemCount: viewModel.collections.length,
          itemBuilder: (_, index) {
            CollectionModel model = viewModel.collections[index];
            return _collectionListItemView(model: model);
          }),
    );
  }

  Widget _collectionListItemView({CollectionModel? model}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(color: kWhiteColor),
        child: Column(
          children: [
            CachedNetworkImage(
                imageUrl: model!.media ?? AppConstant.defaultImgUrl),
            CustomText(title: model.name ?? ''),
            CustomText(title: 'Products: ${model.noOfProducts}'),
          ],
        ),
      ),
    );
  }
}
