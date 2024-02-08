import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:friction/componants/ActivityData.dart';
import 'package:friction/componants/DownloadCenter.dart';
import 'package:friction/componants/updateActivity.dart';
import 'dart:convert';
import 'package:friction/ApiStrings.dart';
import 'package:friction/componants/SharedPreference.dart';
import 'package:http/http.dart' as http;

List<ActivityData> activityDataList = [];
String? lastCreatedActivityId = "10036";
String lastCreatedServiceId = "";
String lastCreatedActivityEmail = "";
ActivityData dataToPass = ActivityData();
DownloadCenter downloadCenter = DownloadCenter();
Set<int> expandedTiles = {};
ValueNotifier<bool> showHeader = ValueNotifier<bool>(true);

class showActivity extends StatelessWidget {
  const showActivity({super.key});

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
          child: MyCustomForm()
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}
class MyCustomFormState extends State<MyCustomForm> {
  bool showBlueWidget = false;
  bool showRedWidget = false;

  @override
  void initState() {
    showActivity();
    expandedTiles.clear();
    showHeader.value = true;
    print("from init of form $showHeader");
    print(expandedTiles.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ValueListenableBuilder<bool>(
                        // Listen to changes in _isToggled.value
                        valueListenable: showHeader,
                        builder: (context, value, child) {
                          // Rebuild the widget when _isToggled.value changes
                          return  Visibility(
                            visible: value,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: ElevatedButton(

                                      onPressed: (){
                                        downloadCenter.activityDownload(activityDataList);

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
                          );
                        },
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: generateCardList(10),
                      )



                    ],
                  ),

            ),

      );
  }
  List<Widget> generateCardList(int count) {
    List<ActivityCard> cardList = [];
    for(var data in activityDataList){
      cardList.add(ActivityCard(itemData: data));
    }
    return cardList;
  }

  showActivity() async {
    String? token = await SharedPreference().getStringFromSharedPreferences("token");
    print(token);
    //const String tocken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNhbmRlZXAua2lyYW5AZ2xvYmFsLWNzZy5jb20iLCJpYXQiOjE3MDU1NjA5NzN9.jVqyyJw6gcLJJCS554HwOHOAPtfZ1Ve3jnv5LMEnNEQ";
    //const String API_URL = "http://172.16.116.65:8001/api/v1/user/user-login";
    final Uri uri = Uri.parse(ApiStrings.baseUrl+ ApiStrings.endpoint_get_all_activity);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    const Map<String, dynamic> body = {
      "pageNumber": 1,
      "limit": 100
    };
    http.Response response = await http.put(uri,
        headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body)["Friction"];
      print("Response Success");
      print(response.statusCode);
      print(data["message"]);
      //print(data["data"]);
      //print(data[0]);

      for(var data in data["data"]){
        activityDataList.add(ActivityData.fromJson(data));
      }
      //print(activityDataList.toString());
      /*for(var value in activityDataList) {
        var items = ItemData(ID: value.ActivityTypeSerialId.toString(),
          serviceTech: value.ServiceTechEmail.toString(),
          activityType: value.ActivityType.toString(),);

          print(items.toString());

      *//* itemList.add(ItemData(ID: value.ActivityTypeSerialId.toString(),
       serviceTech: value.ServiceTechEmail.toString(),
         activityType: value.ActivityType.toString(),
       ));
       //itemList.add(item);*//*

      }*/
      /*{
        lastCreatedServiceId = activityDataList[0].ActivityTypeSerialId;
        lastCreatedActivityEmail = activityDataList[0].ServiceTechEmail;
      }*/
      setState(() {
      });
      print ("activityDataList" + activityDataList.toString());
      //print("itemList:" + itemList.toString() );
    } else {
      print("Response Failure");
    }
  }
}

class ActivityCard extends StatefulWidget {
  final String idText;
  final String serviceText;
  final ActivityData itemData;
  const ActivityCard({Key? key, this.idText = '965891', this.serviceText = 'james.j.gantzer@loram.com', required this.itemData}) : super(key: key);

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}
class _ActivityCardState extends State<ActivityCard> {

