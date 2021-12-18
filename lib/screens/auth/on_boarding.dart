import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:Modda_shop/widget/on_boarding_content.dart';
import 'package:Modda_shop/widget/onboarding_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late PageController _pageController;

  int _currentpage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Visibility(
              visible: _currentpage < 2,
              replacement: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/Sign_in');
                },
                child: Text(
                  'Start',
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600),
                ),
              ),
              child: TextButton(
                onPressed: () => _pageController.animateToPage(2,
                    duration: Duration(seconds: 1), curve: Curves.easeInOut),
                child: Text('Skip',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: 'Poppins',
                        color: Colors.black)),
              ),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: 0.w,
                maxWidth: double.infinity,
                minHeight: 50.h,
                maxHeight: 580.h),
            child: PageView(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              onPageChanged: (value) {
                setState(() {
                  _currentpage = value;
                  print(value);
                });
              },
              children: [
                OnBoardingContent(
                  title: 'A wide range of products ',
                  subtitle:
                      'Shopper allows customers to choose a product or service of their choice from any supplier anywhere in the world.',
                  imagepath: 'images/im1.png',
                ),
                OnBoardingContent(
                  title: 'Get anything pickup & delivered at your doorstep ',
                  subtitle:
                      'Shopper allows customers to choose a product or service of their choice from any supplier anywhere in the world.',
                  imagepath: 'images/im2.png',
                ),
                OnBoardingContent(
                  title: 'A wide range of products ',
                  subtitle:
                      'Shopper allows customers to choose a product or service of their choice from any supplier anywhere in the world.',
                  imagepath: 'images/im3.png',
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  _pageController.previousPage(
                      duration: Duration(seconds: 1), curve: Curves.easeInOut);
                },
                icon: Icon(Icons.arrow_back_ios),
                color: _currentpage > 0 ? Colors.black : Colors.grey,
              ),
              Visibility(
                visible: _currentpage < 2,
                maintainAnimation: true,
                maintainState: true,
                maintainSize: true,
                child: IconButton(
                  onPressed: () {
                    _pageController.nextPage(
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeIn);
                  },
                  icon: Icon(Icons.arrow_forward_ios, color: Colors.black),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OnBoardingIndicator(
                marginEnd: 10,
                selected: _currentpage == 0,
              ),
              OnBoardingIndicator(
                marginEnd: 10,
                selected: _currentpage == 1,
              ),
              OnBoardingIndicator(
                selected: _currentpage == 2,
              )
            ],
          )
        ],
      ),
    );
  }
}
