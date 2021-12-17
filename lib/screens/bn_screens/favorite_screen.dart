import 'package:Modda_shop/api/controller/favourite_api_controller.dart';
import 'package:Modda_shop/models/product_details.dart';
import 'package:flutter/material.dart';
import 'package:Modda_shop/screens/bn_screens/product_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Modda_shop/api/controller/home_api_controller.dart';
import 'package:Modda_shop/models/category.dart';
import 'package:Modda_shop/models/product.dart';
import 'package:Modda_shop/models/sub_category.dart';
import 'package:Modda_shop/screens/bn_screens/products_screen.dart';
import 'package:Modda_shop/widget/category_widget.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({
    Key? key,
  }) : super(key: key);

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late Future<List<ProudctDetails>> _future;

  List<ProudctDetails> _favourite = <ProudctDetails>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = FavoriteProductApiController().getFavoriteProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'favourite ',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          backgroundColor: Color(0xFFf48fb1),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.popAndPushNamed(context, '/main_screen');
            },
          )),
      body: FutureBuilder<List<ProudctDetails>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            _favourite = snapshot.data ?? [];
            return GridView.builder(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              itemCount: _favourite.length,
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
                            builder: (context) => ProductDetailsScreen(
                                proudct: _favourite[index])));
                  },
                  child: SizedBox(
                    height: 350,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // child: Column(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      child: Image.network(
                        _favourite[index].imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        height: 150,
                      ),
                      // const SizedBox(height: 15),
                      // Text(
                      //   _subCategories[index].nameEn,
                      //   style: const TextStyle(
                      //       fontFamily: 'Poppins',
                      //       color: Colors.black,
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 18),
                      // )
                      //   ],
                      // ),
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
