import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Modda_shop/api/controller/home_api_controller.dart';
import 'package:Modda_shop/models/category.dart';
import 'package:Modda_shop/models/product.dart';
import 'package:Modda_shop/screens/bn_screens/sub_categories_screen.dart';
import 'package:Modda_shop/widget/category_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late Future<List<Category>> _future;

  List<Category> _categories = <Category>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = HomeApiController().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Category>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            _categories = snapshot.data ?? [];
            return GridView.builder(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              itemCount: _categories.length,
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
                            builder: (context) => SubCategoriesScreen(
                                id: _categories[index].id)));
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              NetworkImage(_categories[index].imageUrl),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          _categories[index].nameEn,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
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
