import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:Modda_shop/api/api_helper.dart';
import 'package:Modda_shop/api/controller/auth_api_controller.dart';
import 'package:Modda_shop/widget/widget_button.dart';
import 'package:Modda_shop/widget/custom_text_feild.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with ApiHelper {
  late TextEditingController _phoneTextEditingController;
  late TextEditingController _passwordTextEditingController;
  late TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _phoneTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = navigateToRegisterScreen;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneTextEditingController.dispose();
    _passwordTextEditingController.dispose();
  }

  void navigateToRegisterScreen() {
    Navigator.pushNamed(context, '/create_account');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        //clipBehavior: Clip.none,
        child: Stack(
          overflow:Overflow.visible,
          //fit: StackFit.passthrough,
          children: [
            Container(
              child: Image.asset(
                'images/launch.png',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: 85.h),
                    Text(
                      'MODDA',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40.sp,
                          fontFamily: 'Poppins'),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Sign In ',
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          AppTextField(
                            hint: 'Phone number',
                            controller: _phoneTextEditingController,
                            prefixIcon: Icons.phone,
                            keyboardType: TextInputType.phone,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          AppTextField(
                            hint: 'password',
                            controller: _passwordTextEditingController,
                            prefixIcon: Icons.remove_red_eye_rounded,
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/forget_password');
                            },
                            child: const Align(
                              alignment: Alignment.topRight,
                              child: Text('Forget Password ? ',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700)),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          WidgetButton(
                            onPress: () async => await performLogin(),
                            text: 'Sign In',
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Don\'t have an account?',
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              children: [
                                const TextSpan(text: ' '),
                                TextSpan(
                                  recognizer: _tapGestureRecognizer,
                                  text: 'Create Now!',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> performLogin() async {
    if (checkData()) {
      await login();
    }
  }

  bool checkData() {
    if (_phoneTextEditingController.text.isNotEmpty &&
        _passwordTextEditingController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(
      context,
      message: 'Enter required data!',
      error: true,
    );
    return false;
  }

  Future<void> login() async {
    bool status = await AuthApiController().login(
      context,
      mobile: _phoneTextEditingController.text,
      password: _passwordTextEditingController.text,
    );
    if (status) Navigator.pushReplacementNamed(context, '/main_screen');
  }
}
