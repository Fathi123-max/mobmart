import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopzler/model/category_model.dart';

import '../core/viewmodel/home_viewmodel.dart';
import 'category_products_view.dart';
import 'widgets/custom_text.dart';

class CategoriesView extends StatelessWidget {
  final List<CategoryModel> catogries;

  CategoriesView({required this.catogries});

  @override
  Widget build(BuildContext context) {
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
                    text: "All Catogries",
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
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 24.h),
              child: GridView.builder(
                padding: const EdgeInsets.all(0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 15,
                  mainAxisExtent: 270,
                ),
                itemCount: catogries.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                          // ProductDetailView(products[index]),
                          CategoryProductsView(
                        categoryName: Get.put<HomeViewModel>(HomeViewModel())
                            .categories[index]
                            .name,
                        products: Get.put<HomeViewModel>(HomeViewModel())
                            .products
                            .where((product) =>
                                product.category ==
                                Get.put<HomeViewModel>(HomeViewModel())
                                    .categories[index]
                                    .name
                                    .toLowerCase())
                            .toList(),
                      ));
                    },
                    child: Container(
                      width: 190.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              image: DecorationImage(
                                image: NetworkImage(catogries[index].image),
                                fit: BoxFit.cover,
                              ),
                            ),
                            height: 180.h,
                            width: 164.w,
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: catogries[index].name,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
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
        ],
      ),
    );
  }
}
