import 'package:ed_management/Colors.dart';
import 'package:ed_management/utill/textUtill.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  DateTime? _selectedDay;

  DateTime _focusedDay = DateTime.now();

  TextEditingController titleController = TextEditingController();

  var pickedTime;

  var startDate;
  var endDate;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text('Add Task', style: GoogleFonts.inter(color: appPrimary, fontSize: 20, fontWeight: FontWeight.w600),),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: buildTextField(hintT: 'Title'),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: buildTextField(hintT: 'Description'),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: buildTextField(hintT: 'Category'),
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
                    setState(() {
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    TimeOfDay initialTime = TimeOfDay.now();
                    var pickedTimeT = showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100)
                    );
                    setState(() {
                      startDate = pickedTimeT.asStream();
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
                      child: Text('Start Date', style: GoogleFonts.inter(color: Colors.grey.shade700, fontSize: 14),)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    var pickedTimeT = showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100)
                    );
                    setState(() {
                      endDate = pickedTimeT.asStream();
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
                      child: Text('End Date', style: GoogleFonts.inter(color: Colors.grey.shade700, fontSize: 14),)),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text('Priority', style: GoogleFonts.merriweather(color: appPrimary, fontSize: 19, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Icon(Icons.radio_button_checked, color: appPrimary, size: 18,),
                    SizedBox(width: 5,),
                    Text('Low', style: GoogleFonts.merriweather(color: Colors.black),),
                    SizedBox(width: 15,),
                    Icon(Icons.radio_button_off_outlined, color: Colors.grey.shade700, size: 18,),
                    SizedBox(width: 5,),
                    Text('Medium', style: GoogleFonts.merriweather(color: Colors.black),),
                    SizedBox(width: 15,),
                    Icon(Icons.radio_button_off_outlined, color: Colors.grey.shade700, size: 18,),
                    SizedBox(width: 5,),
                    Text('High', style: GoogleFonts.merriweather(color: Colors.black),),
                  ],
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
                        // border: Border.all(color: appPrimary),
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(4)
                    ),
                    alignment: Alignment.center,
                    child: Text("SUBMIT", style: GoogleFonts.merriweather(color: Colors.white, fontSize: 13)),
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
                        // border: Border.all(color: Colors.black),
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4)
                    ),
                    alignment: Alignment.center,
                    child: Text("GO BACK", style: GoogleFonts.merriweather(color: Colors.white, fontSize: 13)),
                  ),
                ),
              ),
              SizedBox(height: 10,),
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
