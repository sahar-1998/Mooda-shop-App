import 'package:Modda_shop/screens/auth/resetpassword_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:Modda_shop/api/api_helper.dart';
import 'package:Modda_shop/api/controller/auth_api_controller.dart';
import 'package:Modda_shop/widget/widget_button.dart';
import 'package:Modda_shop/widget/custom_text_feild.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> with ApiHelper {
  late TextEditingController _phoneTextEditingController;
  String? _code;

  @override
  void initState() {
    // TODO: implement initState
    _phoneTextEditingController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#01221D"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/Logo.png',
                  width: 40.w,
                ),
                SizedBox(width: 12.w),
                Text('Shop',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40.sp,
                        fontFamily: 'Poppins')),
                Text('per',
                    style: TextStyle(
                        color: HexColor("#07BFA5"),
                        fontWeight: FontWeight.bold,
                        fontSize: 40.sp,
                        fontFamily: 'Poppins')),
              ],
            ),
            SizedBox(
              height: 50.h,
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              height: 500.h,
              width: 500.w,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back_ios)),
                        SizedBox(
                          width: 20.w,
                        ),
                        Text(
                          'Forget Password ',
                          style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          'Please enter your phone number, we will send an verify code.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.grey,
                              fontSize: 14.sp)),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    AppTextField(
                      hint: 'Phone number',
                      controller: _phoneTextEditingController,
                      prefixIcon: Icons.phone,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    WidgetButton(
                        onPress: () async => await performForgetPassword(),
                        text: ' Send',
                        color: HexColor("#07BFA5")),
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  Future<void> performForgetPassword() async {
    if (checkData()) {
      await forgetPassword();
    }
  }

  bool checkData() {
    if (_phoneTextEditingController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(
      context,
      message: 'Enter required data!',
      error: true,
    );
    return false;
  }

  Future<void> forgetPassword() async {
    bool status = await AuthApiController().forgetPassword(
      context,
      phone: _phoneTextEditingController.text,
    );
    // if (status) Navigator.pushReplacementNamed(context, '/reset_password_screen');
    if (status) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ResetPassword(phone: _phoneTextEditingController.text),
        ),
      );
    }
  }
}
