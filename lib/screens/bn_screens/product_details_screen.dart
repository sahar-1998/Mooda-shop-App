// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:Modda_shop/api/controller/home_api_controller.dart';
// import 'package:Modda_shop/models/product.dart';
// import 'package:Modda_shop/widget/widget_button.dart';
//
// class ProductDetailsScreen extends StatefulWidget {
//   const ProductDetailsScreen({Key? key, required this.product})
//       : super(key: key);
//
//   final Product product;
//
//   @override
//   _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
// }
//
// class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
//   late Future<Product?> _future;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _future =
//         HomeApiController().getProductDetails(widget.product.id.toString());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.product.nameEn,
//           style: const TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context, );
//           },
//           icon: const Icon(Icons.arrow_back_ios),
//           color: Colors.black,
//         ),
//       ),
//       body: FutureBuilder<Product?>(
//           future: _future,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasData) {
//               return ListView(
//                 physics: const BouncingScrollPhysics(),
//                 children: [
//                   SingleChildScrollView(
//                     physics: const BouncingScrollPhysics(),
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: [
//                         Container(
//                           height: 180.h,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Image.network(
//                             snapshot.data!.images[0].imageUrl,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 10.w,
//                         ),
//                         Container(
//                           width: 180.w,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child:
//                               Image.network(snapshot.data!.images[1].imageUrl),
//                         ),
//                         SizedBox(
//                           width: 10.w,
//                         ),
//                         Container(
//                           height: 180.h,
//                           // width: 300.w,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child:
//                               Image.network(snapshot.data!.images[2].imageUrl),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Text(snapshot.data!.nameEn,
//                           style: TextStyle(
//                               fontSize: 22.sp,
//                               letterSpacing: 2,
//                               fontFamily: 'Poppins',
//                               fontWeight: FontWeight.w700)),
//                       Text('${snapshot.data!.price} \$ ',
//                           style: TextStyle(
//                               fontSize: 25.sp,
//                               letterSpacing: 2,
//                               fontFamily: 'Poppins',
//                               fontWeight: FontWeight.w700)),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Text(
//                       ' Product info:',
//                       style: TextStyle(
//                           fontFamily: 'Poppins',
//                           fontSize: 18,
//                           color: Colors.grey,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Text(
//                       snapshot.data!.infoEn,
//                       style: TextStyle(fontFamily: 'Poppins', fontSize: 15),
//                     ),
//                   ),
//                   Align(
//                       alignment: AlignmentDirectional.topEnd,
//                       child: IconButton(
//                         onPressed: () {
//
//                         },
//                         icon: Icon(Icons.favorite),
//                         iconSize: 40,
//                         color: Colors.grey,
//                       )),
//                   SizedBox(
//                     height: 30.h,
//                   ),
//                   Row(
//                     children: [
//                       SizedBox(
//                         width: 10.w,
//                       ),
//                       WidgetButton(
//                         onPress: () {},
//                         text: 'Buy Now',
//                         color:  Color(0xFFf48fb1),
//                       ),
//                       Spacer(),
//                       IconButton(
//                         onPressed: () {},
//                         icon: Icon(Icons.shopping_cart),
//                         iconSize: 35,
//                         color: Color(0xFFf48fb1),
//                       )
//                     ],
//                   )
//                 ],
//               );
//             } else {
//               return const Center(
//                 child: Text('NO DATA'),
//               );
//             }
//           }),
//     );
//   }
// }
import 'package:Modda_shop/api/api_helper.dart';
import 'package:Modda_shop/get/product_controller.dart';
import 'package:Modda_shop/models/product_details.dart';
import 'package:Modda_shop/prefs/shared_pref_controller.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProudctDetails proudct;

  ProductDetailsScreen({required this.proudct});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with ApiHelper {
  ProudctGetController controller = Get.put(ProudctGetController());

  void initState() {
    Future.delayed(Duration.zero, () async {
      await controller.getproudctdetails(id: widget.proudct.id);
    });
    super.initState();
  }

  int cardIncrement = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: const Text(
          'Proudct details',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GetX<ProudctGetController>(
        builder: (ProudctGetController controller) {
          return controller.loading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 400,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        // enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                      items: controller.proudctdetails.value!.images
                          .map((Images image) {
                        return Builder(
                          builder: (BuildContext context) {
                            return CachedNetworkImage(
                              imageUrl: image.imageUrl,
                              fit: BoxFit.cover,
                              height: 400,
                              width: 300,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: 350,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    SharedPrefController().languageCode == 'en'
                                        ? controller
                                            .proudctdetails.value!.nameEn
                                        : controller
                                            .proudctdetails.value!.nameAr,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      controller.addFavoriteProducts(
                                          product:
                                              controller.proudctdetails.value!,
                                          context: context);
                                    },
                                    child: Container(
                                      width: 55,
                                      height: 55,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: controller.proudctdetails
                                                  .value!.isFavorite
                                              ? Colors.red
                                              : Colors.grey),
                                      child: const Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Price:\$${controller.proudctdetails.value!.price}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: 'Poppins'),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Description:',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: ''),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Text(
                                  SharedPrefController().languageCode == 'en'
                                      ? controller.proudctdetails.value!.infoEn
                                      : controller.proudctdetails.value!.infoAr,
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
        },
      ),
    );
  }
}
