import 'package:ed_management/Colors.dart';
import 'package:ed_management/utill/textUtill.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
class AddReminderScreen extends StatefulWidget {
  @override
  _AddReminderScreenState createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  DateTime? _selectedDay;

  DateTime _focusedDay = DateTime.now();

  TextEditingController titleController = TextEditingController();

  var pickedTime;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text('Add Reminder', style: GoogleFonts.inter(color: appPrimary, fontSize: 20, fontWeight: FontWeight.w600),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300)
              ),
              child: TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
                daysOfWeekHeight: 40,
                rowHeight: 50,
                // Calendar Header Styling
                headerStyle: const HeaderStyle(
                  leftChevronPadding: EdgeInsets.zero,
                  rightChevronPadding: EdgeInsets.symmetric(vertical: 3),
                  titleTextStyle:
                  TextStyle(color: Colors.white, fontSize: 17.0),
                  decoration: BoxDecoration(
                      color: appPrimary,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8))),
                  formatButtonTextStyle:
                  TextStyle(color: appPrimary, fontSize: 13.0),
                  formatButtonDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ), ),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 25,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (date, events) {
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
                                  width: MediaQuery.of(context).size.width/1.3,
                                  height: MediaQuery.of(context).size.height/2,
                                  child: Column(
                                    children: <Widget>[
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
                                            // Spacer(),
                                            SizedBox(width: 20,),
                                            Text('Set Reminder', style: GoogleFonts.inter(fontSize: 18,color: Colors.black, fontWeight: FontWeight.bold),),
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
                                      Divider(color: Colors.grey,),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: buildTextField(hintT: 'Title'),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              TimeOfDay initialTime = TimeOfDay.now();
                                             var pickedTimeT = showTimePicker(
                                                context: context,
                                                initialTime: initialTime,
                                              );
                                             newSetState(() {
                                               pickedTime = pickedTimeT.asStream();
                                             });
                                            },
                                            child: Container(
                                              height: 50,
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey),
                                                  borderRadius: BorderRadius.circular(4)
                                                ),
                                                alignment: Alignment.centerLeft,
                                                padding: EdgeInsets.only(left: 10),
                                                child: Text('Time', style: GoogleFonts.inter(color: Colors.grey.shade700, fontSize: 14),)),
                                          ),
                                        ),

                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      Spacer(),
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
                                                border: Border.all(color: appPrimary),
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(4)
                                            ),
                                            alignment: Alignment.center,
                                            child: Text("SUBMIT", style: GoogleFonts.merriweather(color: appPrimary, fontSize: 13)),
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
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: appPrimary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            // border: Border.all(color: Colors.grey.shade100),
                            // borderRadius: BorderRadius.circular(4.0)
                        ),
                        height: 50,
                        child: Row(
                          children: [
                            Container(color: appPrimary, width: 5,),
                            SizedBox(width: 10,),
                            Container(
                              width: MediaQuery.of(context).size.width/1.16,
                              child: Row(
                                children: [
                                  Text('Test Reminder', style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),),
                                  Spacer(),
                                  Container(
                                    height: 25,
                                      decoration: BoxDecoration(
                                        color: appPrimary,
                                        borderRadius: BorderRadius.circular(4)
                                      ),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                      child: Text('2${index} Feb', style: GoogleFonts.poppins(color: Colors.white),))
                                ],
                              ),
                            ),
                            // SizedBox(width: 15,)
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      )
    );
  }
}

Widget buildTextField(
    {required String hintT}) {
  return Container(
    height: 50,
    // decoration:const  BoxDecoration(
    //     border: Border(bottom: BorderSide(color: Colors.white))
    // ),
    alignment: Alignment.center,
    child:TextFormField(
      readOnly: hintT == 'Time' ? true : false,
      // controller: controller,
      cursorColor: appPrimary,
      style: const TextStyle(color: appPrimary, fontSize: 14),
      decoration:  InputDecoration(
        // hintText: 'Username',
          labelText:  hintT,
          // labelStyle: TextStyle(color: appPrimary),
          fillColor: Colors.white,
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
      ),
    ),
  );
}
