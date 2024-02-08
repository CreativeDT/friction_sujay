import 'package:flutter/material.dart';
import 'package:friction/componants/ActivityData.dart';
import 'package:friction/componants/DownloadCenter.dart';
import 'package:friction/componants/updateActivity.dart';
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

List<ActivityData> activityDataList = [];
String? lastCreatedActivityId = "10036";
    //await SharedPreference().getStringFromSharedPreferences("token");
String lastCreatedServiceId = "";
String lastCreatedActivityEmail = "";
ActivityData dataToPass = ActivityData();
DownloadCenter downloadCenter = DownloadCenter();


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
  final _formKey = GlobalKey<FormState>();
  //activityData activitydata = activityData();

  @override
  void initState() {
    setActivity();
    showActivity();
    super.initState();
  }
  setActivity() async {
     lastCreatedActivityId = await SharedPreference().getStringFromSharedPreferences("activityId");
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child:

                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
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
                        ActivityItem()

                      ],
                    ),

              ),

        ),
      );
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
    //Uri.parse(API_URL)
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
      for(var data in activityDataList) {
        if(lastCreatedActivityId != null) {
          if (data.ActivityTypeSerialId == lastCreatedActivityId) {
            lastCreatedServiceId = data.ActivityTypeSerialId!;
            lastCreatedActivityEmail = data.ServiceTechEmail!;
            dataToPass = data;
          }
        }
        print("activityData:" + data.toString() );
      }
      /*{
        lastCreatedServiceId = activityDataList[0].ActivityTypeSerialId;
        lastCreatedActivityEmail = activityDataList[0].ServiceTechEmail;
      }*/
      setState(() {
        showBlueWidget = true;
      });
    } else {
      print("Response Failure");
      setState(() {
        showRedWidget = true;
      });
    }
  }
}

class ActivityItem extends StatelessWidget {
  final String idText;
  final String serviceText;
  const ActivityItem({super.key,this.idText = '96589', this.serviceText = 'james.j.gantzer@loram.com' });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => updateActivity(data: dataToPass,)));
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
                    Text('Service Tech',
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
                    Text(lastCreatedServiceId.isNotEmpty ? lastCreatedServiceId :
                      idText,
                      style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                        fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                    SizedBox(
                      height: 10,
                    ),
                    Text(lastCreatedActivityEmail.isNotEmpty ? lastCreatedActivityEmail :
                      serviceText,
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

class InputDropDownItem extends StatefulWidget {
  final String hdText;
  final String ldText;
  final String sdIconPath ;

  InputDropDownItem({super.key, required this.hdText, required this.ldText, required this.sdIconPath});

  @override
  State<InputDropDownItem> createState() => _InputDropDownItemState();
}

class _InputDropDownItemState extends State<InputDropDownItem> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _typeAheadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 33,
        margin: EdgeInsets.only(bottom: 14.0),
        child: TypeAheadField<String>(
          controller: _typeAheadController,
          hideWithKeyboard: false,
          builder: (context, controller, focusNode) {
            print(controller.text);
            return TextFormField(
              controller: controller,
              focusNode: focusNode,

              // The validator receives the text that the user has entered.

              validator: (value) {
                if (value == null || value.isEmpty) {
                  String error =  'Please enter some text';
                  return error;
                }
                return null;
              },
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                //hintText: widget.hdText,
                // suffix: Center(child: Image.asset(widget.sdIconPath)),
                labelText: widget.ldText,
                errorMaxLines: 1,
                // error: ,
                errorStyle: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'WorkSans',
                  height: 0.1,
                  textBaseline: TextBaseline.alphabetic,
                ),
              ),

            );
          },
          itemBuilder: (context, suggestion) {
            return Text(suggestion);
          },
          onSelected: (String value) {
            _typeAheadController.text = value;
            if(widget.ldText == 'Select Service Tech*'){

            }
            setState(() {});

          },
          suggestionsCallback: (String search) {
            return [
              '1',
              '2',
              '3',
              '4',
              '5',
            ];
          },
        )


    );
  }
}









