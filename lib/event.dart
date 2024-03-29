import 'package:flutter/material.dart';
import 'package:friction/Strings.dart';
import 'package:friction/componants/Headline.dart';
import 'package:friction/componants/Scoreboard.dart';
import 'package:friction/componants/Checkin.dart';
import 'package:friction/componants/Footer.dart';
import 'package:friction/componants/checkin_list_view.dart';

class MyEvent extends StatelessWidget {
  const MyEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(21, 134, 202, 1),
          leading: Image.asset('assets/icons/arrowright2.png'),
          title: Text('Events',
            style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1) , fontSize: 16,
              fontWeight: FontWeight.w700, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
          centerTitle: true,
        ),
        // Adding the Drawer for the hamburger menu
        bottomNavigationBar: const BottomAppBar(
          child: Footer(tab: 3,),
        ),
        body: Container(
          alignment: Alignment.center,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/icons/notificationEm.png'),
              Text('No Notifications to display',
                style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                  fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),

            ],
          ),
        )

    );
  }
}