  bool showEdit = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.only(
            top: 6.0, left: 0.0, right: 0.0, bottom: 0.0),
        child: ExpansionTile(
          childrenPadding: EdgeInsets.only(left: 5),
          onExpansionChanged: (value){
            showEdit = !showEdit;
            if (value) {
              expandedTiles.add(widget.itemData.ActivityId);
            } else {
              expandedTiles.remove(widget.itemData.ActivityId);
            }
            if(expandedTiles.isEmpty){
              setState(() {
                showHeader.value = true;
              });
            } else {
              setState(() {
                showHeader.value = false;
              });
            }
            print(showHeader);
            print(expandedTiles.toString());

          },
          title: Container(
            margin: EdgeInsets.all(0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 10,),
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
                    Visibility(
                      visible: showEdit,
                      child: Row(
                        children: [
                          SizedBox(width: 50,height: 50,),

                        ],
                      ),
                    ),
                    Text('Service Tech',
                      style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 12,
                        fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),)
                  ],
                ),
                SizedBox(
                  width: 40,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.itemData.ActivityTypeSerialId! ,
                      style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                        fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: showEdit,
                      child: Column(
                        children: [
                          Container(
                            height: 26,
                            width: 175,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      //Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
                                      backgroundColor: Color.fromRGBO(26, 179, 148, 1),
                                      side: BorderSide(color: Color.fromRGBO(26, 179, 148, 1), width: 1),
                                    ),
                                    child: const Text('Work Start',
                                      style: TextStyle(color: Colors.white, fontSize: 12,
                                          fontWeight: FontWeight.w600,letterSpacing: 0,fontFamily: 'WorkSans'),),
                                  ),

                                ),
                                SizedBox(width: 5,),
                                Expanded(
                                  flex: 1,
                                  child: ElevatedButton(

                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => updateActivity(data: widget.itemData,)));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
                                      backgroundColor: Colors.white,
                                      side: BorderSide(color: Color.fromRGBO(26, 179, 148, 1),
                                          width: 1),
                                    ),
                                    child:  Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/icons/edit2.png'),
                                        SizedBox(width: 15,),

                                        Text('Edit',
                                          style: TextStyle(color: Color.fromRGBO(26, 179, 148, 1), fontSize: 12,
                                              fontWeight: FontWeight.w400,letterSpacing: 0,fontFamily: 'WorkSans'),),
                                      ],
                                    ),
                                  ),

                                ),

                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                        ],
                      ),

                    ),

                    Text(widget.itemData.ServiceTechEmail!,
                      style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 12,
                        fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),

                  ],
                ),



              ],
            ),
          ),
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Helper Name',
                        style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 12,
                          fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Activity type',
                        style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 12,
                          fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Activity Status',
                        style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 12,
                          fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quincy',
                        style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 12,
                          fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Off Track Work',
                        style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 12,
                          fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                      SizedBox(height: 10,),
                      Image.asset('assets/icons/ns.png'),

                    ],
                  ),


                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: ElevatedButton(
                      onPressed: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Color.fromRGBO(26, 179, 148, 1), width: 1),
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Upload Image',
                            style: TextStyle(color: Color.fromRGBO(26, 179, 148, 1), fontSize: 12,
                                fontWeight: FontWeight.w600,letterSpacing: 0,fontFamily: 'WorkSans'),),
                          SizedBox(width: 5,),
                          Image.asset('assets/icons/export.png'),
                        ],
                      ),
                    ),

                  ),
                  SizedBox(width: 5,),
                  Expanded(
                    flex: 6,
                    child: ElevatedButton(
                      onPressed: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Color.fromRGBO(26, 179, 148, 1), width: 1),
                      ),
                      child: const Text('Add Resources',
                        style: TextStyle(color: Color.fromRGBO(26, 179, 148, 1), fontSize: 12,
                            fontWeight: FontWeight.w600,letterSpacing: 0,fontFamily: 'WorkSans'),),
                    ),

                  ),
                  SizedBox(width: 5,),
                  Expanded(
                    flex: 4,
                    child: ElevatedButton(

                      onPressed: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Color.fromRGBO(26, 179, 148, 1),
                            width: 1),
                      ),
                      child: const Text('Read More',
                        style: TextStyle(color: Color.fromRGBO(26, 179, 148, 1), fontSize: 12,
                            fontWeight: FontWeight.w600,letterSpacing: 0,fontFamily: 'WorkSans'),),
                    ),

                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}










