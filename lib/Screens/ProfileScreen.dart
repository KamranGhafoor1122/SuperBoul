import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:superlotto/Constant/Color.dart';

import '../Constant/ApiConstant.dart';

class ProfileScreen extends StatefulWidget {
  String token;

  ProfileScreen(this.token, {Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var name, dob, phone, image;
  bool _isloading = false;
  var TAG = "";

  void initState() {
    _getProfile();
  }

  Future<void> _getProfile() async {
    var url = ApiConst.BASE_URL + ApiConst.get_profile;
    setState(() {
      _isloading = true;
    });

    /// Map<String, dynamic> body = { "password": pin1,"password_confirmation" : pin2};
    Map<String, String> userHeader = {
      "Authorization": "Bearer ${widget.token}",
      "Accept": "application/json"
    };
    var response = await http.get(Uri.parse(url), headers: userHeader);
    var responsedata = json.decode(response.body);
    debugPrint("$TAG response : ${response.body}");
    debugPrint("$TAG headers : ${response.headers}");
    var success = responsedata['success'];
    name = responsedata['user']['first_name'];
    dob = responsedata['user']['dob'];
    phone = responsedata['user']['phone'];
    image = responsedata['user']['profile_pic'];
    debugPrint('name : $name');
    debugPrint('dob : $dob');
    debugPrint('phone : $phone');
    debugPrint('image : $image');
    if (responsedata['message'] == 'success') {
      setState(() {
        _isloading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(responsedata['message']),
        duration: Duration(seconds: 3),
      ));
      // accesstoken = responsedata['user']['access_token'];
      //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileScreen(widget.token),));
    } else {
      setState(() {
        _isloading = false;
      });

    }
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
       SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColor.backgroundcolor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 200.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xffF6F3E5).withOpacity(0.1),
                      //   border: Border.all(width: 0.5),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back_ios),
                            SizedBox(width: 120.w),
                            Text(
                              'Profile',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      image==null ?
                      Container(
                        height: 60.h,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: 0.5),
                          image: DecorationImage(
                            image: NetworkImage('https://th.bing.com/th/id/OIP.kqT6XFsG2BTW22Y4st2-KAHaHa?pid=ImgDet&rs=1'),
                          ),
                        ),
                      ):Container(
                        height: 60.h,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: 0.5),
                          image: DecorationImage(
                            image: NetworkImage('https://th.bing.com/th/id/OIP.kqT6XFsG2BTW22Y4st2-KAHaHa?pid=ImgDet&rs=1'),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(name??'',style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600,fontSize: 24),)
                     /* Image.asset(
                        'assets/Images/Group 64.png',
                        scale: 4,
                      ),*/
                    ],
                  ),
                ),
                Container(
                  height: 110.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xffFFF5C6),
                      //border: Border.all(width: 0.5),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/Images/Group 12.png',
                          scale: 3.5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '100',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Played Games',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '75',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Win',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                _isloading == true?
                CircularProgressIndicator():SizedBox(),
                SizedBox(height: 15.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Text(
                        'Your Ticket',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    height: 100.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xffFFF5C6),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(0xffFFFFFF),
                            ),
                            child: Center(
                              child: Text(
                                '11',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(0xffFFFFFF),
                            ),
                            child: Center(
                              child: Text(
                                '17',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(0xffFFFFFF),
                            ),
                            child: Center(
                              child: Text(
                                '20',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'DOB',
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 55.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xffEAEAEA),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                dob??'06/10/1999',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                              Icon(
                                Icons.edit,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            "Phone",
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 55.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xffEAEAEA),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                phone??'9874563210',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                              Icon(
                                Icons.edit,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: const [
                          Text(
                            'Your Referral ',
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 55.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xffEAEAEA),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '526kll',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                              //   Icon(Icons.edit,color: Colors.black,)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
