import 'dart:ui';
import 'package:ed_management/Colors.dart';
import 'package:ed_management/screens/Forgot%20Password%20Screen.dart';
import 'package:ed_management/screens/HomePage.dart';
import 'package:ed_management/screens/Send%20Otp%20Screen.dart';
import 'package:ed_management/services/ApisProvider.dart';
import 'package:ed_management/services/custom%20loader.dart';
import 'package:ed_management/utill/textUtill.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

var isLoginByOtp = false;
TextEditingController username = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  int selectedIndex=0;
  bool showOption=false;

  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const   SizedBox(height: 20,),
                Center(child: Image.asset('assets/EdPlus-AI-Logoss.png', color: appPrimary,height: 80,)),
                Center(child:
                Text("Edplus Management",style : GoogleFonts.merriweather(fontSize: 14, fontWeight: FontWeight.w500))),
                const   SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 40,
                      width: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: appPrimary,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(4), bottomLeft: Radius.circular(4))
                      ),
                      child:
                      Text("FAQ",style : GoogleFonts.merriweather(fontSize: 14, color: Colors.white)),
                    )
                  ],
                ),
                const   Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
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
                      const   SizedBox(height: 15,),
                      Container(
                        height: 50,
                        // decoration:const  BoxDecoration(
                        //     border: Border(bottom: BorderSide(color: Colors.white))
                        // ),
                        child:TextFormField(
                          controller: password,
                          obscureText: true,
                          cursorColor: appPrimary,
                          style: const TextStyle(color: appPrimary, fontSize: 14),
                          decoration:const  InputDecoration(
                              labelText: 'Password',
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      InkWell(
                        onTap: () async{
                          if(username.text == '') {
                            toastification.show(
                              type: ToastificationType.warning,
                              context: context,
                              title: Text('Please enter mobile number'),
                              autoCloseDuration: const Duration(seconds: 5),
                            );
                          } else {
                            fetchData(context);
                            var response = await ApiService().forgotPassword(
                                username.text.toString(), '', false, '');
                            print(response);
                            if (response['status'] == true) {
                              isLoginByOtp = true;
                              toastification.show(
                                type: ToastificationType.success,
                                context: context,
                                title: Text('OTP Send Sucessfully!'),
                                autoCloseDuration: const Duration(seconds: 5),
                              );
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                     SendotpScreen()));
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
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children:[
                              Text("Login By OTP",style : GoogleFonts.merriweather(fontSize: 12, fontWeight: FontWeight.w500, color: appPrimary)),
                            ]),
                      ),
                      const   SizedBox(height: 30,),
                      InkWell(
                        onTap: () async{
                          if(username.text == '') {
                            toastification.show(
                              type: ToastificationType.warning,
                              context: context,
                              title: Text('Please enter user name'),
                              autoCloseDuration: const Duration(seconds: 3),
                            );
                          } else if(password.text == ''){
                            toastification.show(
                              type: ToastificationType.warning,
                              context: context,
                              title: Text('Please enter password'),
                              autoCloseDuration: const Duration(seconds: 3),
                            );
                          } else {
                            fetchData(context);
                            var response = await ApiService().getUsers(username.text.toString(), password.text.toString(), false, '0');
                            print(response);
                            if(response['status'] == true) {
                              var storeList =
                              ['${response['name']}',
                                '${response['email']}',
                                '${response['fname']}',
                                '${username.text}',
                                '${response['post']}',
                                '${response['photo']}',
                              ];
                              final prefs = await SharedPreferences.getInstance();
                              await prefs.setBool('isLogin', true);
                              await prefs.setStringList('data', storeList);
                              await prefs.setString('userid', response['userid']);
                              await prefs.setString('token', response['token']);

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
                          child: TextUtil(text: "LOGIN",color: Colors.white,),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(height: 1,width: MediaQuery.of(context).size.width/2.7, color: Colors.black,),
                          SizedBox(width: 10,),
                          TextUtil(text: "OR",color: Colors.black, size: 14,),
                          SizedBox(width: 10,),
                          Container(height: 1,width: MediaQuery.of(context).size.width/2.7, color: Colors.black,),
                        ],
                      ),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: () {
                          isLoginByOtp = false;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
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
                          child: TextUtil(text: "Forgot Password ?",color: appPrimary,),
                        ),
                      ),
                    ],
                  ),
                ),
            // const   SizedBox(height: 10,),
                Spacer(),
                // Center(child: TextUtil(text: "Powered by",color: Colors.grey.shade600, size: 11,)),
                Center(child: Image.asset('assets/logopower.png', height: 40,)),
                const   SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

