import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Modda_shop/api/api_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Modda_shop/api/controller/auth_api_controller.dart';
import 'package:Modda_shop/api/controller/home_api_controller.dart';
import 'package:Modda_shop/models/contact_request.dart';
import 'package:Modda_shop/widget/custom_text_feild.dart';
import 'package:Modda_shop/widget/widget_button.dart';

class ContactRequest extends StatefulWidget {
  const ContactRequest({Key? key}) : super(key: key);

  @override
  _ContactRequestState createState() => _ContactRequestState();
}

class _ContactRequestState extends State<ContactRequest> with ApiHelper {
  late TextEditingController _subjectTextEditingController;
  late TextEditingController _messageTextEditingController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _subjectTextEditingController = TextEditingController();
    _messageTextEditingController = TextEditingController();
  }
  @override
  void dispose() {
    _subjectTextEditingController.dispose();
    _messageTextEditingController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(

        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, color: Colors.black,)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Contact Us' , style:TextStyle(fontFamily: 'Poppins' , fontWeight: FontWeight.bold, fontSize:18 , color: Colors.black)),),


      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            margin: const EdgeInsets.all(20.0),
            height: 500.h,
            width: 500.w,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Send a message for us !  ',
                    style: TextStyle(
                      color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  AppTextField(
                    hint: 'Subject',
                    controller: _subjectTextEditingController,
                    prefixIcon: Icons.subject,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  AppTextField(
                    hint: 'Message',
                    controller: _messageTextEditingController,
                    prefixIcon: Icons.message,

                  ),

                  SizedBox(
                    height: 80.h,
                  ),
                  WidgetButton(
                      onPress: () async => await performContactRequest(),
                      text: 'Send ', color: Colors.white,

                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> performContactRequest() async {
    if (checkData()) {
      await Request();
    }
  }

  bool checkData() {
    if (_subjectTextEditingController.text.isNotEmpty &&
        _messageTextEditingController.text.isNotEmpty )
        {
      return true;
    }
    showSnackBar(
      context,
      message: 'Enter required data!',
      error: true,
    );
    return false;
  }

  Future<void> Request() async {
    bool status = await HomeApiController().contactRequest(context, contactRequest: contactRequest);
    if (status) Navigator.pop(context);
  }

  ContactRequestModel get contactRequest {
    ContactRequestModel contact = ContactRequestModel();
    contact.message = _messageTextEditingController.text;
    contact.subject = _subjectTextEditingController.text;
    return contact;
  }
}
