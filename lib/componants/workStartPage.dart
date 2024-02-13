import 'dart:async';
//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:friction/componants/ActivityData.dart';
import 'package:friction/componants/DownloadCenter.dart';
import 'package:friction/componants/updateActivity.dart';
import 'dart:convert';
import 'package:friction/ApiStrings.dart';
import 'package:friction/componants/SharedPreference.dart';
import 'package:http/http.dart' as http;

class WorkStartPage extends StatefulWidget {
  const WorkStartPage({Key? key}) : super(key: key);

  @override
  State<WorkStartPage> createState() => _WorkStartPageState();
}

class _WorkStartPageState extends State<WorkStartPage> {
  bool showGreenWidget = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(21, 134, 202, 1),
        title: Text('My Activities list',
          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1) , fontSize: 16,
            fontWeight: FontWeight.w700, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.all(10.0),
                height: 225,
                width: 400,
                child: Card(
                  borderOnForeground: true,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    side: BorderSide(
                      color: Color.fromRGBO(0, 0, 0, 0.25), // Border color
                      width: 1.0,          // Border width
                    ),
                  ),
                  child: Stack(
                    children: [
                      Column(mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              padding: EdgeInsets.all(10),
                              child: Text('Work Start Details',
                                style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1), fontSize: 14,
                                    fontWeight: FontWeight.w700,letterSpacing: 1,fontFamily: 'WorkSans'),
                              )),
                          Container(
                            child: Text('Please provide work description to start an \nActivity',
                              style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1), fontSize: 12,
                                  fontWeight: FontWeight.w600,letterSpacing: 1,fontFamily: 'WorkSans'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10.0),
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Description',
                                  hintText: 'Text Area',
                                  border: OutlineInputBorder(),
                                )
                            ),
                          ),
                          Container(
                            height: 36,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 20,),

                                Expanded(
                                  flex: 1,
                                  child: ElevatedButton(

                                    onPressed: () {
                                      //Navigator.push(context, MaterialPageRoute(builder: (context) => updateActivity(data: widget.itemData,)));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
                                      backgroundColor: Colors.white,
                                      side: BorderSide(color: Color.fromRGBO(26, 179, 148, 1),
                                          width: 1),
                                    ),
                                    child:  Text('Stop',
                                      style: TextStyle(color: Color.fromRGBO(26, 179, 148, 1), fontSize: 12,
                                          fontWeight: FontWeight.w600,letterSpacing: 0,fontFamily: 'WorkSans'),),
                                  ),

                                ),
                                SizedBox(width: 20,),
                                Expanded(
                                  flex: 1,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        showGreenWidget = true;
                                        startTimer(3);
                                      });
                                      //Navigator.push(context, MaterialPageRoute(builder: (context) => WorkStartPage()));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
                                      backgroundColor: Color.fromRGBO(26, 179, 148, 1),
                                      side: BorderSide(color: Color.fromRGBO(26, 179, 148, 1), width: 1),
                                    ),
                                    child: const Text('Start',
                                      style: TextStyle(color: Colors.white, fontSize: 12,
                                          fontWeight: FontWeight.w600,letterSpacing: 0,fontFamily: 'WorkSans'),),
                                  ),

                                ),
                                SizedBox(width: 20,)


                              ],
                            ),
                          )

                        ],
                      ),
                      Positioned(top: 5,
                          right: 5,
                          child: InkWell(
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                              child: Image.asset('assets/icons/close.png')))
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 5,
                top: 5,

                child: Visibility(
                  visible: showGreenWidget,
                  child: Container(
                    decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.green
                    ),
                    padding: EdgeInsets.all(5.0),
                    alignment: Alignment.topRight,
                    width: 275,
                    height: 53,
                    //color: Colors.green,
                    child: Center(
                      child: Text('Work started successfully for an Activity',
                          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1) , fontSize: 12,
                            fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',)),
                    ),
                  ),
                ),
              ),

            ],
          )
      ),
    );
  }
  void startTimer(int seconds) {
    Duration duration = Duration(seconds: seconds);
    Timer timer = Timer(duration, onEnd);
  }

  void onEnd() {
    setState(() {
      showGreenWidget = false;
    });
    // This is the callback function that executes when the timer ends.
    print('Timer has ended!');
  }
}




