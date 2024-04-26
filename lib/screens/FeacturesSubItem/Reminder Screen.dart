import 'package:ed_management/Colors.dart';
import 'package:ed_management/screens/FeacturesSubItem/Add%20Reminder%20Screen.dart';
import 'package:ed_management/screens/FeacturesSubItem/AddStudentScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReminderScreen extends StatefulWidget {
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  int SelectValue = 0;

  bool isSelect = false;

  var _intervalValue = 'Photo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text('Reminder', style: GoogleFonts.inter(color: appPrimary, fontSize: 18),),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddReminderScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 9.0),
              child: Card(
                  elevation: 4.0,
                  // width: 35,
                  // height: 35,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                      side: BorderSide(color: appPrimary.withOpacity(0.6))
                  ),
                  // alignment: Alignment.center,
                  child: Container(
                      width: 30,
                      height: 30,
                      child: Icon(Icons.add, size: 18, color: appPrimary,))),
            ),
          ),
          SizedBox(width: 10,),
        ],
      ),
      body: Column(
        children: [
          Card(
            // elevation: 8.0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                              // border: Border.all(color: appPrimary.withOpacity(0.6)),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 13.0, vertical: 13),
                          child: Image.asset('assets/noti4.png', height: 15,)),
                      SizedBox(width: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width/1.7,
                                  child: Text('test', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: appPrimary),)),
                            ],
                          ),
                          SizedBox(height: 3,),
                          Row(
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width/1.7,
                                  child: Row(
                                    children: [
                                      Text('2024-02-23 to 2024-02-23, 12:00:00 ', style: GoogleFonts.inter(fontSize: 10)),
                                      SizedBox(width: 8,),
                                      Container(
                                          height: 20,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color: appPrimary,
                                              borderRadius: BorderRadius.circular(4)
                                          ),
                                          alignment: Alignment.center,
                                          child: Text('Day', style: GoogleFonts.merriweather(fontSize: 10, color: Colors.white),)),
                                    ],
                                  )),
                            ],
                          ),

                        ],
                      ),

                      Spacer(),
                      PopupMenuButton<int>(
                          itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
                            new PopupMenuItem<int>(
                                value: 2, child: new Text('Edit')),
                            new PopupMenuItem<int>(
                                value: 3, child: new Text('View')),
                          ],
                          onSelected: (int value) {
                            setState(() {
                              SelectValue = value;
                            });
                            if(SelectValue == 1) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(
                                        builder: (context, newSetState) {
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            insetPadding: EdgeInsets.only(top: 0,left: 0, right: 0, bottom: 70),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8)
                                            ),
                                            contentPadding: EdgeInsets.zero,
                                            content: SizedBox(
                                              width: MediaQuery.of(context).size.width/1.1,
                                              height: MediaQuery.of(context).size.height/1.2,
                                              child: Column(
                                                // crossAxisAlignment: CrossAxisAlignment.end,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    height: 45,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8))
                                                    ),
                                                    alignment: Alignment.centerLeft,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Spacer(),
                                                        // SizedBox(width: 20,),
                                                        Text('Upload Documents', style: GoogleFonts.inter(fontSize: 18,color: Colors.black, fontWeight: FontWeight.bold),),
                                                        Spacer(),
                                                        InkWell(
                                                            onTap: () {
                                                              Navigator.pop(context);
                                                            },
                                                            child: Icon(Icons.close, color: Colors.black,)),
                                                        SizedBox(width: 20,),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                                                    child: Row(
                                                      children: [
                                                        Text('Select Document *', style: TextStyle(color: appPrimary, fontSize: 17),),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                                    child: Container(
                                                      height: 40,
                                                      width: MediaQuery.of(context).size.width,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(color: appPrimary),
                                                          borderRadius: BorderRadius.circular(4)
                                                      ),
                                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                                      child: DropdownButtonHideUnderline(
                                                        child: DropdownButton<String>(
                                                          hint: const Text('Photo'),
                                                          value: _intervalValue,
                                                          // isExpanded: true,
                                                          items: ['Photo', 'Sign', 'Aadhar Card'].map(
                                                                (String? value) {
                                                              return DropdownMenuItem<String>(
                                                                value: value,
                                                                child: Text(value.toString()),
                                                              );
                                                            },
                                                          ).toList(),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              _intervalValue = value!;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Divider(),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width/1.2,
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.grey),
                                                          borderRadius: BorderRadius.circular(4)
                                                      ),
                                                      alignment: Alignment.center,
                                                      child: Icon(Icons.camera_enhance_rounded, color: Colors.grey,),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(context).size.width/1.2,
                                                          height: 35,
                                                          child: ElevatedButton(
                                                              style: ElevatedButton.styleFrom(primary: appPrimary),
                                                              onPressed: (){},
                                                              child: Text('Submit')),
                                                        ) ,
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                    );
                                  });
                            }
                          })
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}