import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:ed_management/Colors.dart';
import 'package:ed_management/screens/Login%20Screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class ApiService {
  Future getUsers(userName, password,  sid, id) async {
    var bodyData = jsonEncode({
      "username": userName,
      "password": password,
      "sid": sid ? password : '',
      // "ids": id == '0' ? "0" : id,
      // "device":"",

    });
    var LoginUrl = 'login.php';
    try {
      var url = Uri.parse(baseUrl + LoginUrl);
      var response = await http.post(url,
           headers : {
          'Content-Type': 'application/json'
          },
          body: bodyData);
      var data = jsonDecode(response.body);
      print('===data');
      print(data);
      return data;
    } catch (e) {
      log(e.toString());
    }
  }


  Future addLeaveByStaff(fromDate, toDate, reason, remark) async {
    final prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('userid');
    var subdomain = prefs.getString('subdomain');
    var token = prefs.getString('token');
    var bodyData = jsonEncode({
      "userid": user_id,
      "subdomain": subdomain,
      "token":token,
      "fdate":fromDate, //from date
      "tdate": toDate, // todate
      "title": reason,
      "remark":remark
    });
    var LoginUrl = 'leave.php';
    try {
      var url = Uri.parse(baseUrl + LoginUrl);
      var response = await http.post(url,
          headers : {
            'Content-Type': 'application/json'
          },
          body: bodyData);
      var data = jsonDecode(response.body);
      print('===data');
      print(data);
      return data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future updateAttendanceData(toDate, reason, remark, sid) async {
    final prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('userid');
    var subdomain = prefs.getString('subdomain');
    var token = prefs.getString('token');
    var bodyData = ({
      "userid": user_id,
      "subdomain": subdomain,
      "token":token, //from date
      "idate": toDate, // todate
      "title": reason,
      "remark":remark,
      "sid": sid
    });
    var LoginUrl = 'attendance_view.php';
    try {
      var url = Uri.parse(baseUrl + LoginUrl);
      var response = await http.post(url,
          // headers : {
          //   'Content-Type': 'application/json'
          // },
          body: bodyData);
      var data = jsonDecode(response.body);
      print('===data');
      print(data);
      return data;
    } catch (e) {
      log(e.toString());
    }
  }


  Future studentAdd(sr, doa, fname, cname, mname, dob, caste, rel, gender, smobile, gmobile, street, aadhar,hno,land, area,city, dict, pin, gov, depart,ret, admission  ) async {
    final prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('userid');
    var subdomain = prefs.getString('subdomain');
    var token = prefs.getString('token');
    var bodyData = ({
      "userid": user_id,
      "subdomain": subdomain,
      "token":token, //from date
        "sr":sr,
        "doa":doa,
        "fname": fname,
        'cname':cname,
        'mname':mname,
        'dob': dob,
        'caste':caste,
        'rel':rel,
        'gender':gender,
        'smobile':smobile,
        'gmobile':gmobile,
        'streat':street,
        'adhar': aadhar,
        'hno': hno,
        'land': land,
        'area': area,
        'city': city,
        'dict': dict,
        'pin': pin,
        'gov1': '',
        'department1': '',
        'retirement1':'',
        'gov2': '',
        'department2': '',
        'retirement2':'',
        'admission': admission == 'yes' ? 'New' : 'Old'
    });
    var LoginUrl = 'add_students.php';
    try {
      var url = Uri.parse(baseUrl + LoginUrl);
      var response = await http.post(url,
          // headers : {
          //   'Content-Type': 'application/json'
          // },
          body: bodyData);
      var data = jsonDecode(response.body);
      print('===data');
      print(data);
      return data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future registerAppealData(subject, description, mode, level, name, mobile, amobile, type, update, depart, image) async {
    final prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('userid');
    var subdomain = prefs.getString('subdomain');
    var token = prefs.getString('token');
    var bodyData = {
      "userid": user_id,
      "subdomain": subdomain,
      "token":token, //from date
      "subject": subject,
      "desc": description,
        "mode": mode,
        "level": level,
        "name": name,
        "mobile": mobile,
        "amobile": amobile,
        "type": type,
        "update": update,
        "department": depart,
    };
    var LoginUrl = 'add-complaint.php';
    try {
      var url = Uri.parse(baseUrl + LoginUrl);
      var request = await http.MultipartRequest( 'POST', url);
      request.fields.addAll({
        "userid": '$user_id',
        "subdomain": '$subdomain',
        "token":'$token', //from date
        "subject": subject,
        "desc": description,
        "mode": mode,
        "level": level,
        "name": name,
        "mobile": mobile,
        "amobile": amobile,
        "type": type,
        "update": '',
        "department": depart,
      });
      // request.files.add(await http.MultipartFile.fromPath('uplm', image));
      // request.files.add(http.MultipartFile.fromBytes('uplm', File(image).readAsBytesSync(),filename: image));
      // request.headers.addAll(headers);

      request.files.add(await http.MultipartFile.fromPath('uplm', image));
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        print(await response.stream.bytesToString());
        print('===data');
        print(data);
        return data;
      }
      else {
        var data = response.reasonPhrase;
        print(response.reasonPhrase);
        print('===data');
        print(data);
        return data;
      }

      // var data = jsonDecode(response);

    } catch (e) {
      log(e.toString());
      return e.toString();
    }
  }

  Future uploadMarksStudent(standard, date, id) async {
    final prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('userid');
    var subdomain = prefs.getString('subdomain');
    var token = prefs.getString('token');
    var bodyData = jsonEncode({
      "userid": user_id,
      "subdomain": subdomain,
      "token":token,
      "standard":standard,
      "idate":date,
      "classtest":id
    });
    var LoginUrl = 'class-test-students.php';
    try {
      var url = Uri.parse(baseUrl + LoginUrl);
      var response = await http.post(url,
          headers : {
            'Content-Type': 'application/json'
          },
          body: bodyData);
      var data = jsonDecode(response.body);
      print('===data');
      print(data);
      return data;
    } catch (e) {
      log(e.toString());
    }
  }


  Future attendanceByQRCode(lat, long, qrcode) async {
    final prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('userid');
    var subdomain = prefs.getString('subdomain');
    var token = prefs.getString('token');
    var bodyData = jsonEncode({
      "userid": user_id,
      "subdomain": subdomain,
      "token":token,
      "lat":lat,
      "lon":long,
      "qr":qrcode
    });
    var LoginUrl = 'staff_attendance_qr.php';
    try {
      var url = Uri.parse(baseUrl + LoginUrl);
      var response = await http.post(url,
          headers : {
            'Content-Type': 'application/json'
          },
          body: bodyData);
      var data = jsonDecode(response.body);
      print('===data');
      print(data);
      return data;
    } catch (e) {
      log(e.toString());
    }
  }


  Future updateLocation(lat, long) async {
    final prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('userid');
    // var subdomain = prefs.getString('subdomain');
    var token = prefs.getString('token');
    var bodyData = jsonEncode({
      "userid": user_id,
      // "subdomain": subdomain,
      "token":token,
      "lat":lat,
      "lon":long,
    });
    var LoginUrl = 'location_update.php';
    try {
      var url = Uri.parse(baseUrl + LoginUrl);
      var response = await http.post(url,
          headers : {
            'Content-Type': 'application/json'
          },
          body: bodyData);
      var data = jsonDecode(response.body);
      print('===data');
      print(data);
      return data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future attendanceByLocation(lat, long, photo) async {
    final prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('userid');
    var token = prefs.getString('token');
    // var bodyData = {
    //   "userid": user_id,
    //   "sid":user_id,
    //   "token":token,
    //   "lat":lat,
    //   "lon":long,
    // };
    // var LoginUrl = 'staff_attendance.php';
    // try {
    //   var url = Uri.parse(baseUrl + LoginUrl);
    //   var response = await http.post(url,
    //       // headers : {
    //       //   'Content-Type': 'application/json'
    //       // },
    //       body: bodyData);
    //   var data = jsonDecode(response.body);
    //   print('===data');
    //   print(data);
    //   return data;
    // } catch (e) {
    //   log(e.toString());
    // }

    var request = http.MultipartRequest('POST', Uri.parse('https://edpluss.com/project/api/staff_attendance.php'));
    request.fields.addAll({
      'userid': '$user_id',
      'token': '$token',
      'sid': '$user_id',
      'lat': '$lat',
      'lon': '$long'
    });
    request.files.add(await http.MultipartFile.fromPath('photo', '$photo'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      // var data = await response.stream.bytesToString();
      // print('data====$data');
      // var res = jsonDecode(data);
      return await response.stream.bytesToString();
    }
    else {
      print(response.reasonPhrase);
      return response.reasonPhrase;
    }

  }

  Future sendOtp(userName) async {
    var bodyData = jsonEncode({
      "mobile": userName
    });
    var LoginUrl = 'otp.php';
    try {
      var url = Uri.parse(baseUrl + LoginUrl);
      var response = await http.post(url,
          headers : {
            'Content-Type': 'application/json'
          },
          body: bodyData);
      var data = jsonDecode(response.body);
      print('===data');
      print(data);
      return data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future verifyOtp(userName, otp) async {
    var bodyData = jsonEncode({
      "mobile": userName,
      "otp": otp
    });
    var LoginUrl = 'otp.php';
    try {
      var url = Uri.parse(baseUrl + LoginUrl);
      var response = await http.post(url,
          headers : {
            'Content-Type': 'application/json'
          },
          body: bodyData);
      var data = jsonDecode(response.body);
      print('===data');
      print(data);
      return data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future forgotPassword(userName, otp, isVerify, password) async {
    var bodyData = jsonEncode({
      "username": userName,
      "otp": isVerify ? otp : '',
      "mode": isLoginByOtp ? '1' : '',
      'password': password

    });
    var LoginUrl = 'forgot.php';
    try {
      var url = Uri.parse(baseUrl + LoginUrl);
      var response = await http.post(url,
          headers : {
            'Content-Type': 'application/json'
          },
          body: bodyData);
      var data = jsonDecode(response.body);
      print('===data');
      print(data);
      return data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future dashboardData() async {
    final prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('userid');
    // var subdomain = prefs.getString('subdomain');
    var token = prefs.getString('token');
    print('Token');
    print(token);
// "key":"standard", // if search by tag so send tag , if seach by section so send section
    // "value":[
    //   {
    //     "name":"10th HM"
    //   }
    // ]
    var bodyData = jsonEncode({
      "userid": user_id,
      "lat":"",
       "lon":"",
      "token": token,
      });
    print('bodyData');
    print(bodyData);
    var LoginUrl = 'dashboard.php';
    try {
      var url = Uri.parse(baseUrl + LoginUrl);
      var response = await http.post(url,
          headers : {
            'Content-Type': 'application/json'
          },
          body: bodyData);
      var data = jsonDecode(response.body);
      print('===data');
      print(data);
      return data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future uploadResultData() async {
    final prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('userid');
    var subdomain = prefs.getString('subdomain');
    var token = prefs.getString('token');
// "key":"standard", // if search by tag so send tag , if seach by section so send section
    // "value":[
    //   {
    //     "name":"10th HM"
    //   }
    // ]
    var bodyData = jsonEncode({
      "userid": user_id,
      "subdomain": subdomain,
      "token": token,
    });
    print('bodyData');
    print(bodyData);
    var LoginUrl = 'result-list.php';
    try {
      var url = Uri.parse(baseUrl + LoginUrl);
      var response = await http.post(url,
          headers : {
            'Content-Type': 'application/json'
          },
          body: bodyData);
      var data = jsonDecode(response.body);
      print('===data');
      print(data);
      return data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future studentManageData(filter) async {
    final prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('userid');
    var subdomain = prefs.getString('subdomain');
    var token = prefs.getString('token');
// "key":"standard", // if search by tag so send tag , if seach by section so send section
    // "value":[
    //   {
    //     "name":"10th HM"
    //   }
    // ]
    var bodyData = ({
      "userid": user_id,
      "subdomain": subdomain,
      "token": token,
      'value': filter
    });
    print('bodyData');
    print(bodyData);
    var LoginUrl = 'add_students.php';
    try {
      var url = Uri.parse(baseUrl + LoginUrl);
      var response = await http.post(url,
          // headers : {
          //   'Content-Type': 'application/json'
          // },
          body: bodyData);
      var data = jsonDecode(response.body);
      print('===data');
      print(data);
      return data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future reportData(searchValue, value, key) async {
    final prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('userid');
    var subdomain = prefs.getString('subdomain');
    var token = prefs.getString('token');
// "key":"standard", // if search by tag so send tag , if seach by section so send section
    // "value":[
    //   {
    //     "name":"10th HM"
    //   }
    // ]
    var bodyData = jsonEncode({
      "userid": user_id,
      "subdomain": subdomain,
      "token": token,
      "search":"${searchValue}",
      "key": key == 1 ? "standard" : "section", // if search by tag so send tag , if seach by section so send section
      "value": value
      // by default we are showing 50 Students in fees overdue report so send 1 if select filter by user so send NULL
    });
    print('bodyData');
    print(bodyData);
    var LoginUrl = 'students.php';
    try {
      var url = Uri.parse(baseUrl + LoginUrl);
      var response = await http.post(url,
          headers : {
            'Content-Type': 'application/json'
          },
          body: bodyData);
      var data = jsonDecode(response.body);
      print('===data');
      print(data);
      return data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future academicData(value, type) async {
    final prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('userid');
    var subdomain = prefs.getString('subdomain');
    var token = prefs.getString('token');
    var bodyData = jsonEncode({
      "userid": user_id,
      "subdomain": subdomain,
      "token": token,
      "type": 'search', // if want to search , either send standard if want to filter by standard
      "val": 'naveen' // Search Value OR Standard
    });
    var LoginUrl = 'reports.php';
    try {
      var url = Uri.parse(baseUrl + LoginUrl);
      var response = await http.post(url,
          headers : {
            'Content-Type': 'application/json'
          },
          body: bodyData);
      var data = jsonDecode(response.body);
      print('===data');
      print(data);
      return data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future attendanceData() async {
    final prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('userid');
    var subdomain = prefs.getString('subdomain');
    var token = prefs.getString('token');
    var bodyData = jsonEncode({
      "userid": user_id,
      "subdomain": subdomain,
      "token": token,
    });
    var LoginUrl = 'attendance_history.php';
    try {
      var url = Uri.parse(baseUrl + LoginUrl);
      var response = await http.post(url,
          headers : {
            'Content-Type': 'application/json'
          },
          body: bodyData);
      var data = jsonDecode(response.body);
      print('===data');
      print(data);
      return data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future NotesViewData(value) async {
    final prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('userid');
    var subdomain = prefs.getString('subdomain');
    var token = prefs.getString('token');
    var bodyData = {
      "userid": user_id,
      "subdomain": subdomain,
      "token": token,
      "typed": value
    };
    var LoginUrl = 'notes.php';
    try {
      var url = Uri.parse(baseUrl + LoginUrl);
      var response = await http.post(url,
          // headers : {
          //   'Content-Type': 'application/json'
          // },
          body: bodyData);
      var data = jsonDecode(response.body);
      print('===data');
      print(data);
      return data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future appealViewData() async {
    final prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('userid');
    var subdomain = prefs.getString('subdomain');
    var token = prefs.getString('token');
    var bodyData = {
      "userid": user_id,
      "subdomain": subdomain,
      "token": token,
    };
    var LoginUrl = 'add-complaint.php';
    try {
      var url = Uri.parse(baseUrl + LoginUrl);
      var response = await http.post(url,
          // headers : {
          //   'Content-Type': 'application/json'
          // },
          body: bodyData);
      var data = jsonDecode(response.body);
      print('===data');
      print(data);
      return data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future attendanceViewData() async {
    final prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('userid');
    var subdomain = prefs.getString('subdomain');
    var token = prefs.getString('token');
    var bodyData = {
      "userid": user_id,
      "subdomain": subdomain,
      "token": token,
    };
    var LoginUrl = 'attendance_view.php';
    try {
      var url = Uri.parse(baseUrl + LoginUrl);
      var response = await http.post(url,
          // headers : {
          //   'Content-Type': 'application/json'
          // },
          body: bodyData);
      var data = jsonDecode(response.body);
      print('===data');
      print(data);
      return data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future attendanceFillData(data, date) async {
    final prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('userid');
    var subdomain = prefs.getString('subdomain');
    var token = prefs.getString('token');
    print('data attendance');
    print(data);
    var bodyData = jsonEncode({
      "userid": user_id,
      "subdomain": subdomain,
      "token": token,
      "standard": data, // get details from attendance class access in filter
      "section": "",
      "idate": date
    });
    var LoginUrl = 'attendance.php';
    try {
      var url = Uri.parse(baseUrl + LoginUrl);
      var response = await http.post(url,
          headers : {
            'Content-Type': 'application/json'
          },
          body: bodyData);
      var data = jsonDecode(response.body);
      print('===data');
      print(data);
      return data;
    } catch (e) {
      log(e.toString());
    }
  }


  Future attendanceSubmitData(data, date) async {
    final prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('userid');
    var subdomain = prefs.getString('subdomain');
    var token = prefs.getString('token');
    var bodyData = jsonEncode({
      "userid": user_id,
      "subdomain": subdomain,
      "token": token,
      "data": data,
      "idate": date,
    });
    var LoginUrl = 'attendance_submit.php';
    try {
      var url = Uri.parse(baseUrl + LoginUrl);
      var response = await http.post(url,
          headers : {
            'Content-Type': 'application/json'
          },
          body: bodyData);
      var data = jsonDecode(response.body);
      print('===data');
      print(data);
      return data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future studentMarksSubmitData(data, date, outof, class_id, subject) async {
    final prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('userid');
    var subdomain = prefs.getString('subdomain');
    var token = prefs.getString('token');
    var bodyData = jsonEncode({
      "userid": user_id,
      "subdomain": subdomain,
      "token": token,
      "subject":subject,
      "idate":date,
      "classtest":class_id,
      "outoff":outof,
      "data": data,
    });
    var LoginUrl = 'class-test.php';
    try {
      var url = Uri.parse(baseUrl + LoginUrl);
      var response = await http.post(url,
          headers : {
            'Content-Type': 'application/json'
          },
          body: bodyData);
      var data = jsonDecode(response.body);
      print('===data');
      print(data);
      return data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future uploadSubmitData(standard, subject, section,  outoff, exam, data,) async {
    final prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('userid');
    var subdomain = prefs.getString('subdomain');
    var token = prefs.getString('token');
    var bodyData = jsonEncode({
      "userid": user_id,
      "subdomain": subdomain,
      "token": token,
      "standard":standard, // Get from Upload result list array
      "subject":subject, // Get from Upload result list array
      "section":section, // Get from Upload result list array
      "outoff":outoff, // Get from Upload result list array
      "exam":exam, // Get from Upload result list array
      "data": data,
    });
    var LoginUrl = 'uploadresult_submit.php';
    try {
      var url = Uri.parse(baseUrl + LoginUrl);
      var response = await http.post(url,
          headers : {
            'Content-Type': 'application/json'
          },
          body: bodyData);
      var data = jsonDecode(response.body);
      print('===data');
      print(data);
      return data;
    } catch (e) {
      log(e.toString());
    }
  }


  Future notification() async {
    final prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('userid');
    var subdomain = prefs.getString('subdomain');
    var token = prefs.getString('token');
    var bodyData = jsonEncode({
      "userid": user_id,
      "subdomain": subdomain,
      "token": token,
    });
    var LoginUrl = 'notification.php';
    try {
      var url = Uri.parse(baseUrl + LoginUrl);
      var response = await http.post(url,
          headers : {
            'Content-Type': 'application/json'
          },
          body: bodyData);
      var data = jsonDecode(response.body);
      print('===data');
      print(data);
      return data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future attendanceFilterData() async {
    final prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('userid');
    var subdomain = prefs.getString('subdomain');
    var token = prefs.getString('token');
    var bodyData = jsonEncode({
      "userid": user_id,
      "subdomain": subdomain,
      "token": token,
    });
    var LoginUrl = 'attendance.php';
    try {
      var url = Uri.parse(baseUrl + LoginUrl);
      var response = await http.post(url,
          headers : {
            'Content-Type': 'application/json'
          },
          body: bodyData);
      var data = jsonDecode(response.body);
      print('===data');
      print(data);
      return data;
    } catch (e) {
      log(e.toString());
    }
  }


  Future uploadResultViewData(standard, subject, section, exam) async {
    final prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('userid');
    var subdomain = prefs.getString('subdomain');
    var token = prefs.getString('token');
    var bodyData = jsonEncode({
      "userid": user_id,
      "subdomain": subdomain,
      "token": token,
      "standard": standard, // Get from Upload result list array
      "subject":subject, // Get from Upload result list array
      "exam":exam, // Get from Upload result list array
      "section":section
    });
    var LoginUrl = 'uploadresult.php';
    try {
      var url = Uri.parse(baseUrl + LoginUrl);
      var response = await http.post(url,
          headers : {
            'Content-Type': 'application/json'
          },
          body: bodyData);
      var data = jsonDecode(response.body);
      print('===data');
      print(data);
      return data;
    } catch (e) {
      log(e.toString());
    }
  }
}