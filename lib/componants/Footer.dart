import 'package:flutter/material.dart';
import 'package:friction/event.dart';
import 'package:friction/home.dart';
import 'package:friction/notification.dart';
import 'package:friction/profile.dart';

class Footer extends StatelessWidget {
  final int tab;
  const Footer({super.key, required this.tab});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 400,
        height: 60,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1),
          color: Colors.white,
          border: Border.all(
            color: Colors.black12,
            width: 2,),
        ),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
              },
              child: Column(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.all(10),
                    child:Image.asset('assets/icons/rising.png')),
                  Container(
                    child: Text('Metrics',
                      style: tab == 1 ? TextStyle(color: Color.fromRGBO(26, 179, 148, 1), fontSize: 13,
                          fontWeight: FontWeight.w700,letterSpacing: 1,fontFamily: 'WorkSans')
                            : TextStyle(color: Color.fromRGBO(69, 69, 69, 1), fontSize: 13,
                          fontWeight: FontWeight.w400,letterSpacing: 1,fontFamily: 'WorkSans')),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationEm()));
              },
              child: Column(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.all(10),
                    child:Image.asset('assets/icons/notifications.png')),
                  Container(
                    child: Text('Notifications',
                        style: tab == 2 ? TextStyle(color: Color.fromRGBO(26, 179, 148, 1), fontSize: 13,
                            fontWeight: FontWeight.w700,letterSpacing: 1,fontFamily: 'WorkSans')
                            : TextStyle(color: Color.fromRGBO(69, 69, 69, 1), fontSize: 13,
                            fontWeight: FontWeight.w400,letterSpacing: 1,fontFamily: 'WorkSans')),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyEvent()));
              },
              child: Column(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.all(10),
                    child: Image.asset('assets/icons/planner.png')),
                  Container(
                    child: Text('Events',
                      style: tab == 3 ? TextStyle(color: Color.fromRGBO(26, 179, 148, 1), fontSize: 13,
                  fontWeight: FontWeight.w700,letterSpacing: 1,fontFamily: 'WorkSans')
                      : TextStyle(color: Color.fromRGBO(69, 69, 69, 1), fontSize: 13,
                  fontWeight: FontWeight.w400,letterSpacing: 1,fontFamily: 'WorkSans')),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile()));
              },
              child: Column(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.all(10),
                    child:Image.asset('assets/icons/profile.png'),
                  ),
                  Container(
                    child: Text('Profile',
                        style: tab == 4 ? TextStyle(color: Color.fromRGBO(26, 179, 148, 1), fontSize: 13,
                            fontWeight: FontWeight.w700,letterSpacing: 1,fontFamily: 'WorkSans')
                            : TextStyle(color: Color.fromRGBO(69, 69, 69, 1), fontSize: 13,
                            fontWeight: FontWeight.w400,letterSpacing: 1,fontFamily: 'WorkSans')),
                  )
                ],
              ),
            ),
          ],
        )
    );
  }
}