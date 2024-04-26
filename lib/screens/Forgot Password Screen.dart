import 'dart:ui';
import 'package:ed_management/Colors.dart';
import 'package:ed_management/screens/Login%20Screen.dart';
import 'package:ed_management/screens/Send%20Otp%20Screen.dart';
import 'package:ed_management/services/ApisProvider.dart';
import 'package:ed_management/services/custom%20loader.dart';
import 'package:ed_management/utill/textUtill.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

// TextEditingController username = TextEditingController();
class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration:  BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/backgronds.jpg'),fit: BoxFit.fill
          ),
        ),
        // alignment: Alignment.center,
        child: Container(
          // height: 400,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white.withOpacity(0.9),

          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const   SizedBox(height: 40,),
                Center(child: Image.asset('assets/EdPlus-AI-Logoss.png', color: appPrimary,height: 80,)),
                const   SizedBox(height: 10,),
                Center(child: TextUtil(text: "FORGET PASSWORD ?",size: 20,)),
                // const   Spacer(),
                const   SizedBox(height: 60,),
                Container(
                  height: 50,
                  // decoration:const  BoxDecoration(
                  //     border: Border(bottom: BorderSide(color: Colors.white))
                  // ),
                  alignment: Alignment.center,
                  child:TextFormField(
                    controller: username,
                    cursorColor: appPrimary,
                    style: const TextStyle(color: appPrimary, fontSize: 14),
                    decoration:const  InputDecoration(
                      // hintText: 'Username',
                        labelText: 'Username',
                        // labelStyle: TextStyle(color: appPrimary),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                    ),
                  ),
                ),
                const   SizedBox(height: 40,),
                InkWell(
                  onTap: () async{
                    if(username.text == '') {
                      toastification.show(
                        type: ToastificationType.warning,
                        context: context,
                        title: Text('Please enter user name'),
                        autoCloseDuration: const Duration(seconds: 3),
                      );
                    } else {
                      fetchData(context);
                      var response = await ApiService().forgotPassword(username.text.toString(), '', false, '');
                      print(response);
                      if(response['status'] == true) {
                        toastification.show(
                          type: ToastificationType.success,
                          context: context,
                          title: Text('Otp Sent Sucessfully!'),
                          autoCloseDuration: const Duration(seconds: 5),
                        );
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SendotpScreen()));
                      } else {
                        toastification.show(
                          type: ToastificationType.error,
                          context: context,
                          title: Text('${response['message']}'),
                          autoCloseDuration: const Duration(seconds: 5),
                        );
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: appPrimary,
                      // borderRadius: BorderRadius.circular(30)
                    ),
                    alignment: Alignment.center,
                    child: TextUtil(text: "SEND OTP",color: Colors.white,),
                  ),
                ),
                SizedBox(height: 10,),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: appPrimary),
                      color: Colors.white,
                      // borderRadius: BorderRadius.circular(30)
                    ),
                    alignment: Alignment.center,
                    child: TextUtil(text: "GO  BACK",color: appPrimary,),
                  ),
                ),
                // const   SizedBox(height: 10,),
                Spacer(),
                // Center(child: TextUtil(text: "Powered by",color: Colors.grey.shade400, size: 15,)),
                // Center(child: Image.asset('assets/EdPlus-AI-Logo.png', color: appPrimary, height: 40,)),
                // const   SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

