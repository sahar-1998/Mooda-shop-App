import 'package:Modda_shop/screens/bn_screens/product_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Modda_shop/api/controller/home_api_controller.dart';
import 'package:Modda_shop/models/category.dart';
import 'package:Modda_shop/models/product.dart';
import 'package:Modda_shop/models/sub_category.dart';
import 'package:Modda_shop/screens/bn_screens/products_screen.dart';
import 'package:Modda_shop/widget/category_widget.dart';

class SubCategoriesScreen extends StatefulWidget {
  const SubCategoriesScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  _SubCategoriesScreenState createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  late Future<List<SubCategory>> _future;

  List<SubCategory> _subCategories = <SubCategory>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = HomeApiController().getSubCategories(widget.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Sub Category',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: FutureBuilder<List<SubCategory>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            _subCategories = snapshot.data ?? [];
            return GridView.builder(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              itemCount: _subCategories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProudctScreen(id: _subCategories[index].id)));
                  },
                  child: SizedBox(
                    height: 350,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.network(
                        _subCategories[index].imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        height: 200,
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.warning, size: 80),
                Center(
                  child: Text(
                    'No Data !',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

// import 'package:Modda_shop/get/subcategory_controller.dart';
// import 'package:Modda_shop/prefs/shared_pref_controller.dart';
// import 'package:Modda_shop/screens/bn_screens/products_screen.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class SubCategoriesScreen extends StatefulWidget {
//   final int id;
//
//   SubCategoriesScreen({required this.id});
//
//   @override
//   _SubCategoriesScreenState createState() => _SubCategoriesScreenState();
// }
//
// class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
//   SubCategoryController controller = Get.put(SubCategoryController());
//
//   void initState() {
//     Future.delayed(Duration.zero, () async {
//       await controller.getSubCategory(id: widget.id);
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           'Subcategories',
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: GetX<SubCategoryController>(
//         builder: (SubCategoryController controller) {
//           return controller.subcategories.isEmpty
//               ? Center(
//                   child: CircularProgressIndicator(),
//                 )
//               : GridView.builder(
//                   padding: EdgeInsets.only(
//                       top: 30,
//                       left: 30,
//                       right: 30),
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 15,
//                     mainAxisSpacing: 24,
//                     childAspectRatio: 140 / 300,
//                   ),
//                   itemCount: controller.subcategories.length,
//                   itemBuilder: (context, index) {
//                     return GestureDetector(
//                       onTap: () {
//                         Get.to(ProudctScreen(
//                             id: controller.subcategories[index].id));
//                       },
//                       child: Container(
//                         clipBehavior: Clip.antiAlias,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5)),
//                         height: 300,
//                         width: 140,
//                         child: Stack(fit: StackFit.expand, children: [
//                           CachedNetworkImage(
//                             imageUrl: controller.subcategories[index].imageUrl,
//                             fit: BoxFit.cover,
//                             width: double.infinity,
//                             placeholder: (context, url) =>
//                                 Center(child: CircularProgressIndicator()),
//                             errorWidget: (context, url, error) =>
//                                 Icon(Icons.error),
//                           ),
//                           Center(
//                             child: Container(
//                               color: Colors.black.withOpacity(0.7),
//                               alignment: Alignment.center,
//                               height: 50,
//                               child: Text(
//                                 SharedPrefController().languageCode == 'en'
//                                     ? controller.subcategories[index].nameEn
//                                     : controller.subcategories[index].nameAr,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ]),
//                       ),
//                     );
//                   });
//         },
//       ),
//     );
//   }
// }
