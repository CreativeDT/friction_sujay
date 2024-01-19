import 'package:flutter/material.dart';
import 'package:friction/Strings.dart';
import 'package:friction/componants/Headline.dart';
import 'package:friction/componants/Scoreboard.dart';
import 'package:friction/componants/Checkin.dart';
import 'package:friction/componants/Footer.dart';
import 'package:friction/componants/checkin_list_view.dart';

class NotificationEm extends StatelessWidget {
  const NotificationEm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(21, 134, 202, 1),
        title: Text('Notifications',
    style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1) , fontSize: 16,
    fontWeight: FontWeight.w700, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
        centerTitle: true,
      ),
      // Adding the Drawer for the hamburger menu
      bottomNavigationBar: const BottomAppBar(
        child: Footer(tab: 2,),
      ),
      body: Container(
        alignment: Alignment.center,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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






