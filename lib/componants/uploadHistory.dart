import 'package:flutter/material.dart';
import 'package:friction/componants/ActivityData.dart';
import 'package:friction/componants/updateActivity.dart';
import 'package:friction/data/ApiService.dart';
import 'package:friction/data/model/UploadHistoryData.dart';
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

class uploadHistory extends StatelessWidget {
  const uploadHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(21, 134, 202, 1),
        title: Text('Upload History',
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
List<UploadHistoryData> uploadHistoryList = [];
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
    print("init started");
    items.clear();
    uploadHistoryList.clear();
    apiService.getUploadHistory().then((data){
      for(var data in data){
        uploadHistoryList.add(UploadHistoryData.fromJson(data));
      }
      setState(() {
        uploadTime = uploadHistoryList[0].UploadedDateTime;
        userName = uploadHistoryList[0].ActivitySerialId.toString();

        for(var i=0; i<= uploadHistoryList.length-1; i++){
          var data = uploadHistoryList[i];
          var item = Item(uploadDate: data.UploadedDateTime,
              userName: data.ServiceTechEmail.toString(),
              uploadType: data.UploadType.toString(),
              id: data.ActivitySerialId.toString());
          items.add(item);
        }
        print(items.toString());

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              border: Border.all(
                color: Colors.black12,
                width: 2,)),

          child:ExpansionPanelList(
              elevation: 4,
              expandedHeaderPadding: EdgeInsets.all(0),
              dividerColor: Colors.grey,


              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  items[previousIndex].isExpanded = false;
                  isExpanded = items[index].isExpanded;
                items[index].isExpanded = !isExpanded;
                previousIndex = index;

                });
              },
              children:items.map<ExpansionPanel>((Item item){
                return ExpansionPanel(
                  canTapOnHeader: true,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                  title: Container(
                    margin: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Upload Date',
                              style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 14,
                                fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                            SizedBox(
                              height: 10,
                            ),
                            Text('User Name',
                              style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 14,
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
                            Text(item.uploadDate,
                              style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                                fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                            SizedBox(
                              height: 10,
                            ),
                            Text(item.userName,
                              style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                                fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),

                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
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
                        Text('ID',
                          style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 14,
                            fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Upload Type',
                          style:TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 14,
                            fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                        SizedBox(height: 10,),
                        Text('Successful',
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
                        Text(item.uploadDate,
                          style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                            fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                        SizedBox(
                          height: 10,
                        ),
                        Text(item.uploadType,
                          style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                            fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                        SizedBox(height: 10,),
                        Text('Yes',
                          style: TextStyle(color: Color.fromRGBO(9, 137, 7, 1) , fontSize: 14,
                            fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                        SizedBox(
                          height: 10,
                        ),

                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                isExpanded: item.isExpanded,
                );
                },).toList(),

        ),
      ),
      ));
  }
}
class Item {
  Item({required this.uploadDate,
    required this.userName,
    required this.uploadType,
    required this.id,
    this.isExpanded = false});

  String uploadDate;
  String userName;
  String id;
  String uploadType;
  bool isExpanded;
}

String uploadTime = '5/11/2023 9:25:37 PM';
String userName = 'Twin Cities';
class ActivityItem extends StatelessWidget {

  const ActivityItem({super.key,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        //Navigator.push(context, MaterialPageRoute(builder: (context) => updateActivity(data: dataToPass,)));
      },
      child: ExpansionTile(
        
        title: Text("sujay"),

        children: [
          Card(
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
                        Text('Upload Date',
                          style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 14,
                            fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                        SizedBox(
                          height: 10,
                        ),
                        Text('User Name',
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
                        Text(uploadTime,
                          style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                            fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                        SizedBox(
                          height: 10,
                        ),
                        Text(userName,
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
          )
        ],
      ),
    );
  }
}







