import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:friction/ApiStrings.dart';
import 'package:friction/Strings.dart';
import 'package:friction/componants/Headline.dart';
import 'package:friction/componants/Scoreboard.dart';
import 'package:friction/componants/Checkin.dart';
import 'package:friction/componants/Footer.dart';
import 'package:friction/componants/checkin_list_view.dart';
import 'package:friction/componants/sharedPreference.dart';
import 'package:friction/data/ApiService.dart';
import 'package:friction/data/model/UserProfile.dart';
import 'package:http/http.dart' as http;

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<StatefulWidget> createState() => _MyProfile();
}

List<UserProfile> userProfileList = [];
late UserProfile userProfile;
String profileName = "John Berg";
String profileFullName = "John Berg";
String profileEmail = "john.berg@loram.com";
String gender = "male";
String mobile ="";

class _MyProfile extends State<MyProfile> {
  @override
  void initState() {
    //ApiService apiService = ApiService();
    //userProfile = apiService.getUserProfile().;
    getUserProfile();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(21, 134, 202, 1),
          title: Text('My Profile',
            style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1) , fontSize: 16,
              fontWeight: FontWeight.w700, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
          centerTitle: true,
        ),
        // Adding the Drawer for the hamburger menu
        bottomNavigationBar: const BottomAppBar(
          child: Footer(tab: 4,),
        ),
        body: Container(
          alignment: Alignment.center,

          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
                Card(
                  elevation: 10,
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(0),
                        width: 400,
                        height: 187,
                        child: Image.asset('assets/icons/menu/menubg.png',
                            fit: BoxFit.fill),
                      ),
                      Positioned(
                          top: 100,
                          left:240 ,
                          child: Image.asset('assets/icons/menu/edit.png')),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:[
                            SizedBox(
                              height: 2,
                            ),
                            Container(
                                width: 400,
                                height: 130,
                                child: Image.asset('assets/icons/menu/profile.png')
                            ),
                            Text(profileName,
                              style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                  fontFamily: 'WorkSans'),),
                            Text('User Since - Oct’ 2022',
                              style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1,
                                  fontFamily: 'WorkSans'),),
                            Text('Service Engineer',
                              style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1,
                                  fontFamily: 'WorkSans'),)
            
                          ]
                      )
            
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 15, 0, 5),
                  child: Text('Basic Information',
                    style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                      fontWeight: FontWeight.w600, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                ),
            
                Container(
                  child: ProfileItem(item: profileFullName,
                      icon: 'assets/icons/profile/user.png',
                      bIcon: ''
                  ),
                ),
                Container(
                  child: ProfileItem(item: profileEmail,
                      icon: 'assets/icons/profile/sms.png',
                      bIcon: ''
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  color: Colors.black,
                  width: double.infinity,
                  height: 0.1,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 15, 0, 5),
                  child: Text('Personal Information',
                    style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                      fontWeight: FontWeight.w600, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                ),
                Container(
                  child: ProfileItem(item: gender,
                      icon: 'assets/icons/profile/male.png',
                      bIcon: ''
                  ),
                ),
                Container(
                  child: ProfileItem(item: '+01 $mobile',
                      icon: 'assets/icons/profile/call.png',
                      bIcon: ''
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  color: Colors.black,
                  width: double.infinity,
                  height: 0.1,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 15, 0, 5),
                  child: Text('Legal',
                    style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                      fontWeight: FontWeight.w600, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                ),
                Container(
                  child: ProfileItem(item: 'Terms Of Service',
                      icon: 'assets/icons/menu/note.png',
                      bIcon: 'assets/icons/profile/arrowright3.png'
                  ),
                ),
                Container(
                  child: ProfileItem(item: 'Privacy',
                      icon: 'assets/icons/profile/key.png',
                      bIcon: 'assets/icons/profile/arrowright3.png'
                  ),
                ),
                Container(
                  child: ProfileItem(item: 'End User Agreement',
                      icon: 'assets/icons/profile/task.png',
                      bIcon: 'assets/icons/profile/arrowright3.png'
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  color: Colors.black,
                  width: double.infinity,
                  height: 0.1,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 15, 0, 5),
                  child: Text('About',
                    style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                      fontWeight: FontWeight.w600, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                ),
                Container(
                  child: ProfileItem(item: 'Help',
                      icon: 'assets/icons/profile/info.png',
                      bIcon: ''
                  ),
                ),
                Container(
                  child: ProfileItem(item: 'App Version',
                      icon: 'assets/icons/profile/mobile.png',
                      bIcon: 'v'
                  ),
                ),
            
              ],
            ),
          ),
        )

    );
  }

  getUserProfile() async {
    String? token = await SharedPreference().getStringFromSharedPreferences("token");
    final Uri uri = Uri.parse(ApiStrings.baseUrl+ ApiStrings.endpoint_get_user_profile);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    Map<String, String> body = {
      "email": "sandeep.kiran@global-csg.com"
    };
    //Uri.parse(API_URL)
    http.Response response = await http.put(uri,
        headers: headers, body: jsonEncode(body));
    print("Request Body --- ${body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body)["Friction"];
      print("Response Success");
      print(response.statusCode);
      print(data["message"]);
      print(data["data"]);
      //SharedPreference().saveStringToSharedPreferences("activityId", data["data"]["ActivityTypeSerialId"]);
      userProfile = UserProfile.fromJson(data["data"]);
      // for(var data in data["data"]){
      //   userProfileList.add(UserProfile.fromJson(data));
      // }
      print("userPrifile:" + data.toString() );
      print("userProfile saved:" + userProfile.toString());
      print("userProfile saved: ${userProfile.Email}" );
      setState(() {
        mobile = userProfile.Mobile ?? "0";
        profileName = userProfile.FirstName ?? "";
        profileEmail = userProfile.Email ?? "";
        profileFullName = '${userProfile.FirstName} ${userProfile.LastName}';
        gender = userProfile.Gender ?? "";


      });

    } else {
      print("Response Failure");

    }
  }
}


class ProfileItem extends StatelessWidget {
  final String item;
  final String icon;
  final String bIcon;
  const ProfileItem({super.key, required this.item, required this.icon, required this.bIcon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          height: 30,
          child: Image.asset(icon)

        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Text(item,
            style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1), fontSize: 14,
                fontWeight: FontWeight.w500,letterSpacing: 1,fontFamily: 'WorkSans'),
          ),
        ),

        Expanded(
          child:Container(
            padding: EdgeInsets.only(right: 10.0),
            alignment: Alignment.centerRight,
            height: 30,
            child: bIcon == '' ?SizedBox()
                :bIcon == 'v'?Text('1.0 v',style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1), fontSize: 14,
                fontWeight: FontWeight.w500,letterSpacing: 1,fontFamily: 'WorkSans'),)
                :Image.asset(bIcon),
    )

        ),
      ],
    );
  }
}








