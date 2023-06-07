import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../core/viewmodel/cart_viewmodel.dart';
import '../model/cart_model.dart';
import '../model/product_model.dart';

class ProductDetailViewNew extends StatefulWidget {
  final ProductModel productModel;

  const ProductDetailViewNew({key, required this.productModel});

  @override
  State<ProductDetailViewNew> createState() => _ProductDetailViewNewState();
}

class _ProductDetailViewNewState extends State<ProductDetailViewNew> {
// [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
// turn can be placed in a [Scaffold.body].

  bool _floating = false;
  bool _pinned = true;
  bool _snap = false;

  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    List photos = widget.productModel.images!;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.put<CartViewModel>(CartViewModel()).addProduct(
                CartModel(
                  name: widget.productModel.name!,
                  image: widget.productModel.images!.first!,
                  price: widget.productModel.price!,
                  productId: widget.productModel.productId!,
                ),
              );
              Get.showSnackbar(GetSnackBar(
                duration: Duration(milliseconds: 1000),
                message: "${widget.productModel.name!} added to Cart",
              ));
            },
            heroTag: null,
            child: Container(
              height: 150.h,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 100.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 25.h,
                      ),
                    ),
                  ),
                ],
              ),
            )),
        body: Stack(children: [
          Positioned.fill(
            top: 0,
            left: 0,
            right: 0,
            bottom: size.height * .25,
            child: CarouselSlider(
              items: photos.map((imageUrl) {
                return Image.network(
                  imageUrl.toString(),
                  fit: BoxFit.fill,
                );
              }).toList(),
              options: CarouselOptions(
                height: size.height * .6,
                pageSnapping: true,
                autoPlay: true,
                viewportFraction: 1,
                pauseAutoPlayInFiniteScroll: true,
                pauseAutoPlayOnManualNavigate: true,
                enableInfiniteScroll: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                onPageChanged: (index, reason) {
                  // keep track of current index
                  setState(() {
                    _current = index;
                  });
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          Positioned(
            bottom: size.height * .34,
            right: size.width * .40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: photos.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.black
                                : Colors.white)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
          ),
          Positioned(
              bottom: size.height * .34,
              right: size.width * .1,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: const Icon(Icons.favorite),
              )),
          Positioned(
              bottom: size.height * .34,
              left: size.width * .1,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.arrow_back)),
              )),
          Positioned(
              left: 0,
              right: 0,
              bottom: size.height * .010,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    ListTile(
                      title: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              widget.productModel.name!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                              ),
                            ),
                            SizedBox(width: size.width * .29),
                          ]),
                    ),
                    SizedBox(height: 15.h),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: size.height * .01,
                              ),
                              Text(
                                "Description :",
                                style: TextStyle(color: Colors.grey[500]!),
                              ),
                              SizedBox(
                                height: size.height * .01,
                              ),
                              Text(
                                widget.productModel.description!,
                                textAlign: TextAlign.justify,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Product Price :",
                                style: TextStyle(color: Colors.grey[500]!),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Text(
                                    "\$",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    widget.productModel.price!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ]))
                  ],
                ),
              ))
        ]),
      ),
    );
  }
}
