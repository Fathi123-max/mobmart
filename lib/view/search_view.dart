import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../core/viewmodel/home_viewmodel.dart';
import '../model/product_model.dart';
import 'new_product_view.dart';
import 'widgets/custom_text.dart';

class SearchView extends StatefulWidget {
  final String? searchValue;

  SearchView(this.searchValue);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String? _searchValue;

  @override
  void initState() {
    _searchValue = widget.searchValue!.toLowerCase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> _searchProducts = _searchValue == ''
        ? []
        : Get.find<HomeViewModel>()
            .products
            .where((product) =>
                product.name!.toLowerCase().contains(_searchValue!))
            .toList();

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 130.h,
            child: Padding(
              padding: EdgeInsets.only(bottom: 24.h, left: 16.w, right: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                  CustomText(
                    text: 'Search',
                    fontSize: 20,
                    alignment: Alignment.bottomCenter,
                  ),
                  Container(
                    width: 24,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              height: 49.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(45.r),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
                initialValue: _searchValue,
                onFieldSubmitted: (value) {
                  setState(() {
                    _searchValue = value.toLowerCase();
                  });
                },
              ),
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 24.h),
              child: GetBuilder<HomeViewModel>(
                init: Get.find<HomeViewModel>(),
                builder: (controller) => GridView.builder(
                  padding: const EdgeInsets.all(0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 15,
                    mainAxisExtent: 250,
                  ),
                  itemCount: _searchProducts.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                            // ProductDetailView(controller.products[index]),
                            ProductDetailViewNew(
                          productModel: controller.products[index],
                        ));
                      },
                      child: Container(
                        width: 190.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                image: DecorationImage(
                                  image: NetworkImage(controller
                                      .products[index].images!.first!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              height: 200.h,
                              width: 164.w,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 0, bottom: 0, left: 16.w, right: 16.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: controller.products[index].name!,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(height: 8.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text:
                                            '\$${controller.products[index].price}',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
