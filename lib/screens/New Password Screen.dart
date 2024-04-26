import 'dart:ui';
import 'package:ed_management/Colors.dart';
import 'package:ed_management/screens/Forgot%20Password%20Screen.dart';
import 'package:ed_management/screens/HomePage.dart';
import 'package:ed_management/screens/Login%20Screen.dart';
import 'package:ed_management/services/ApisProvider.dart';
import 'package:ed_management/utill/textUtill.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../services/custom loader.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
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
                Center(child: TextUtil(text: "NEW PASSWORD ?",size: 20,)),
                // const   Spacer(),
                const   SizedBox(height: 60,),
                Container(
                  height: 45,
                  // decoration:const  BoxDecoration(
                  //     border: Border(bottom: BorderSide(color: Colors.white))
                  // ),
                  child:TextFormField(
                    // textAlign: TextAlign.center,
                    controller: password,
                    cursorColor: appPrimary,
                    style: const TextStyle(color: appPrimary),
                    decoration:const  InputDecoration(
                      labelText: 'Password',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary))
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 45,
                  // decoration:const  BoxDecoration(
                  //     border: Border(bottom: BorderSide(color: Colors.white))
                  // ),
                  child:TextFormField(
                    // textAlign: TextAlign.center,
                    controller: confirmPassword,
                    cursorColor: appPrimary,
                    style: const TextStyle(color: appPrimary),
                    decoration:const  InputDecoration(
                      labelText: 'Confirm Password',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary))
                    ),
                  ),
                ),
                const   SizedBox(height: 40,),
                InkWell(
                  onTap: () async{
                    if(password.text == '') {
                      toastification.show(
                        type: ToastificationType.warning,
                        context: context,
                        title: Text('Please enter new password'),
                        autoCloseDuration: const Duration(seconds: 3),
                      );
                    } else if(password.text != confirmPassword.text) {
                      toastification.show(
                        type: ToastificationType.warning,
                        context: context,
                        title: Text('Password not match'),
                        autoCloseDuration: const Duration(seconds: 3),
                      );
                    } else {
                      fetchData(context);
                      var response = await ApiService().forgotPassword(username.text.toString(), '', isLoginByOtp, password.text);
                      print(response);
                      if(response['status'] == true) {
                        Navigator.pop(context);
                        toastification.show(
                          type: ToastificationType.success,
                          context: context,
                          title: Text('Password changed sucessfully'),
                          autoCloseDuration: const Duration(seconds: 5),
                        );
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));

                      } else {
                        Navigator.pop(context);
                        toastification.show(
                          type: ToastificationType.error,
                          context: context,
                          title: Text('${response['message']}'),
                          autoCloseDuration: const Duration(seconds: 5),
                        );
                      }
                    }
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: appPrimary,
                      // borderRadius: BorderRadius.circular(30)
                    ),
                    alignment: Alignment.center,
                    child: TextUtil(text: "SUBMIT",color: Colors.white,),
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

