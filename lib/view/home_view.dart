import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../core/viewmodel/checkout_viewmodel.dart';
import '../core/viewmodel/home_viewmodel.dart';
import 'category_products_view.dart';
import 'catogries_view.dart';
import 'new_product_view.dart';
import 'search_view.dart';
import 'widgets/custom_text.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(CheckoutViewModel());

    return Scaffold(
      body: GetBuilder<HomeViewModel>(
        init: Get.find<HomeViewModel>(),
        builder: (controller) => controller.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                padding: EdgeInsets.only(
                    top: 65.h, bottom: 14.h, right: 16.w, left: 16.w),
                child: Column(
                  children: [
                    SearchBar(),
                    SizedBox(
                      height: 44.h,
                    ),
                    BannerView(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Categories',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(CategoriesView(
                              catogries: controller.categories,
                            ));
                          },
                          child: CustomText(
                            text: 'See all',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 19.h,
                    ),
                    ListViewCategories(),
                    SizedBox(
                      height: 50.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Best Selling',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(CategoryProductsView(
                              categoryName: 'Best Selling',
                              products: controller.products,
                            ));
                          },
                          child: CustomText(
                            text: 'See all',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    ListViewProducts(),
                  ],
                ),
              ),
      ),
    );
  }
}

class ListViewCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      builder: (controller) => Container(
        height: 180.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(CategoryProductsView(
                  categoryName: controller.categories[index].name,
                  products: controller.products
                      .where((product) =>
                          product.category ==
                          controller.categories[index].name.toLowerCase())
                      .toList(),
                ));
              },
              child: Container(
                width: 120.w,
                height: 130.h,
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.5),
                  //     spreadRadius: 2,
                  //     blurRadius: 5,
                  //     offset: Offset(0, 3),
                  //   ),
                  // ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60.r,
                      backgroundImage:
                          NetworkImage(controller.categories[index].image),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: controller.categories[index].name,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 20.w,
            );
          },
        ),
      ),
    );
  }
}

class ListViewProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      builder: (controller) => Container(
        height: 290.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(ProductDetailViewNew(
                  productModel: controller.products[index],
                )
                    // ProductDetailView(controller.products[index]),
                    );
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
                          image: NetworkImage(
                              controller.products[index].images!.first!),
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: 200.h,
                      width: 164.w,
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: controller.products[index].name!,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: '\$${controller.products[index].price}',
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
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 15.w,
            );
          },
        ),
      ),
    );
  }
}

class BannerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 16.w),
      child: Column(
        children: [
          CustomText(
            text: 'Special Offers',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 16.h),
          GetBuilder<HomeViewModel>(
            builder: (controller) => Container(
              height: 220.h,
              child: CarouselSlider(
                items: controller.offers.map((offer) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(offer.image!), fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 220.h,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    // Handle page change here
                  },
                  viewportFraction: 1.0,
                  initialPage: 0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _startListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          print('Speech status: $status');
        },
        onError: (error) {
          print('Speech error: $error');
        },
      );
      if (available) {
        setState(() => _isListening = true);

        _speech.listen(
          onResult: (result) {
            setState(() {
              Get.to(SearchView(result.recognizedWords));
            });
          },
        );
      }
    }
  }

  void _stopListening() {
    if (_isListening) {
      _speech.stop();
      setState(() => _isListening = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49.h,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          SizedBox(width: 16.w),
          const Icon(
            Icons.search,
            color: Colors.black,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                ),
              ),
              onChanged: (value) {},
              onFieldSubmitted: (value) {
                setState(() {
                  Get.to(SearchView(value));
                });
              },
            ),
          ),
          SizedBox(width: 16.w),
          // IconButton(
          //   icon: Icon(Icons.send),
          //   onPressed: () {},

          //   // icon: _isListening
          //   //     ? const Icon(Icons.mic_off, color: Colors.black)
          //   //     : const Icon(Icons.mic, color: Colors.black),
          //   // onPressed: () {
          //   //   if (_isListening) {
          //   //     _stopListening();
          //   //   } else {
          //   //     _startListening();
          //   //   }
          //   // },
          // ),
        ],
      ),
    );
  }
}
