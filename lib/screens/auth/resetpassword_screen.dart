import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:Modda_shop/api/api_helper.dart';
import 'package:Modda_shop/api/controller/auth_api_controller.dart';
import 'package:Modda_shop/widget/code_text_feild.dart';
import 'package:Modda_shop/widget/widget_button.dart';
import 'package:Modda_shop/widget/custom_text_feild.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key , required this.phone}) : super(key: key);
 final String phone;

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> with ApiHelper {

  late TextEditingController _firstCodeTextController;
  late TextEditingController _secondCodeTextController;
  late TextEditingController _thirdCodeTextController;
  late TextEditingController _fourthCodeTextController;
  late TextEditingController _password;
  late TextEditingController _confirmPassword;

  late FocusNode _firstFocusNode;
  late FocusNode _secondFocusNode;
  late FocusNode _thirdFocusNode;
  late FocusNode _fourthFocusNode;

  String? _code;

  @override
  void initState() {
    // TODO: implement initState

    _firstCodeTextController = TextEditingController();
    _secondCodeTextController = TextEditingController();
    _thirdCodeTextController = TextEditingController();
    _fourthCodeTextController = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();

    _firstFocusNode = FocusNode();
    _secondFocusNode = FocusNode();
    _thirdFocusNode = FocusNode();
    _fourthFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _firstCodeTextController.dispose();
    _secondCodeTextController.dispose();
    _thirdCodeTextController.dispose();
    _fourthCodeTextController.dispose();
    _password.dispose();
    _confirmPassword.dispose();

    _firstFocusNode.dispose();
    _secondFocusNode.dispose();
    _thirdFocusNode.dispose();
    _fourthFocusNode.dispose();
    String? code;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: HexColor("#01221D"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(child: Column(children: [
            SizedBox(height: 20.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/Logo.png',width: 40.w,),
               SizedBox(width:12.w),
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
           SizedBox(height: 50.h,),
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
                   SizedBox(height: 20.h,),

                  Row(

                    children: [
                      GestureDetector(
                          onTap:(){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_ios)),
                      SizedBox(width: 20.w,),
                        Text('Reset Password' , style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold,fontFamily: 'Poppins'),),
                    ],
                  ),
                   SizedBox(height: 10.h,),
                   Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        'Please enter verify code that we’ve sent to your phone number.',


                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins', color: Colors.grey, fontSize: 14.sp)),
                  ),
                   SizedBox(height: 20.h,),
                  Row(
                    children: [
                      Expanded(
                        child: CodeTextField(
                          textEditingController: _firstCodeTextController,
                          focusNode: _firstFocusNode,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              _secondFocusNode.requestFocus();
                            }
                          },
                        ),
                      ),
                       SizedBox(width: 10.w),
                      Expanded(
                        child: CodeTextField(
                          textEditingController: _secondCodeTextController,
                          focusNode: _secondFocusNode,
                          onChanged: (value) {
                            value.isNotEmpty
                                ? _thirdFocusNode.requestFocus()
                                : _firstFocusNode.requestFocus();
                          },
                        ),
                      ),
                       SizedBox(width: 10.w),
                      Expanded(
                        child: CodeTextField(
                          textEditingController: _thirdCodeTextController,
                          focusNode: _thirdFocusNode,
                          onChanged: (value) {
                            value.isNotEmpty
                                ? _fourthFocusNode.requestFocus()
                                : _secondFocusNode.requestFocus();
                          },
                        ),
                      ),
                       SizedBox(width: 10.w),
                      Expanded(
                        child: CodeTextField(
                          textEditingController: _fourthCodeTextController,
                          focusNode: _fourthFocusNode,
                          onChanged: (value) {
                            if (value.isEmpty) _thirdFocusNode.requestFocus();
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h,),
                  AppTextField(
                    hint: 'Password',
                    controller: _password,
                    prefixIcon: Icons.lock,
                    obscureText: true,
                  ),
                   SizedBox(height: 10.h),
                  AppTextField(
                    hint: 'Password Confirmation',
                    controller: _confirmPassword,
                    prefixIcon: Icons.lock,
                    obscureText: true,
                  ),
                   SizedBox(height: 50.h,),



                  WidgetButton(onPress: ()async{
                        await  performResetPassword();
                  }, text: ' Save Changes', color: HexColor("#07BFA5")),



                ],),
            ),
          )
        ],)),
      ),
    );


  }
  Future<void> performResetPassword() async {
    if (checkData()) {
      await resetPassword();
    }
  }

  bool checkData() {
    if (checkCode() && checkPassword()) {
      return true;
    }
    return false;
  }

 bool checkPassword(){
    if(_password.text.isNotEmpty && _confirmPassword.text.isNotEmpty){

      if(_password.text == _confirmPassword.text){
        return true;
      }
      showSnackBar(context, message: 'Password confirmation error!' , error: true);
      return false;
    }
    showSnackBar(context, message: 'Enter new Password ' , error: true);
    return false;
 }

  bool checkCode() {
    if (_firstCodeTextController.text.isNotEmpty &&
        _secondCodeTextController.text.isNotEmpty &&
        _thirdCodeTextController.text.isNotEmpty &&
        _fourthCodeTextController.text.isNotEmpty) {
      getVerificationCode();
      return true;
    }
    showSnackBar(
      context,
      message: 'Enter verification code',
      error: true,
    );
    return false;
  }
  String getVerificationCode() {
    return _code = _firstCodeTextController.text +
        _secondCodeTextController.text +
        _thirdCodeTextController.text +
        _fourthCodeTextController.text;
  }
  Future<void> resetPassword() async {
    bool status = await AuthApiController().resetPassword(context ,phone:widget.phone , code: _code!, password: _password.text);
    if (status) Navigator.pop(context);
  }
}
