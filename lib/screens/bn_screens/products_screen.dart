// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:Modda_shop/api/controller/home_api_controller.dart';
// import 'package:Modda_shop/models/category.dart';
// import 'package:Modda_shop/models/product.dart';
// import 'package:Modda_shop/models/sub_category.dart';
// import 'package:Modda_shop/screens/product_details_screen.dart';
// import 'package:Modda_shop/widget/category_widget.dart';
//
// class ProductsScreen extends StatefulWidget {
//   const ProductsScreen({
//     Key? key,
//     required this.id,
//   }) : super(key: key);
//
//   final int id;
//
//   @override
//   _ProductsScreenState createState() => _ProductsScreenState();
// }
//
// class _ProductsScreenState extends State<ProductsScreen> {
//   late Future<List<Product>> _future;
//
//   List<Product> _products = <Product>[];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _future = HomeApiController().getProducts(widget.id.toString());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: Text(
//             'Products',
//             style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
//           ),
//           elevation: 0,
//           backgroundColor: Colors.white,
//           leading: IconButton(
//             icon: Icon(
//               Icons.arrow_back_ios,
//               color: Colors.black,
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           )),
//       body: FutureBuilder<List<Product>>(
//         future: _future,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//             _products = snapshot.data ?? [];
//             return GridView.builder(
//               physics: const BouncingScrollPhysics(),
//               padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
//               itemCount: _products.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 20,
//                 crossAxisSpacing: 10,
//               ),
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     //navigate to sub category
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => ProductDetailsScreen(
//                                 product: _products[index])));
//                   },
//                   child: Card(
//                     elevation: 4,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircleAvatar(
//                           radius: 55,
//                           backgroundImage:
//                               NetworkImage(_products[index].imageUrl),
//                         ),
//                         const SizedBox(height: 20),
//                         Text(
//                           _products[index].nameEn,
//                           style: const TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 Icon(Icons.warning, size: 80),
//                 Center(
//                   child: Text(
//                     'No Data !',
//                     style: TextStyle(
//                         fontFamily: 'Poppins',
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ],
//             );
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:Modda_shop/api/controller/home_api_controller.dart';
import 'package:Modda_shop/get/product_controller.dart';
import 'package:Modda_shop/prefs/shared_pref_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'product_details_screen.dart';

class ProudctScreen extends StatefulWidget {
  final int id;

  ProudctScreen({required this.id});

  @override
  _ProudctScreenState createState() => _ProudctScreenState();
}

class _ProudctScreenState extends State<ProudctScreen> {
  ProudctGetController controller = Get.put(ProudctGetController());

  void initState() {
    Future.delayed(Duration.zero, () async {
      await controller.getproduct(id: widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        centerTitle: true,
        title: const Text(
          'Products',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GetX<ProudctGetController>(
        builder: (ProudctGetController controller) {
          return controller.proudct.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 24,
                    childAspectRatio: 146 / 300,
                  ),
                  itemCount: controller.proudct.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(ProductDetailsScreen(
                          proudct: controller.proudct[index],
                        ));
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black12,
                        ),
                        height: 220,
                        width: 146,
                        child: Column(
                          children: [
                            Container(
                                width: double.infinity,
                                height: 240.h,
                                child: CachedNetworkImage(
                                  imageUrl: controller.proudct[index].imageUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              SharedPrefController().languageCode == 'en'
                                  ? controller.proudct[index].nameEn
                                  : controller.proudct[index].nameAr,
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins'),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "\$${controller.proudct[index].price}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Poppins'),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${controller.proudct[index].quantity} product_available'
                                  .tr,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
