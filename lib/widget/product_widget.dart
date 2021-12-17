import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductWidget extends StatelessWidget {
  String imageUrl ;
  String name ;
  int price;
  ProductWidget({required this.imageUrl , required this.price , required this.name});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // navigate to product details
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
           // width: MediaQuery.of(context).size.width,
            width: 230.h,
           // height: 220,
            child: Column(
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    //width: 200,

                     imageUrl: imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
                // SizedBox(
                //   height: 10.h,
                // ),
                Container(
                  height: 40.h,
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                            name,
                            style: TextStyle(color: Colors.black, fontFamily: 'Poppins' , fontWeight: FontWeight.bold),
                          )),
                      Spacer(),
                      Text(

                        price.toString()+'\$',

                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins' ),
                      )
                    ],
                  ),
                )
              ],

            ),
          ),
          Positioned.fill(child: Container(
            margin: EdgeInsets.all(10.0),
            child: Align(alignment: AlignmentDirectional.topEnd,
                child: Column(children: [
                  IconButton(
                    onPressed: () {
                       // add to favorite
                      // change color
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),

                ],)
            ),
          ))
        ],
      ),
    );
  }
}
