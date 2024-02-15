import 'package:flutter/material.dart';
import 'package:friction/Strings.dart';
import 'package:friction/componants/Headline.dart';
import 'package:friction/componants/Scoreboard.dart';
import 'package:friction/componants/Checkin.dart';
import 'package:friction/componants/Footer.dart';
import 'package:friction/componants/checkin_list_view.dart';


class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool noNotification = false;

  @override
  void initState() {
    // TODO: implement initState
    noNotification= false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(

          backgroundColor: const Color.fromRGBO(21, 134, 202, 1),
          title: Container(
            alignment: AlignmentDirectional.center,
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 60,),
                Text('Notifications',
                  style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1) , fontSize: 16,
                    fontWeight: FontWeight.w700, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                //SizedBox(width: 60),
                Expanded(child: SizedBox()),


                Container(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text("3 Unread",
                    style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1) , fontSize: 16,
                      fontWeight: FontWeight.w700, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                ),
              ],
            ),
          ),
          centerTitle: true,
        ),
        // Adding the Drawer for the hamburger menu
        bottomNavigationBar: const BottomAppBar(
          child: Footer(tab: 2,),
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,

              child: Visibility(
                visible: noNotification,
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
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("02-12-2023", style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                    fontWeight: FontWeight.w600, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                  NotificationCard(),
                  NotificationCard()

                ],
              ),
            )
          ],
        )

    );
  }
}

class NotificationCard extends StatefulWidget {
  String status = 'Pending';
  bool readStatus = true;
   NotificationCard({super.key});

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          width: 400,
          height: 82,
          child: Card(
              elevation: 5,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                children: [
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity(vertical: 4),
                    minLeadingWidth: 40,
                    leading: Container(
                      //alignment: Alignment.topLeft,
                      //color: Colors.red,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset('assets/icons/menu/Ellipse7.png', scale: 1.5,color: Colors.orange,),
                          Text('TR',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1) , fontSize: 20,
                              fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),
                          ),
                        ],
                      ),

                    ),
                    trailing: Container(
                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(widget.status,
                            style: TextStyle(color: Color.fromRGBO(21, 134, 202 , 1) , fontSize: 12,
                              fontWeight: FontWeight.w600, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),
                          ),

                          SizedBox(height: 10, width: 10,),
                          Image.asset('assets/icons/list/arrowright2.png',alignment: Alignment.bottomRight,)
                        ],
                      ),
                    ),
                    title: Container(
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Track Repair',
                            style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                              fontWeight: FontWeight.w600, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),
                          ),
                          Container(
                              child: Text('10 AM to 10:30 AM',
                                style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 12,
                                  fontWeight: FontWeight.w600, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),
                              ),
                          ),

                          Text('Lane-4, Missouri',
                            style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 12,
                              fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),
                          ),


                        ],
                      ),
                    ),

                  ),
                  Container(
                    width: 400,
                    height: 8,
                    color: widget.status == "Pending"? Colors.orange : Colors.blueAccent,
                  )

                ],
              )
          )
        ),
        Container(
            margin: EdgeInsets.only(bottom: 10),
            width: 400,
            height: 82,
            child: Column(
              children: [
                Card(
                    elevation: 5,
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: ListTile(
                      dense: true,
                      visualDensity: VisualDensity(vertical: 4),
                      minLeadingWidth: 40,
                      leading: Container(
                        //alignment: Alignment.topLeft,
                        //color: Colors.red,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset('assets/icons/menu/Ellipse7.png', scale: 1.5,color: Colors.lightBlueAccent,),
                            Text('OW',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1) , fontSize: 20,
                                fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),
                            ),
                          ],
                        ),

                      ),
                      trailing: Container(
                        child: Column(

                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('In Progress',
                              style: TextStyle(color: Color.fromRGBO(21, 134, 202 , 1) , fontSize: 12,
                                fontWeight: FontWeight.w600, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),
                            ),

                            SizedBox(height: 10, width: 10,),
                            Image.asset('assets/icons/list/arrowright2.png',alignment: Alignment.bottomRight,)
                          ],
                        ),
                      ),
                      title: Container(
                        alignment: Alignment.topCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Track Repair',
                              style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                                fontWeight: FontWeight.w600, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),
                            ),
                            Container(
                              child: Text('10 AM to 10:30 AM',
                                style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 12,
                                  fontWeight: FontWeight.w600, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),
                              ),
                            ),

                            Text('Lane-4, Missouri',
                              style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 12,
                                fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),
                            ),


                          ],
                        ),
                      ),

                    ),

                ),
                Container(
                  width: 400,
                  height: 8,
                  color: Colors.blueAccent,
                )
              ],
            )
        ),
        Container(
            margin: EdgeInsets.only(bottom: 10),
            width: 400,
            height: 82,
            child: Column(
              children: [
                Card(
                    elevation: 5,
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: ListTile(
                      dense: true,
                      visualDensity: VisualDensity(vertical: 4),
                      minLeadingWidth: 40,
                      leading: Container(
                        //alignment: Alignment.topLeft,
                        //color: Colors.red,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset('assets/icons/menu/Ellipse7.png', scale: 1.5,color: Colors.lime,),
                            Text('TR',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1) , fontSize: 20,
                                fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),
                            ),
                          ],
                        ),

                      ),
                      trailing: Container(
                        child: Column(

                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Pending',
                              style: TextStyle(color: Color.fromRGBO(235, 120, 24 , 1) , fontSize: 12,
                                fontWeight: FontWeight.w600, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),
                            ),

                            SizedBox(height: 10, width: 10,),
                            Image.asset('assets/icons/list/arrowright2.png',alignment: Alignment.bottomRight,)
                          ],
                        ),
                      ),
                      title: Container(
                        alignment: Alignment.topCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Track Repair',
                              style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                                fontWeight: FontWeight.w600, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),
                            ),
                            Container(
                              child: Text('10 AM to 10:30 AM',
                                style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 12,
                                  fontWeight: FontWeight.w600, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),
                              ),
                            ),

                            Text('Lane-4, Missouri',
                              style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 12,
                                fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),
                            ),


                          ],
                        ),
                      ),

                    )
                ),
                Container(
                  width: 400,
                  height: 8,
                  color: Colors.orange,
                )
              ],
            )
        ),
      ],
    );
  }
}














