import 'package:ed_management/Colors.dart';
import 'package:ed_management/screens/Student%20Finance%20Report.dart';
import 'package:ed_management/services/ApisProvider.dart';
import 'package:ed_management/utill/textUtill.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math show Random;

import 'package:shared_preferences/shared_preferences.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  var selectedVal = 1;
  var isLoading = true;
  bool isSelect = false;
  List reportList = [];
  var selectedStandard= [];
  TextEditingController search = TextEditingController();

  List<String> stardardList = [];

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchFilterData();
    fetchData();
  }

  fetchFilterData() async{
    final prefs = await SharedPreferences.getInstance();
    var standard = prefs.getString('standard') ?? '';
    print('standardList =====${standard}');
    var newTest = standard.replaceAll('[', '').replaceAll(']', '');
    stardardList = newTest.split(',');
    print('standardList =====${stardardList}');
  }

  fetchData() async{
    List newData = [];
    // for (final map in selectedStandard) {
    //   map['name'] = 0;
    //   // newData =
    // }
    if(selectedStandard.isNotEmpty){
      selectedStandard.forEach((element) {
        newData.add({'name' : '$element'});
      });
    }
    print('newData');
    print(newData);
    var data = await ApiService().reportData(search.text.toString(), selectedVal == 1 ? newData : '', selectedVal);
    if(data['status'] == true) {
      reportList = data['data'];
    }
    print('reportList');
    print(reportList.length);
    setState(() {
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
        ? Center(child: CircularProgressIndicator(color: appPrimary,),)
      : SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                child: SizedBox(
                  height: 40,
                  child:TextFormField(
                    controller: search,
                    cursorColor: appPrimary,
                    style:  TextStyle(color: Colors.black, fontSize: 15),
                    decoration:  InputDecoration(
                        prefixIcon: Icon(Icons.search, size: 20, color: Colors.grey,),
                        suffixIcon: InkWell(
                            onTap: () {
                              search.clear();
                            },
                            child: Icon(Icons.close, size: 20, color: Colors.grey,)),
                        hintText: 'Type here',
                        hintStyle: TextStyle(fontSize: 9, color: Colors.grey.shade500),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5)),
                        disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5))
                    ),
                    onFieldSubmitted: (val) async{
                      print(val);
                      setState(() {
                        isLoading = true;
                      });
                      await fetchData();
                    },
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text('${reportList.length} rows', style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),),
              SizedBox(height: 10,),
              reportList.isNotEmpty
              ? Expanded(
                child: ListView.builder(
                    itemCount: reportList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final color = Colors.primaries[math.Random().nextInt(Colors.primaries.length)];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => StudentFinanceScreen()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5),
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(4.0)
                              ),
                              height: 150,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(color: color, width: 5,),
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width/2,
                                        child: Row(
                                          children: [
                                            Text('Name:', style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),),
                                            SizedBox(width: 8,),
                                            Text('${reportList[index]['name']}', style: GoogleFonts.poppins(color: appPrimary, fontSize: 14),),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 2,),
                                      Container(
                                        width: MediaQuery.of(context).size.width/2,
                                        child: Row(
                                          children: [
                                            Text("F\'s Name:", style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),),
                                            SizedBox(width: 8,),
                                            Text('${reportList[index]['fname']}', style: GoogleFonts.poppins(color: appPrimary, fontSize: 14),),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 2,),
                                      Container(
                                        width: MediaQuery.of(context).size.width/2,
                                        child: Row(
                                          children: [
                                            Text('Standard:', style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),),
                                            SizedBox(width: 8,),
                                            Text('${reportList[index]['standard']}', style: GoogleFonts.poppins(color: appPrimary, fontSize: 14),),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 2,),
                                      Container(
                                        width: MediaQuery.of(context).size.width/2,
                                        child: Row(
                                          children: [
                                            Text('Stream:', style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),),
                                            SizedBox(width: 8,),
                                            Text('${reportList[index]['stream']}', style: GoogleFonts.poppins(color: appPrimary, fontSize: 14),),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                      Container(
                                        width: MediaQuery.of(context).size.width/2,
                                        child: Row(
                                          children: [
                                            Icon(Icons.phone, color: Colors.black, size: 20,),
                                            SizedBox(width: 15,),
                                            Container(
                                              height: 23,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.green),
                                                  // color: Colors.orange,
                                                  borderRadius: BorderRadius.circular(2)
                                              ),
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                              child: Text('Update Remark', style: GoogleFonts.inter(color: Colors.green, fontSize: 10)
                                              ),),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  Container(
                                    width: MediaQuery.of(context).size.width/4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                height: 23,
                                                decoration: BoxDecoration(
                                                    color: Colors.orange.shade400,
                                                    borderRadius: BorderRadius.circular(4)
                                                ),
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                                child: Text('Total 54000 Rs', style: GoogleFonts.inter(color: Colors.white, fontSize: 10)
                                                ),),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                height: 23,
                                                decoration: BoxDecoration(
                                                    color: Colors.green.shade400,
                                                    borderRadius: BorderRadius.circular(4)
                                                ),
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                                child: Text('Receive 54000 Rs', style: GoogleFonts.inter(color: Colors.white, fontSize: 10)
                                                ),),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                height: 23,
                                                decoration: BoxDecoration(
                                                    color: Colors.red.shade400,
                                                    borderRadius: BorderRadius.circular(4)
                                                ),
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                                child: Text('Outstanding 0 Rs', style: GoogleFonts.merriweather(color: Colors.white, fontSize: 10)
                                                ),),
                                            ],
                                          ),
                                          SizedBox(height: 5,),
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Image.asset('assets/gonext.png', height: 30,),
                                                ],
                                              ),
                                              SizedBox(height: 5,)
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              )
              : Container(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(
                    builder: (context, newSetState) {
                      return AlertDialog(
                      backgroundColor: Colors.white,
                      insetPadding: EdgeInsets.only(top: 0,left: 0, right: 0, bottom: 70),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2)
                      ),
                      contentPadding: EdgeInsets.zero,
                      content: SizedBox(
                        width: MediaQuery.of(context).size.width/1.1,
                        height: MediaQuery.of(context).size.height/1.8,
                        child: Column(
                          children: <Widget>[
                           Padding(
                             padding: const EdgeInsets.all(10.0),
                             child: Row(
                               children: [
                                 InkWell(
                                   onTap: () {
                                     newSetState(() {
                                       selectedVal = 1;
                                     });
                                   },
                                   child: Container(
                                     width: MediaQuery.of(context).size.width/3.5,
                                     height: 40,
                                     decoration: BoxDecoration(
                                         color: selectedVal == 1 ? appPrimary : Colors.white,
                                         border: Border.all(color: selectedVal == 1 ? appPrimary : Colors.grey.shade300)
                                     ),
                                     alignment: Alignment.center,
                                     child: Text('Standard', style: GoogleFonts.inter(color: selectedVal == 1 ? Colors.white : appPrimary),),
                                   ),
                                 ),
                                 InkWell(
                                   onTap: () {
                                     newSetState(() {
                                       selectedVal = 2;
                                     });
                                   },
                                   child: Container(
                                     width: MediaQuery.of(context).size.width/3.5,
                                     height: 40,
                                       decoration: BoxDecoration(
                                           color: selectedVal == 2 ? appPrimary : Colors.white,
                                           border: Border.all(color: selectedVal == 2 ? appPrimary : Colors.grey.shade300)
                                       ),
                                     alignment: Alignment.center,
                                     child: Text('Tag', style: GoogleFonts.inter(color: selectedVal == 2 ? Colors.white : appPrimary),),
                                   ),
                                 ),
                                 InkWell(
                                   onTap: () {
                                     newSetState(() {
                                       selectedVal = 3;
                                     });
                                   },
                                   child: Container(
                                     width: MediaQuery.of(context).size.width/3.5,
                                     height: 40,
                                     decoration: BoxDecoration(
                                       color: selectedVal == 3 ? appPrimary : Colors.white,
                                       border: Border.all(color: selectedVal == 3 ? appPrimary : Colors.grey.shade300)
                                     ),
                                     alignment: Alignment.center,
                                     child: Text('Section', style: GoogleFonts.inter(color: selectedVal == 3 ? Colors.white : appPrimary),),
                                   ),
                                 )
                               ],
                             ),
                           ),
                            selectedVal == 1
                                ?  Expanded(
                                  child: ListView.builder(
                                  itemCount: stardardList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    bool isSele = false;
                                    if (selectedStandard.contains(stardardList[index])) {
                                      isSele = true;
                                    }
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                        child: Row(
                                        children: [
                                        Text('${stardardList[index]}', style: TextStyle(color: Colors.black),),
                                        Spacer(),
                                        InkWell(
                                            onTap: () {
                                              if (!selectedStandard.contains(stardardList[index])) {
                                                // if (serviceList.length < 5) {
                                                selectedStandard.add(stardardList[index]);
                                                newSetState(() {});
                                                print(selectedStandard);
                                                // }
                                              } else {
                                                selectedStandard
                                                    .removeWhere((element) => element == stardardList[index]);
                                                newSetState(() {});
                                                print(selectedStandard);
                                              }
                                              // newSetState(() {
                                              //   isSelect = !isSelect;
                                              // });
                                            },
                                            child: Icon(isSele ? Icons.check_box : Icons.check_box_outline_blank, color: isSele ? appPrimary : Colors.grey,))
                              ],
                            ),
                                      );
                                    }
                                  ),
                                )
                                : Container(),
                           // Spacer(),
                            SizedBox(height: 10,),
                            Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 10.0),
                             child: InkWell(
                                onTap: () {
                                  fetchData();
                                  Navigator.pop(context);
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                                },
                                child: Container(
                                  height: 35,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: appPrimary),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4)
                                  ),
                                  alignment: Alignment.center,
                                  child: Text("APPLY", style: GoogleFonts.merriweather(color: appPrimary, fontSize: 13)),
                                ),
                              ),
                           ),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                                },
                                child: Container(
                                  height: 35,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4)
                                  ),
                                  alignment: Alignment.center,
                                  child: Text("CLOSE", style: GoogleFonts.merriweather(color: Colors.black, fontSize: 13)),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                          ],
                        ),
                      ),
                    );
                  }
                );
              });
        },
        child: Icon(Icons.filter_list_outlined, color: appPrimary,size: 18,),
        backgroundColor: Colors.white,
        hoverColor: appPrimary,
        foregroundColor: appPrimary,
      ),
    );
  }
}