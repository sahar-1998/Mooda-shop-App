import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Modda_shop/api/api_helper.dart';
import 'package:Modda_shop/api/controller/auth_api_controller.dart';
import 'package:Modda_shop/widget/code_text_feild.dart';
import 'package:Modda_shop/widget/widget_button.dart';

class VerifyCode extends StatefulWidget {
  const VerifyCode({Key? key , required this.phone}) : super(key: key);
 final String phone;
  @override
  _VerifyCodeState createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> with ApiHelper {
  late FocusNode _firstFocusNode;
  late FocusNode _secondFocusNode;
  late FocusNode _thirdFocusNode;
  late FocusNode _fourthFocusNode;

  late TextEditingController _firstCodeTextController;
  late TextEditingController _secondCodeTextController;
  late TextEditingController _thirdCodeTextController;
  late TextEditingController _fourthCodeTextController;

 late String _code;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstCodeTextController = TextEditingController();
    _secondCodeTextController = TextEditingController();
    _thirdCodeTextController = TextEditingController();
    _fourthCodeTextController = TextEditingController();
    _firstFocusNode = FocusNode();
    _secondFocusNode = FocusNode();
    _thirdFocusNode = FocusNode();
    _fourthFocusNode = FocusNode();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _firstFocusNode.dispose();
    _secondFocusNode.dispose();
    _thirdFocusNode.dispose();
    _fourthFocusNode.dispose();

    super.dispose();
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
              Image.asset('images/launch.png',width: 40.w,),
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
                      Text('Verify Code' , style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold,fontFamily: 'Poppins'),),
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


                SizedBox(height: 30.h,),

                  WidgetButton(onPress: ()async{
                    await  performActivate();
                  }, text: ' Verify', color: HexColor("#07BFA5")),



                ],),
            ),
          )
        ],)),
      ),
    );
  }
  Future<void> performActivate() async {
    if (checkData()) {
      await activate();
    }
  }

  bool checkData() {
    if (checkCode() ) {
      return true;
    }
    return false;
  }



  bool checkCode() {
    if (_firstCodeTextController.text.isNotEmpty &&
        _secondCodeTextController.text.isNotEmpty &&
        _thirdCodeTextController.text.isNotEmpty &&
        _fourthCodeTextController.text.isNotEmpty) {

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
  Future<void> activate () async{
   bool status = await AuthApiController().activate(context, phone:widget.phone , code: _code);
   if(status) Navigator.pushNamed(context, '/Sign_in');
   }


}
