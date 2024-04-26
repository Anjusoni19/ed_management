import 'package:ed_management/Colors.dart';
import 'package:ed_management/screens/Dashboard.dart';
import 'package:ed_management/screens/HomePage.dart';
import 'package:ed_management/services/ApisProvider.dart';
import 'package:ed_management/services/custom%20loader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';


class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: appPrimary,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child:
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back, color: Colors.white,),
                          SizedBox(width: 10,),
                          Text('Login Account', style: GoogleFonts.merriweather(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w300),),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                  // scrollDirection: Axis.horizontal,
                  // shrinkWrap: true,
                  itemCount: LoginData.length,
                  itemBuilder: (BuildContext context, int index) {
                    List innerData = LoginData[index]['data'];
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text('${LoginData[index]['name']}', style: GoogleFonts.merriweather(fontSize: 12, color: appPrimary, fontWeight: FontWeight.bold),),
                            ],
                          ),
                          Divider(thickness: 1,),
                          SizedBox(height: 10,),
                          SizedBox(
                            height: (30 * innerData.length).toDouble(),
                            child: ListView.builder(
                              // scrollDirection: Axis.horizontal,
                              // shrinkWrap: true,
                                itemCount: innerData.length,
                                itemBuilder: (BuildContext context, int i) {
                                  return InkWell(
                                    onTap: () async{
                                      var phone = innerData[i]['number'];
                                      var ids = innerData[i]['id'];
                                      var password = innerData[i]['pass'];
                                      fetchData(context);
                                      var response = await ApiService().getUsers(
                                          phone, password, false, ids);
                                      print(response);
                                      if (response['status'] == true) {
                                        var standardList = response['data']['standard'];
                                        print('stardard List =====');
                                        print(standardList);
                                        List stardList = <String>[];
                                        standardList.forEach((element) {
                                          stardList.add('${element['name']}');
                                        });
                                        print('stardList =====');
                                        print(stardList);
                                        List sectionList = response['data']['section'];
                                        print('sectionList =====');
                                        print(sectionList);
                                        List secList = <String>[];
                                        sectionList.forEach((element) {
                                          secList.add('${element['name']}');
                                        });
                                        var subdomain = response['data']['subdomain'];
                                        var user_id = response['data']['userid'];
                                        var token = response['data']['token'];
                                        var branchName = innerData[i]['branch'];
                                        var storeList =
                                        ['${response['data']['name']}',
                                          '${response['data']['mail']}',
                                          '${response['data']['gender']}',
                                          '${phone}',
                                          '${response['data']['school_name']}',
                                          '${response['data']['school_address']}',
                                          '${response['data']['school_logo']}',
                                          '${response['data']['logo']}',
                                        ];

                                        final prefs = await SharedPreferences.getInstance();
                                        await prefs.setBool('isLogin', true);
                                        await prefs.setString('branchName', branchName);
                                        await prefs.setString('subdomain', subdomain);
                                        await prefs.setString('user_id', user_id);
                                        await prefs.setString('token', token);
                                        await prefs.setStringList('data', storeList);
                                        await prefs.setString('standard',  '$stardList');
                                        await prefs.setString('section', '$secList');
                                        // isLoginByOtp = true;
                                        toastification.show(
                                          type: ToastificationType.success,
                                          context: context,
                                          title: Text('Account Sucessfully Switched!'),
                                          autoCloseDuration: const Duration(seconds: 5),
                                        );
                                        Navigator.pop(context);
                                        // Navigator.pop(context);
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) =>
                                                MyHomePage()));
                                      } else {
                                        toastification.show(
                                          type: ToastificationType.error,
                                          context: context,
                                          title: Text('${response['message']}'),
                                          autoCloseDuration: const Duration(seconds: 5),
                                        );
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('${innerData[i]['branch']}', style: GoogleFonts.merriweather(fontSize: 10, color: appPrimary),),
                                            ],
                                          ),
                                          Divider()
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}