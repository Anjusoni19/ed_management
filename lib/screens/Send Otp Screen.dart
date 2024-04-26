import 'dart:ui';
import 'package:ed_management/Colors.dart';
import 'package:ed_management/screens/Forgot%20Password%20Screen.dart';
import 'package:ed_management/screens/HomePage.dart';
import 'package:ed_management/screens/Login%20Screen.dart';
import 'package:ed_management/services/ApisProvider.dart';
import 'package:ed_management/utill/textUtill.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

import '../services/custom loader.dart';
import 'New Password Screen.dart';

class SendotpScreen extends StatefulWidget {
  const SendotpScreen({super.key});

  @override
  State<SendotpScreen> createState() => _SendotpScreenState();
}

class _SendotpScreenState extends State<SendotpScreen> {
  TextEditingController otp = TextEditingController();
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
                  height: 45,
                  // decoration:const  BoxDecoration(
                  //     border: Border(bottom: BorderSide(color: Colors.white))
                  // ),
                  child:TextFormField(
                    textAlign: TextAlign.center,
                    controller: otp,
                    cursorColor: appPrimary,
                    style: const TextStyle(color: appPrimary),
                    decoration:const  InputDecoration(
                        // hintText: 'Username',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary))
                    ),
                  ),
                ),
                const   SizedBox(height: 40,),
                InkWell(
                  onTap: () async{
                    if(otp.text == '') {
                      toastification.show(
                        type: ToastificationType.warning,
                        context: context,
                        title: Text('Please enter user name'),
                        autoCloseDuration: const Duration(seconds: 3),
                      );
                    } else {
                      fetchData(context);
                      var response = await ApiService().forgotPassword(username.text.toString(), otp.text.toString(), isLoginByOtp, '');
                      print(response);
                      if(response['status'] == true) {
                        var sid = response['sid'];
                        if(isLoginByOtp) {
                        var newresponse = await ApiService().getUsers(username.text.toString(), sid, isLoginByOtp, '0');
                        if(newresponse['status'] == true) {
                          var storeList =
                          ['${newresponse['name']}',
                            '${newresponse['email']}',
                            '${newresponse['fname']}',
                            '${username.text}',
                            '${newresponse['post']}',
                            '${newresponse['photo']}',
                          ];
                          print(storeList);
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('isLogin', true);
                          await prefs.setStringList('data', storeList);
                          await prefs.setString('userid', newresponse['userid']);
                          await prefs.setString('token', newresponse['token']);
                          toastification.show(
                            type: ToastificationType.success,
                            context: context,
                            title: Text('Login Sucessfully!'),
                            autoCloseDuration: const Duration(seconds: 5),
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: '',)));
                        } else {
                          toastification.show(
                            type: ToastificationType.error,
                            context: context,
                            title: Text('${response['message']}'),
                            autoCloseDuration: const Duration(seconds: 5),
                          );
                          Navigator.pop(context);
                        }
                        } else {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NewPasswordScreen()));
                        }
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

