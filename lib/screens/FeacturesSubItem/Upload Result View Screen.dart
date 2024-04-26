import 'package:ed_management/Colors.dart';
import 'package:ed_management/screens/FeacturesSubItem/Upload%20Result%20Screen.dart';
import 'package:ed_management/services/ApisProvider.dart';
import 'package:ed_management/services/custom%20loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

class UploadResultViewScreen extends StatefulWidget {
   UploadResultViewScreen({super.key, required this.data, required this.standard, required this.section, required this.subject, required this.exam});

  final String  standard, section, subject, exam;
  final data;
  @override
  _UploadResultViewScreenState createState() => _UploadResultViewScreenState();
}

class _UploadResultViewScreenState extends State<UploadResultViewScreen> {
  var _progressValue = 0.4;
  List<TextEditingController> _controllers = [];
  List<TextEditingController> _overAllcontrollers = [];
  List<TextEditingController> _controllersSecond = [];
  List<TextEditingController> _controllersThird = [];
  List<TextEditingController> _controllersFoutrh = [];
  List uploadData = [];
  List dataList = [];
  bool isLoading = true;
  var newList;
  List isOralVal = [];
  List isTheoryVal = [];
  List isPracticleVal = [];
  List isSectionalVal = [];

  int overAllValue = 0;

  bool isFirst = true;

