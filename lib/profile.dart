import 'package:flutter/material.dart';
import 'package:friction/Strings.dart';
import 'package:friction/componants/Headline.dart';
import 'package:friction/componants/Scoreboard.dart';
import 'package:friction/componants/Checkin.dart';
import 'package:friction/componants/Footer.dart';
import 'package:friction/componants/checkin_list_view.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(21, 134, 202, 1),
          leading: Image.asset('assets/icons/arrowright2.png'),
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
                        Text('John Berg',
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
                child: ProfileItem(item: 'John Berg lutherbug',
                  icon: 'assets/icons/profile/user.png',
                  bIcon: ''
                ),
              ),
              Container(
                child: ProfileItem(item: 'john.berg@loram.com',
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
                child: ProfileItem(item: 'Male',
                    icon: 'assets/icons/profile/male.png',
                    bIcon: ''
                ),
              ),
              Container(
                child: ProfileItem(item: '+01 45898798000',
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
        )

    );
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






