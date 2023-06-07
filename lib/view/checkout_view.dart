import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopzler/view/get_location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../constants.dart';
import '../core/services/location_servises.dart';
import '../core/viewmodel/cart_viewmodel.dart';
import '../core/viewmodel/checkout_viewmodel.dart';
import '../core/viewmodel/control_viewmodel.dart';
import 'control_view.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text.dart';
import 'widgets/custom_textFormField.dart';

class CheckoutView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final LocationService locationService = LocationService();
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
                    text: 'Checkout',
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
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 24.h),
                child: Form(
                  key: _formKey,
                  child: GetBuilder<CheckoutViewModel>(
                    init: Get.find<CheckoutViewModel>(),
                    builder: (controller) => Column(
                      children: [
                        ListViewProducts(),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomButton(
                          "Get Location Auto",
                          () {
                            Get.to(() => GetLocation());
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomTextFormField(
                          title: 'Locaiton',
                          initialValue:
                              Get.put<ControlViewModel>(ControlViewModel())
                                  .words
                                  .join(","),
                          hintText: "your location",
                          validatorFn: (value) {
                            if (value!.isEmpty || value.length < 4)
                              return 'Please enter valid street name.';
                            return null;
                          },
                          onSavedFn: (value) {
                            controller.street = value;
                          },
                        ),
                        // SizedBox(
                        //   height: 20.h,
                        // ),
                        // CustomTextFormField(
                        //   title: 'City',
                        //   initialValue:
                        //       Get.put<ControlViewModel>(ControlViewModel())
                        //               .words[1] ??
                        //           "new dammita ",
                        //   hintText:
                        //       Get.put<ControlViewModel>(ControlViewModel())
                        //               .words[1] ??
                        //           "new dammita ",
                        //   validatorFn: (value) {
                        //     if (value!.isEmpty || value.length < 4)
                        //       return 'Please enter valid city name.';
                        //     return null;
                        //   },
                        //   onSavedFn: (value) {
                        //     controller.city = value;
                        //   },
                        // ),
                        // SizedBox(
                        //   height: 20.h,
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: CustomTextFormField(
                        //         title: 'State',
                        //         initialValue: Get.put<ControlViewModel>(
                        //                     ControlViewModel())
                        //                 .words[0] ??
                        //             "cairo",
                        //         hintText: Get.put<ControlViewModel>(
                        //                     ControlViewModel())
                        //                 .words[0] ??
                        //             "cairo",
                        //         validatorFn: (value) {
                        //           if (value!.isEmpty || value.length < 4)
                        //             return 'Please enter valid state name.';
                        //           return null;
                        //         },
                        //         onSavedFn: (value) {
                        //           controller.state = value;
                        //         },
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 36.w,
                        //     ),
                        //     Expanded(
                        //       child: CustomTextFormField(
                        //         title: 'Country',
                        //         initialValue: Get.put<ControlViewModel>(
                        //                     ControlViewModel())
                        //                 .words[3] ??
                        //             "Egypt",
                        //         hintText: Get.put<ControlViewModel>(
                        //                     ControlViewModel())
                        //                 .words[3] ??
                        //             "Egypt",
                        //         validatorFn: (value) {
                        //           if (value!.isEmpty || value.length < 4)
                        //             return 'Please enter valid city name.';
                        //           return null;
                        //         },
                        //         onSavedFn: (value) {
                        //           controller.country = value;
                        //         },
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 20.h,
                        // ),
                        // CustomTextFormField(
                        //   title: 'Phone Number',
                        //   hintText: '+20123456789',
                        //   keyboardType: TextInputType.phone,
                        //   validatorFn: (value) {
                        //     if (value!.isEmpty || value.length < 10)
                        //       return 'Please enter valid number.';
                        //     return null;
                        //   },
                        //   onSavedFn: (value) {
                        //     controller.phone = value;
                        //   },
                        // ),
                        SizedBox(
                          height: 38.h,
                        ),
                        SizedBox(
                          height: 38.h,
                        ),
                        CustomButton(
                          'SUBMIT',
                          () async {
                            controller.city = "dammita";
                            controller.country = "Egypt";
                            controller.state = "new dammita";
                            controller.phone = "01024021764";
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              await controller.addCheckoutToFireStore();
                              launchWhatsApp();

                              Get.dialog(
                                AlertDialog(
                                  content: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.check_circle_outline_outlined,
                                          color: primaryColor,
                                          size: 200.h,
                                        ),
                                        CustomText(
                                          text: 'Order Submitted',
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                          alignment: Alignment.center,
                                        ),
                                        SizedBox(
                                          height: 40.h,
                                        ),
                                        CustomButton(
                                          'Done',
                                          () {
                                            Get.off(ControlView());
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                barrierDismissible: false,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

launchWhatsApp() async {
  try {
    final link = WhatsAppUnilink(
        phoneNumber: '+201024021764',
        text: Get.put<CartViewModel>(CartViewModel())
                .cartProducts
                .map((e) => '''Product name :${e.name} 
Quantity: ${e.quantity}                 Price : ${int.parse(e.price) * e.quantity}''')
                .toList()
                .toString() +
            "Total : " +
            Get.put<CartViewModel>(CartViewModel()).totalPrice.toString() +
            "Location Link : " +
            "https://www.google.com/maps/@${Get.put<ControlViewModel>(ControlViewModel()).locationLat.toString()},${Get.put<ControlViewModel>(ControlViewModel()).locationLag.toString()},15z?entry=ttu");

    await launch('$link');
  } catch (e) {
    print(e);
  }
}

class ListViewProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartViewModel>(
      builder: (controller) => Column(
        children: [
          Container(
            height: 180.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.cartProducts.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 120.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  controller.cartProducts[index].image),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(12.r),
                          color: Colors.white,
                        ),
                        height: 120.h,
                        width: 120.w,
                      ),
                      CustomText(
                        text: controller.cartProducts[index].name,
                        fontSize: 14,
                        maxLines: 1,
                      ),
                      CustomText(
                        text:
                            '\$${controller.cartProducts[index].price} x ${controller.cartProducts[index].quantity}',
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ],
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
          SizedBox(
            height: 12.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                text: 'TOTAL: ',
                fontSize: 14,
                color: Colors.grey,
              ),
              CustomText(
                text: '\$${controller.totalPrice.toString()}',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
