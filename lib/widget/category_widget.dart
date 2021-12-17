import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CategoryWidget extends StatelessWidget {
  String imageUrl ;
  String name;
   CategoryWidget({
    Key? key,
   required  this.name,
     required this.imageUrl

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()async{
        // navigate to sub categories
       // await HomeApiController().getSubCategory(id);
      },
      child: Container(
        margin: EdgeInsets.all(15),
          width: 150.w,
         // height: 88.h,
          decoration: BoxDecoration(color: Colors.grey.shade200 , borderRadius: BorderRadius.circular(20)),
          child: Row(children: [
            Text(name , style: TextStyle(fontSize: 14.sp,fontFamily: 'Poppins', fontWeight: FontWeight.bold),),
              SizedBox(width: 15.w,),
            Image.network(imageUrl, width: 50.w,height:100.h,fit: BoxFit.contain,),

          ],
          ),

      ),

    );
  }
}