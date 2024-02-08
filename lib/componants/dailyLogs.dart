import 'package:flutter/material.dart';
import 'package:friction/componants/ActivityData.dart';
import 'package:friction/componants/DownloadCenter.dart';
import 'package:friction/componants/updateActivity.dart';
import 'package:friction/data/ApiService.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:friction/Strings.dart';
import 'package:friction/ApiStrings.dart';
import 'package:friction/componants/SharedPreference.dart';
import 'package:friction/home.dart';
import 'package:http/http.dart' as http;
import 'package:friction/componants/Headline.dart';
import 'package:friction/componants/Scoreboard.dart';
import 'package:friction/componants/Checkin.dart';
import 'package:friction/componants/Footer.dart';
import 'package:friction/componants/checkin_list_view.dart';

import '../data/model/DailyLogData.dart';

class dailyLogs extends StatelessWidget {
  const dailyLogs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(21, 134, 202, 1),
        title: Text('Daily Logs',
          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1) , fontSize: 16,
            fontWeight: FontWeight.w700, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: MyCustomForm()
      ),
    );
  }
}


final ApiService apiService = ApiService();
DownloadCenter downloadCenter = DownloadCenter();
List<DailyLogData> dailyLogList = [];
List<Item> items = [];
int previousIndex = 0;
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    items.clear();
    dailyLogList.clear();
    apiService.getDailyLogs(1).then((data){
      for(var data in data){
        dailyLogList.add(DailyLogData.fromJson(data));
      }

      setState(() {
        id = dailyLogList[0].railUnitLocationId.toString();
        dateCreated = dailyLogList[0].uploadedDateTime!;

        for(var i=0; i<= dailyLogList.length-1; i++) {
          var data = dailyLogList[i];
          var item = Item(createdDate: data.createdAt!,
            workStart: data.estimatedWorkStartDate!,
            workEnd: data.estimatedWorkEndDate!,
            id: data.railUnitLocationId.toString(),
            uploadedDate: data.uploadedDateTime!,
            country: data.country!,
            state: data.state!,
            railRoad: data.railRoad!, index: i,);

          items.add(item);
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(margin: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(


                        onPressed: (){
                          downloadCenter.logsDownload(dailyLogList);

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(26, 179, 148, 1),
                          foregroundColor: Colors.white,
                          side: BorderSide(color: Color.fromRGBO(26, 179, 148, 1), width: 5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/icons/menu/down.png',
                              fit: BoxFit.fitHeight,),
                            SizedBox(width: 6,),
                            Text("CSV",
                              style: TextStyle(color: Colors.white, fontSize: 12,
                                  fontWeight: FontWeight.w400,letterSpacing: 1,fontFamily: 'WorkSans'),)
                          ],
                        )),
                  ),
                  SizedBox(width: 200,)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black12,
                    width: 2,)),
              child:ExpansionPanelList.radio(
                elevation: 1,

                expandedHeaderPadding: EdgeInsets.all(0),

                dividerColor: Colors.grey,
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {

                    isExpanded = items[index].isExpanded;
                    items[index].isExpanded = !isExpanded;
                    previousIndex = index;
                  });
                },
                children:items.map<ExpansionPanel>((Item item){
                  return ExpansionPanelRadio(
                    canTapOnHeader: true,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Container(
                          margin: EdgeInsets.all(10.0),
                          child: Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('ID',
                                      style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 14,
                                        fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('Date Created',
                                      style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 12,
                                        fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),)
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.id,
                                      style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                                        fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(item.createdDate,
                                      style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 12,
                                        fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),

                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    body: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Work Start',
                              style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 14,
                                fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Work End',
                              style:TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 14,
                                fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                            SizedBox(height: 10,),
                            Text('Uploaded',
                              style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 14,
                                fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Country',
                              style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 14,
                                fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                            SizedBox(
                              height: 10,
                            ),
                            Text('State',
                              style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 14,
                                fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Rail Road',
                              style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 14,
                                fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                            SizedBox(
                              height: 10,
                            ),
                            Text('#Helpers',
                              style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 14,
                                fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.workStart,
                              style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                                fontWeight: FontWeight.w600, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                            SizedBox(
                              height: 10,
                            ),
                            Text(item.workEnd,
                              style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                                fontWeight: FontWeight.w600, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                            SizedBox(height: 10,),
                            Text(item.uploadedDate,
                              style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                                fontWeight: FontWeight.w600, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                            SizedBox(
                              height: 10,
                            ),
                            Text(item.country,
                              style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                                fontWeight: FontWeight.w600, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                            SizedBox(
                              height: 10,
                            ),
                            Text(item.state,
                              style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                                fontWeight: FontWeight.w600, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                            SizedBox(
                              height: 10,
                            ),
                            Text(item.railRoad,
                              style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                                fontWeight: FontWeight.w600, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                            SizedBox(
                              height: 10,
                            ),
                            Text('0',
                              style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                                fontWeight: FontWeight.w600, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: BorderSide(color: Color.fromRGBO(26, 179, 148, 1), width: 1),
                              ),
                              child: const Text('Read More',
                                style: TextStyle(color: Color.fromRGBO(26, 179, 148, 1), fontSize: 14,
                                    fontWeight: FontWeight.w600,letterSpacing: 1,fontFamily: 'WorkSans'),),
                            ),
                            SizedBox(
                              height: 10,
                            )

                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),

                      ],
                    ),

                    //isExpanded: item.isExpanded,
                    value: item.index,
                  );
                },).toList(),

              ),
            ),
          ],
        ),

      ),
    );
  }
}

class Item {
  Item({required this.createdDate,
    required this.workStart,
    required this.workEnd,
    required this.uploadedDate,
    required this.country,
    required this.state,
    required this.railRoad,
    required this.id,
    required this.index,
    this.isExpanded = false});
  String createdDate;
  String workStart;
  String workEnd;
  String id;
  int index;
  String uploadedDate;
  String country;
  String state;
  String railRoad;
  bool isExpanded;
}

String id = '16049';
String dateCreated = '05/09/2023 11:10:3';
class ActivityItem extends StatelessWidget {

  const ActivityItem({super.key,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        //Navigator.push(context, MaterialPageRoute(builder: (context) => updateActivity(data: dataToPass,)));
      },
      child: Card(
          elevation: 10,
          borderOnForeground: true,
          child:Container(
            margin: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ID',
                      style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 14,
                        fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Date Created',
                      style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 12,
                        fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),)
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(id,
                      style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                        fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                    SizedBox(
                      height: 10,
                    ),
                    Text(dateCreated,
                      style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 12,
                        fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),

                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Image.asset('assets/icons/profile/arrowright3.png'),
                  ],
                )

              ],
            ),
          )
      ),
    );
  }
}