  List isCheck = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData1();
    newList = widget.data;
  }

  fetchData1() async{
    var data = await ApiService().uploadResultViewData(widget.standard, widget.subject, widget.section, widget.exam);
    if(data['status'] == true) {
      dataList = data['datas'];
      dataList.forEach((element) {
        isTheoryVal.add('0');
        isOralVal.add('0');
        isPracticleVal.add('0');
        isSectionalVal.add('0');
      });
      for(var element= 0; element<dataList.length; element++){
        isCheck.add(false);
        _controllers.add(new TextEditingController());
        _overAllcontrollers.add(new TextEditingController());
        _controllersSecond.add(new TextEditingController());
        _controllersThird.add(new TextEditingController());
        _controllersFoutrh.add(new TextEditingController());
        _overAllcontrollers[element] = TextEditingController(text:dataList[element]['marks'] != null ? dataList[element]['marks'] == 'AB' ? '00' : dataList[element]['marks'] == 'NC' ? '000' : '${dataList[element]['marks']}' : '');
        _controllers[element] = TextEditingController(text: dataList[element]['oral'] != null ? dataList[element]['oral'] == 'AB' ? '00' : dataList[element]['oral'] == 'NC' ? '000' : '${dataList[element]['oral']}'  : '');
        _controllersSecond[element] = TextEditingController(text: dataList[element]['theory'] != null ? dataList[element]['theory'] == 'AB' ? '00' : dataList[element]['theory'] == 'NC' ? '000' : '${dataList[element]['theory']}'  : '');
        _controllersThird[element] = TextEditingController(text: dataList[element]['practical'] != null ? dataList[element]['practical'] == 'AB' ? '00' : dataList[element]['practical'] == 'NC' ? '000' : '${dataList[element]['practical']}'  : '');
        _controllersFoutrh[element] = TextEditingController(text: dataList[element]['sectional'] != null ? dataList[element]['sectional'] == 'AB' ? '00' : dataList[element]['sectional'] == 'NC' ? '000' : '${dataList[element]['sectional']}'  : '');
        if(dataList[element]['oral'] == 'AB') {
          isOralVal[element] = '1';
        }
        if(dataList[element]['oral'] == 'NC') {
          isOralVal[element] = '2';
        }

        if(dataList[element]['theory'] == 'AB') {
          isTheoryVal[element] = '1';
        }
        if(dataList[element]['theory'] == 'NC') {
          isTheoryVal[element] = '2';
        }

        if(dataList[element]['practical'] == 'AB') {
          isPracticleVal[element] = '1';
        }
        if(dataList[element]['practical'] == 'NC') {
          isPracticleVal[element] = '2';
        }

        if(dataList[element]['sectional'] == 'AB') {
          isSectionalVal[element] = '1';
        }
        if(dataList[element]['sectional'] == 'NC') {
          isSectionalVal[element] = '2';
        }
        print('dataList[index]');
        print(dataList[element]['marks']);
      }
    }
    print('reportList');
    print(dataList.length);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text('Upload Result', style: GoogleFonts.inter(color: appPrimary, fontSize: 16),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Image.asset('assets/title.png', height: 22,),
                    SizedBox(width: 10,),
                    Column(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width/1.3,
                            child: Text('${widget.standard} - ${widget.subject}', style: GoogleFonts.merriweather(fontSize: 12, fontWeight: FontWeight.bold),)),
                        Container(
                            width: MediaQuery.of(context).size.width/1.3,
                            child: Text('${widget.exam}', style: GoogleFonts.merriweather(fontSize: 12, fontWeight: FontWeight.bold),)),
                      ],
                    ),
                  ],
                ),
              ),
                  SizedBox(height: 10,),
              isLoading
                  ? Center(child: CircularProgressIndicator(color: appPrimary,),)
                  :  Container(
                    height: MediaQuery.of(context).size.height/1.3,
                    child: ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: (BuildContext context, int index) {

                    return Card(
                        elevation: 8.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  // Image.asset('assets/medal.png', height: 22,),
                                  Text('Name: ', style: GoogleFonts.inter(color: Colors.black, fontSize: 10,),),
                                  SizedBox(width: 8,),
                                  Text('${dataList[index]['name']}', style: GoogleFonts.inter(color: appPrimary, fontSize: 10,),),
                                  Spacer(),
                                  InkWell(
                                      onTap: () {
                                        isCheck[index] = !isCheck[index];
                                        if(isCheck[index] == true) {
                                          uploadData.add(
                                            {
                                              "sid":"${dataList[index]['sid']}",//Students id get from upload result student list api
                                              "marks":"${_overAllcontrollers[index].text}", // Total Marks upload
                                              "marks1":"${_controllers[index].text}", // Oral Marks upload
                                              "marks2":"${_controllersThird[index].text}", // practical Marks upload
                                              "marks3":"${_controllersSecond[index].text}", // theory Marks upload
                                              "marks4":"${_controllersFoutrh[index].text}" // sectional Marks upload
                                            },
                                          );
                                        } else {
                                          uploadData.removeAt(index);
                                        }
                                        setState(() {
                                        });
                                      },
                                      child: Icon(isCheck[index] ? Icons.check_circle : Icons.circle_outlined, size: 22, color: isCheck[index] ? appPrimary : Colors.grey.shade400,))
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  // Image.asset('assets/medal.png', height: 22,),
                                  Text('F\' Name: ', style: GoogleFonts.inter(color: Colors.black, fontSize: 10,),),
                                  SizedBox(width: 8,),
                                  Text('${dataList[index]['fname']}', style: GoogleFonts.inter(color: appPrimary, fontSize: 10,),)
                                ],
                              ),
                              SizedBox(height: 20,),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 30,
                                        width: MediaQuery.of(context).size.width/6.5,
                                        decoration: BoxDecoration(
                                        border: Border.all(color: appPrimary),
                                        borderRadius: BorderRadius.circular(4)
                                      ),
                                        alignment: Alignment.center,
                                        child:  TextField(
                                          readOnly:   widget.data['oral'] == null &&   widget.data['theory'] == null && widget.data['practical'] == null && widget.data['sectional'] == null ? false : true,
                                          textAlign: TextAlign.center,
                                          controller: _overAllcontrollers[index],
                                          // decoration: InputDecoration(
                                            // hintText: dataList[index]['marks'] == null ? '' : '${dataList[index]['marks']}',

                                            // // hintText: widget.data['overallupload'] == null ? '' : '${widget.data['overallupload']}',

                                            // // hintText: '${!isFirst ? overAllValue : dataList[index]['overallupload'] == null ? '0' : dataList[index]['overallupload']}',
                                            // hintStyle: GoogleFonts.inter(color: appPrimary, fontSize: 18),),
                                        ),
                                        // Text('${!isFirst ? overAllValue : dataList[index]['overallupload'] == null ? '0' : dataList[index]['overallupload']}', style: GoogleFonts.inter(color: appPrimary, fontSize: 18),),
                                      ),
                                      widget.data['oral'] == null
                                          ? Container()
                                          :SizedBox(width: 10,),
                                      widget.data['oral'] == null
                                          ? Container()
                                          :Container(
                                          height: 30,
                                          width: MediaQuery.of(context).size.width/6.5,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: appPrimary),
                                            borderRadius: BorderRadius.circular(4)
                                        ),
                                        alignment: Alignment.center,
                                        child: TextField(
                                          readOnly: isOralVal[index] == '0' ? false : true,
                                          keyboardType: TextInputType.number,
                                          inputFormatters:[                        //only numeric keyboard.
                                            LengthLimitingTextInputFormatter(int.parse(widget.data['oral'])),      //only 6 digit
                                            LimitRange(0, int.parse(widget.data['oral']))
                                          ],
                                          textAlign: TextAlign.center,
                                          controller: _controllers[index],
                                          // maxLengthEnforcement: false,
                                          // maxLength: widget.data['oral'].length,
                                          // decoration: InputDecoration(
                                            // counterText: '',
                                            // hintText: dataList[index]['oral'] == null ? '' : '${dataList[index]['oral']}',
                                            // // hintText: widget.data['oralupload'] == null ? 'Marks' : '${widget.data['oralupload']}',

                                          // ),
                                          onChanged: (val) {
                                            setState(() {
                                              var value = int.parse(_controllers[index].text == '' ? '0': _controllers[index].text) + int.parse(_controllersSecond[index].text == '' ? '0': _controllersSecond[index].text) + int.parse(_controllersThird[index].text == '' ? '0': _controllersThird[index].text) + int.parse(_controllersFoutrh[index].text == '' ? '0': _controllersFoutrh[index].text);

                                              // var value = int.parse(_controllers[index].text) + int.parse(_controllersSecond[index].text) + int.parse(_controllersThird[index].text) + int.parse(_controllersFoutrh[index].text);
                                              _overAllcontrollers[index] = TextEditingController(text: '$value');
                                            });
                                          },
                                        ),
                                        // Text('0', style: GoogleFonts.inter(color: appPrimary, fontSize: 12),),
                                      ),
                                      widget.data['theory'] == null
                                          ? Container()
                                          :SizedBox(width: 10,),
                                      widget.data['theory'] == null
                                          ? Container()
                                          :Container(
                                        height: 30,
                                        width: MediaQuery.of(context).size.width/6.5,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: appPrimary),
                                            borderRadius: BorderRadius.circular(4)
                                        ),
                                        alignment: Alignment.center,
                                        child: TextField(
                                          readOnly: isTheoryVal[index] == '0' ? false : true,
                                          textAlign: TextAlign.center,
                                          controller: _controllersSecond[index],
                                          keyboardType: TextInputType.number,
                                          inputFormatters:[                        //only numeric keyboard.
                                            LengthLimitingTextInputFormatter(int.parse(widget.data['theory'])),      //only 6 digit
                                            LimitRange(0, int.parse(widget.data['theory']))
                                          ],
                                          // decoration: InputDecoration(
                                            // hintText: dataList[index]['theory'] == null ? '' : '${dataList[index]['theory']}',
                                            // // hintText: widget.data['theoryupload'] == null ? 'Marks' : '${widget.data['theoryupload']}',
                                          // ),
                                          onChanged: (val) {
                                            setState(() {
                                              var value = int.parse(_controllers[index].text == '' ? '0': _controllers[index].text) + int.parse(_controllersSecond[index].text == '' ? '0': _controllersSecond[index].text) + int.parse(_controllersThird[index].text == '' ? '0': _controllersThird[index].text) + int.parse(_controllersFoutrh[index].text == '' ? '0': _controllersFoutrh[index].text);

                                              // var value = int.parse(_controllers[index].text) + int.parse(_controllersSecond[index].text) + int.parse(_controllersThird[index].text) + int.parse(_controllersFoutrh[index].text);
                                              _overAllcontrollers[index] = TextEditingController(text: '$value');
                                            });
                                          },
                                        ),
                                        // Text('0', style: GoogleFonts.inter(color: appPrimary, fontSize: 12),),
                                      ),
                                      widget.data['practical'] == null
                                          ? Container()
                                          :SizedBox(width: 10,),
                                      widget.data['practical'] == null
                                          ? Container()
                                          :Container(
                                        height: 30,
                                        width: MediaQuery.of(context).size.width/6.5,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: appPrimary),
                                            borderRadius: BorderRadius.circular(4)
                                        ),
                                        alignment: Alignment.center,
                                        child: TextField(
                                          readOnly: isPracticleVal[index] == '0' ? false : true,
                                          textAlign: TextAlign.center,
                                          controller: _controllersThird[index],
                                          keyboardType: TextInputType.number,
                                          inputFormatters:[                        //only numeric keyboard.
                                            LengthLimitingTextInputFormatter(int.parse(widget.data['practical'])),      //only 6 digit
                                            LimitRange(0, int.parse(widget.data['practical']))
                                          ],
                                          decoration: InputDecoration(
                                            // hintText: dataList[index]['practical'] == null ? '' : '${dataList[index]['practical']}',

                                            // // hintText: widget.data['practicalupload'] == null ? 'Marks' : '${widget.data['practicalupload']}',
                                          ),
                                          onChanged: (val) {
                                            setState(() {
                                              var value = int.parse(_controllers[index].text == '' ? '0': _controllers[index].text) + int.parse(_controllersSecond[index].text == '' ? '0': _controllersSecond[index].text) + int.parse(_controllersThird[index].text == '' ? '0': _controllersThird[index].text) + int.parse(_controllersFoutrh[index].text == '' ? '0': _controllersFoutrh[index].text);

                                              // var value = int.parse(_controllers[index].text) + int.parse(_controllersSecond[index].text) + int.parse(_controllersThird[index].text) + int.parse(_controllersFoutrh[index].text);
                                              _overAllcontrollers[index] = TextEditingController(text: '$value');
                                            });
                                          },
                                        ),
                                        // Text('0', style: GoogleFonts.inter(color: appPrimary, fontSize: 12),),
                                      ),
                                      widget.data['sectional'] == null
                                          ? Container()
                                          : SizedBox(width: 10,),
                                      widget.data['sectional'] == null
                                          ? Container()
                                          : Container(
                                        height: 30,
                                        width: MediaQuery.of(context).size.width/6.5,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: appPrimary),
                                            borderRadius: BorderRadius.circular(4)
                                        ),
                                        alignment: Alignment.center,
                                        child: TextField(
                                          readOnly: isSectionalVal[index] == '0' ? false : true,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          // keyboardType: TextInputType.number,
                                          inputFormatters:[                        //only numeric keyboard.
                                            LengthLimitingTextInputFormatter(int.parse(widget.data['sectional'])),      //only 6 digit
                                            LimitRange(0, int.parse(widget.data['sectional']))
                                          ],
                                          decoration: InputDecoration(
                                            // hintText: dataList[index]['sectional'] == null ? '' : '${dataList[index]['sectional']}',
                                          ),
                                          controller: _controllersFoutrh[index],
                                          onChanged: (val) {
                                            setState(() {
                                              var value = int.parse(_controllers[index].text == '' ? '0': _controllers[index].text) + int.parse(_controllersSecond[index].text == '' ? '0': _controllersSecond[index].text) + int.parse(_controllersThird[index].text == '' ? '0': _controllersThird[index].text) + int.parse(_controllersFoutrh[index].text == '' ? '0': _controllersFoutrh[index].text);
                                              // var value = int.parse(_controllers[index].text) + int.parse(_controllersSecond[index].text) + int.parse(_controllersThird[index].text) + int.parse(_controllersFoutrh[index].text);
                                              _overAllcontrollers[index] = TextEditingController(text: '$value');
                                            });
                                          },
                                        ),
                                        // Text('0', style: GoogleFonts.inter(color: appPrimary, fontSize: 12),),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 1,),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            height: 10,
                                            width: MediaQuery.of(context).size.width/6.5,
                                            // decoration: BoxDecoration(
                                            //     border: Border.all(color: appPrimary),
                                            //     borderRadius: BorderRadius.circular(4)
                                            // ),
                                            alignment: Alignment.center,
                                            child: Text('Overall: ${widget.data['overall']}', style: GoogleFonts.inter(color: Colors.grey.shade700, fontSize: 8),),
                                          ),
                                          SizedBox(height: 40,)
                                        ],
                                      ),
                                      // SizedBox(height: 10,),
                                      widget.data['oral'] == null
                                          ? Container()
                                          :SizedBox(width: 10,),
                                      widget.data['oral'] == null
                                      ? Container()
                                      : Column(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: MediaQuery.of(context).size.width/6.5,
                                            // decoration: BoxDecoration(
                                            //     border: Border.all(color: appPrimary),
                                            //     borderRadius: BorderRadius.circular(4)
                                            // ),
                                            alignment: Alignment.center,
                                            child: Text('Oral: ${widget.data['oral']}', style: GoogleFonts.inter(color: Colors.grey.shade700, fontSize: 8),),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if(isOralVal[index] == '1' ) {
                                               setState(() {
                                                 isOralVal[index] = '0';
                                                 _controllers[index] = TextEditingController(text: '');

                                               });
                                              } else {
                                                setState(() {
                                                  isOralVal[index] = '1';
                                                  _controllers[index] =
                                                      TextEditingController(
                                                          text: '00');
                                                  // var value = int.parse(_controllers[index].text ?? '0') + int.parse(_controllersSecond[index].text ?? '0') + int.parse(_controllersThird[index].text ?? '0') + int.parse(_controllersFoutrh[index].text ?? '0');
                                                  var value = int.parse(
                                                      _controllers[index]
                                                          .text == ''
                                                          ? '0'
                                                          : _controllers[index]
                                                          .text) + int.parse(
                                                      _controllersSecond[index]
                                                          .text == ''
                                                          ? '0'
                                                          : _controllersSecond[index]
                                                          .text) + int.parse(
                                                      _controllersThird[index]
                                                          .text == ''
                                                          ? '0'
                                                          : _controllersThird[index]
                                                          .text) + int.parse(
                                                      _controllersFoutrh[index]
                                                          .text == ''
                                                          ? '0'
                                                          : _controllersFoutrh[index]
                                                          .text);

                                                  print('value');
                                                  print(value);
                                                  _overAllcontrollers[index] =
                                                      TextEditingController(
                                                          text: '$value');
                                                });
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                Text('AB', style: GoogleFonts.inter(color: Colors.red, fontSize: 9, fontWeight: FontWeight.w600),),
                                                SizedBox(width: 5,),
                                                Icon(isOralVal[index] == '1' ? Icons.check_box: Icons.check_box_outline_blank, color: Colors.red, size: 20,)
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              if(isOralVal[index] == '2' ) {
                                                setState(() {
                                                  isOralVal[index] = '0';
                                                  _controllers[index] = TextEditingController(text: '');
                                                });
                                              } else {
                                              setState(() {
                                                isOralVal[index] = '2';
                                                _controllers[index] = TextEditingController(text: '000');
                                                // var value = int.parse(_controllers[index].text ?? '0') + int.parse(_controllersSecond[index].text ?? '0') + int.parse(_controllersThird[index].text ?? '0') + int.parse(_controllersFoutrh[index].text ?? '0');
                                                var value = int.parse(_controllers[index].text == '' ? '0': _controllers[index].text) + int.parse(_controllersSecond[index].text == '' ? '0': _controllersSecond[index].text) + int.parse(_controllersThird[index].text == '' ? '0': _controllersThird[index].text) + int.parse(_controllersFoutrh[index].text == '' ? '0': _controllersFoutrh[index].text);

                                                print('value');
                                                print(value);
                                                _overAllcontrollers[index] = TextEditingController(text: '$value');
                                              });
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                Text('NC', style: GoogleFonts.inter(color: Colors.orange.shade700, fontSize: 9, fontWeight: FontWeight.w600),),
                                                SizedBox(width: 5,),
                                                Icon(isOralVal[index] == '2' ? Icons.check_box: Icons.check_box_outline_blank, color: Colors.orange.shade700, size: 20,)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      widget.data['theory'] == null
                                          ? Container()
                                          : SizedBox(width: 10,),
                                      widget.data['theory'] == null
                                          ? Container()
                                          :Column(
                                          children: [
                                          Container(
                                            height: 30,
                                            width: MediaQuery.of(context).size.width/6.5,
                                            // decoration: BoxDecoration(
                                            //     border: Border.all(color: appPrimary),
                                            //     borderRadius: BorderRadius.circular(4)
                                            // ),
                                            alignment: Alignment.center,
                                            child: Text('Theory: ${widget.data['theory']}', style: GoogleFonts.inter(color: Colors.grey.shade700, fontSize: 8),),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if(isTheoryVal[index] == '1' ) {
                                                setState(() {
                                                  isTheoryVal[index] = '0';
                                                  _controllersSecond[index] = TextEditingController(text: '');
                                                });
                                              } else {
                                              setState(() {
                                                isTheoryVal[index] = '1';
                                                _controllersSecond[index] = TextEditingController(text: '00');
                                                // var value = int.parse(_controllers[index].text ?? '0') + int.parse(_controllersSecond[index].text ?? '0') + int.parse(_controllersThird[index].text ?? '0') + int.parse(_controllersFoutrh[index].text ?? '0');
                                                var value = int.parse(_controllers[index].text == '' ? '0': _controllers[index].text) + int.parse(_controllersSecond[index].text == '' ? '0': _controllersSecond[index].text) + int.parse(_controllersThird[index].text == '' ? '0': _controllersThird[index].text) + int.parse(_controllersFoutrh[index].text == '' ? '0': _controllersFoutrh[index].text);

                                                print('value');
                                                print(value);
                                                _overAllcontrollers[index] = TextEditingController(text: '$value');
                                              });
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                Text('AB', style: GoogleFonts.inter(color: Colors.red, fontSize: 9, fontWeight: FontWeight.w600),),
                                                SizedBox(width: 5,),
                                                Icon(isTheoryVal[index] == '1'? Icons.check_box : Icons.check_box_outline_blank, color: Colors.red, size: 20,)
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if(isTheoryVal[index] == '2' ) {
                                                setState(() {
                                                  isTheoryVal[index] = '0';
                                                  _controllersSecond[index] = TextEditingController(text: '');

                                                });
                                              } else {
                                              setState(() {
                                                isTheoryVal[index] = '2';
                                                _controllersSecond[index] = TextEditingController(text: '000');
                                                // var value = int.parse(_controllers[index].text ?? '0') + int.parse(_controllersSecond[index].text ?? '0') + int.parse(_controllersThird[index].text ?? '0') + int.parse(_controllersFoutrh[index].text ?? '0');
                                                var value = int.parse(_controllers[index].text == '' ? '0': _controllers[index].text) + int.parse(_controllersSecond[index].text == '' ? '0': _controllersSecond[index].text) + int.parse(_controllersThird[index].text == '' ? '0': _controllersThird[index].text) + int.parse(_controllersFoutrh[index].text == '' ? '0': _controllersFoutrh[index].text);

                                                print('value');
                                                print(value);
                                                _overAllcontrollers[index] = TextEditingController(text: '$value');
                                              });
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                Text('NC', style: GoogleFonts.inter(color: Colors.orange.shade700, fontSize: 9, fontWeight: FontWeight.w600),),
                                                SizedBox(width: 5,),
                                                Icon(isTheoryVal[index] == '2' ? Icons.check_box : Icons.check_box_outline_blank, color: Colors.orange.shade700, size: 20,)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      widget.data['practical'] == null
                                          ? Container()
                                          : SizedBox(width: 10,),
                                      widget.data['practical'] == null
                                          ? Container()
                                          :Column(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: MediaQuery.of(context).size.width/6.5,
                                            // decoration: BoxDecoration(
                                            //     border: Border.all(color: appPrimary),
                                            //     borderRadius: BorderRadius.circular(4)
                                            // ),
                                            alignment: Alignment.center,
                                            child: Text('Practicle: ${widget.data['practical']}', style: GoogleFonts.inter(color: Colors.grey.shade700, fontSize: 8),),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if(isPracticleVal[index] == '1' ) {
                                                setState(() {
                                                  isPracticleVal[index] = '0';
                                                  _controllersThird[index] = TextEditingController(text: '');
                                                });
                                              } else {
                                              setState(() {
                                                isPracticleVal[index] = '1';
                                                _controllersThird[index] = TextEditingController(text: '00');
                                                // var value = int.parse(_controllers[index].text ?? '0') + int.parse(_controllersSecond[index].text ?? '0') + int.parse(_controllersThird[index].text ?? '0') + int.parse(_controllersFoutrh[index].text ?? '0');
                                                var value = int.parse(_controllers[index].text == '' ? '0': _controllers[index].text) + int.parse(_controllersSecond[index].text == '' ? '0': _controllersSecond[index].text) + int.parse(_controllersThird[index].text == '' ? '0': _controllersThird[index].text) + int.parse(_controllersFoutrh[index].text == '' ? '0': _controllersFoutrh[index].text);

                                                print('value');
                                                print(value);
                                                _overAllcontrollers[index] = TextEditingController(text: '$value');
                                              });
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                Text('AB', style: GoogleFonts.inter(color: Colors.red, fontSize: 9, fontWeight: FontWeight.w600),),
                                                SizedBox(width: 5,),
                                                Icon(isPracticleVal[index] == '1'? Icons.check_box : Icons.check_box_outline_blank, color: Colors.red, size: 20,)
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if(isPracticleVal[index] == '2' ) {
                                                setState(() {
                                                  isPracticleVal[index] = '0';
                                                  _controllersThird[index] = TextEditingController(text: '');
                                                });
                                              } else {
                                              setState(() {
                                                isPracticleVal[index] = '2';
                                                _controllersThird[index] = TextEditingController(text: '000');
                                                var value = int.parse(_controllers[index].text == '' ? '0': _controllers[index].text) + int.parse(_controllersSecond[index].text == '' ? '0': _controllersSecond[index].text) + int.parse(_controllersThird[index].text == '' ? '0': _controllersThird[index].text) + int.parse(_controllersFoutrh[index].text == '' ? '0': _controllersFoutrh[index].text);
                                                // var value = int.parse(_controllers[index].text ?? '0') + int.parse(_controllersSecond[index].text ?? '0') + int.parse(_controllersThird[index].text ?? '0') + int.parse(_controllersFoutrh[index].text ?? '0');
                                                print('value');
                                                print(value);
                                                _overAllcontrollers[index] = TextEditingController(text: '$value');
                                              });
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                Text('NC', style: GoogleFonts.inter(color: Colors.orange.shade700, fontSize: 9, fontWeight: FontWeight.w600),),
                                                SizedBox(width: 5,),
                                                Icon(isPracticleVal[index] == '2' ? Icons.check_box : Icons.check_box_outline_blank, color: Colors.orange.shade700, size: 20,)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      widget.data['sectional'] == null
                                          ? Container()
                                          : SizedBox(width: 10,),
                                      widget.data['sectional'] == null
                                          ? Container()
                                          :Column(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: MediaQuery.of(context).size.width/6.5,
                                            // decoration: BoxDecoration(
                                            //     border: Border.all(color: appPrimary),
                                            //     borderRadius: BorderRadius.circular(4)
                                            // ),
                                            alignment: Alignment.center,
                                            child: Text('sectional: ${widget.data['sectional']}', style: GoogleFonts.inter(color: Colors.grey.shade700, fontSize: 8),),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if(isSectionalVal[index] == '1' ) {
                                                setState(() {
                                                  isSectionalVal[index] = '0';
                                                  _controllersFoutrh[index] = TextEditingController(text: '');
                                                });
                                              } else {
                                              setState(() {
                                                isSectionalVal[index] = '1';
                                                _controllersFoutrh[index] = TextEditingController(text: '00');
                                                var value = int.parse(_controllers[index].text == '' ? '0': _controllers[index].text) + int.parse(_controllersSecond[index].text == '' ? '0': _controllersSecond[index].text) + int.parse(_controllersThird[index].text == '' ? '0': _controllersThird[index].text) + int.parse(_controllersFoutrh[index].text == '' ? '0': _controllersFoutrh[index].text);
                                                print('value');
                                                print(value);
                                                _overAllcontrollers[index] = TextEditingController(text: '$value');
                                              });
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                Text('AB', style: GoogleFonts.inter(color: Colors.red, fontSize: 9, fontWeight: FontWeight.w600),),
                                                SizedBox(width: 5,),
                                                Icon(isSectionalVal[index] == '1'? Icons.check_box : Icons.check_box_outline_blank, color: Colors.red, size: 20,)
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if(isSectionalVal[index] == '2' ) {
                                                setState(() {
                                                  isSectionalVal[index] = '0';
                                                  _controllersFoutrh[index] = TextEditingController(text: '');
                                                });
                                              } else {
                                              setState(() {
                                                isSectionalVal[index] = '2';
                                                _controllersFoutrh[index] = TextEditingController(text: '000');
                                                // var value = int.parse(_controllers[index].text ?? '0') + int.parse(_controllersSecond[index].text ?? '0') + int.parse(_controllersThird[index].text ?? '0') + int.parse(_controllersFoutrh[index].text ?? '0');
                                                var value = int.parse(_controllers[index].text == '' ? '0': _controllers[index].text) + int.parse(_controllersSecond[index].text == '' ? '0': _controllersSecond[index].text) + int.parse(_controllersThird[index].text == '' ? '0': _controllersThird[index].text) + int.parse(_controllersFoutrh[index].text == '' ? '0': _controllersFoutrh[index].text);
                                                print('value');
                                                print(value);
                                                _overAllcontrollers[index] = TextEditingController(text: '$value');
                                              });
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                Text('NC', style: GoogleFonts.inter(color: Colors.orange.shade700, fontSize: 9, fontWeight: FontWeight.w600),),
                                                SizedBox(width: 5,),
                                                Icon(isSectionalVal[index] == '2' ? Icons.check_box : Icons.check_box_outline_blank, color: Colors.orange.shade700, size: 20,)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )

                            ],
                          ),
                        ));
                }
              ),
                  ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 55,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: appPrimary),
          onPressed: () async{
            fetchData(context);
             print(uploadData);
             var result = await ApiService().uploadSubmitData(widget.standard, widget.subject, widget.section, widget.data['overall'], widget.data['exam'], uploadData);
              print('result');
              print(result);
              if(result['status'] == true) {
                toastification.show(
                  type: ToastificationType.success,
                  context: context,
                  title: Text('Sucess'),
                  autoCloseDuration: const Duration(seconds: 3),
                );
                Navigator.pop(context);
                Navigator.pop(context);
                // Navigator.push(context, MaterialPageRoute(builder: (context) => UploadResultScreen()));
              }
          },
          child: Text('SUBMIT', style: GoogleFonts.poppins(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w500),),
        ),
      ),
    );
  }
}
class LimitRange extends TextInputFormatter {
  LimitRange(
      this.minRange,
      this.maxRange,
      ) : assert(
  minRange < maxRange,
  );

  final int minRange;
  final int maxRange;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var value = int.parse(newValue.text);
    if (value < minRange) {
      print('value print in between 1 - 20');
      return TextEditingValue(text: minRange.toString());
    } else if (value > maxRange) {
      print('not more 20');
      return TextEditingValue(text: maxRange.toString());
    }
    return newValue;
  }
}