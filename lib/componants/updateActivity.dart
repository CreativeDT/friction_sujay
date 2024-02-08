import 'dart:async';

import 'package:flutter/material.dart';
import 'package:friction/componants/ActivityData.dart';
import 'package:friction/componants/showActivity.dart';
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

class updateActivity extends StatelessWidget {
  final ActivityData data;
  const updateActivity({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(21, 134, 202, 1),
        title: Container(
          width: 180,
          child: Image.asset('assets/icons/logo.png'),
        ),

        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: MyCustomForm(dataForm: data,)
      ),
    );
  }
}
//ActivityData lastData = ActivityData();
String railUnitLocationId = "1";
class MyCustomForm extends StatefulWidget {
  final ActivityData dataForm;
   const MyCustomForm({super.key, required this.dataForm});

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
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 16, 0, 0),
                    child: Text('Edit Activity',style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                      fontWeight: FontWeight.w600, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(10.0),
                    decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black12,
                          width: 2,)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputDropDownItem(hdText: widget.dataForm.ServiceTechEmail!,
                          ldText: 'Select Service Tech*',
                          sdIconPath: 'assets/icons/profile/down.png',
                        ),
                        InputDropDownItem(hdText: widget.dataForm.EstimatedWorkStartDate!,
                          ldText: 'Select Est Work Start Date with time*',
                          sdIconPath: 'assets/icons/menu/Calendar.png',
                        ),
                        InputDropDownItem(hdText: widget.dataForm.EstimatedWorkEndDate!,
                          ldText: 'Select Est Work End Date with time*',
                          sdIconPath: 'assets/icons/menu/Calendar.png',
                        ),
                        InputDropDownItem(hdText: widget.dataForm.RailLocation!,
                          ldText: 'Select Rail Line',
                          sdIconPath: 'assets/icons/profile/down.png',
                        ),
                        InputDropDownItem(hdText: '',
                          ldText: 'Enter Division',
                          sdIconPath: 'assets/icons/profile/down.png',
                        ),
                        InputDropDownItem(hdText: '',
                          ldText: 'Enter Subdivision',
                          sdIconPath: 'assets/icons/profile/down.png',
                        ),
                        InputDropDownItem(hdText: '',
                          ldText: 'Mile Post',
                          sdIconPath: 'assets/icons/profile/down.png',
                        ),
                        InputDropDownItem(hdText: '',
                          ldText: 'Select Activity Type*',
                          sdIconPath: 'assets/icons/profile/down.png',
                        ),
                        InputDropDownItem(hdText: '',
                          ldText: 'Select Helper',
                          sdIconPath: 'assets/icons/profile/down.png',
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          height: 70,
                          width: 350,
                          color: Color.fromRGBO(245, 245, 245, 1),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 3,),
                              Row(mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 15,),
                                  Text('Helper Name',
                                    style: TextStyle(color: Color.fromRGBO(175, 175, 175, 1) , fontSize: 14,
                                      fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                                  SizedBox(width: 240,),
                                  Image.asset('assets/icons/menu/trash.png'),
                                ],
                              ),
                              SizedBox(height: 4,),
                              Row(mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 5,),
                                  Expanded(
                                    flex: 1,
                                    child: InputDropDownItem(hdText: '',
                                      ldText: 'Est Work Start D&T *',
                                      sdIconPath: 'assets/icons/menu/Calendar.png',
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: InputDropDownItem(hdText: '',
                                      ldText: 'Est Work Start D&T *',
                                      sdIconPath: 'assets/icons/menu/Calendar.png',
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                ],
                              ),
                            ],

                          ),
                        ),
                        InputDropDownItem(hdText: '',
                          ldText: 'Upload Image',
                          sdIconPath: 'assets/icons/menu/export.png',
                        ),
                        InputDropDownItem(hdText: '',
                          ldText: 'Priority',
                          sdIconPath: 'assets/icons/profile/down.png',
                        ),
                        InputDropDownItem(hdText: '',
                          ldText: 'Link Work Item',
                          sdIconPath: 'assets/icons/profile/down.png',
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                              },
                              child: const Text('Cancel'),
                            ),
                            SizedBox(width: 10,),

                            ElevatedButton(
                              onPressed: () {
                                showBlueWidget = false;
                                showRedWidget = false;
                                if (_formKey.currentState!.validate()) {
                                  updateActivity();
                                  setState(() {

                                  });
                                  /*ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Processing Data')),
                                  );*/
                                }
                              },
                              child: const Text('Update Activity'),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 2,
                top: 2,

                child: Visibility(
                  visible: showBlueWidget,
                  child: Container(
                    decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blueAccent
                    ),
                    padding: EdgeInsets.all(5.0),
                    alignment: Alignment.topRight,
                    width: 275,
                    height: 40,
                    //color: Colors.green,
                    child: Center(
                      child: Text('Activity ID- ${dataToPass.ActivityTypeSerialId} updated successfully.',
                          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1) , fontSize: 12,
                            fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',)),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 2,
                top: 2,

                child: Visibility(
                  visible: showRedWidget,
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    alignment: Alignment.topRight,
                    width: 275,
                    height: 38,
                    //color: Colors.redAccent,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.redAccent
                    ),
                    child: Center(
                      child: Text('Activity ID- ${dataToPass.ActivityTypeSerialId} update failed.',
                          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1) , fontSize: 12,
                            fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',)),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  updateActivity() async {
    String? token = await SharedPreference().getStringFromSharedPreferences("token");
    print(token);
    //const String tocken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNhbmRlZXAua2lyYW5AZ2xvYmFsLWNzZy5jb20iLCJpYXQiOjE3MDU1NjA5NzN9.jVqyyJw6gcLJJCS554HwOHOAPtfZ1Ve3jnv5LMEnNEQ";
    //const String API_URL = "http://172.16.116.65:8001/api/v1/user/user-login";
    final Uri uri = Uri.parse(ApiStrings.baseUrl+ ApiStrings.endpoint_update_activity);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
     Map<String, dynamic> body = {
      "activityId": 1,
      "estimatedWorkStartDate": "12/03/2023 11:03:10",
      "estimatedWorkEndDate": "13/03/2023 13:03:10",
      "actualWorkStartDate": "12/03/2023 11:03:10",
      "actualWorkEndDate": "13/03/2023 13:03:10",
      "isAmended": true,
      "actualWorkStartLat": "41.74585",
      "actualWorkStartLong": "-88.34061",
      "actualEndWorkLat": "-88.34061",
      "actualWorkEndLong": "-88.34061",
      "truckId": "1245",
      "mileageStart": "4321",
      "mileageEnd": "4521",
      "serviceTechId": "1",
      "railUnitLocationId": railUnitLocationId,
      "activityTypeId": "1",
      "activityStatusId": "1",
      "createdById": "1"
    };
    //Uri.parse(API_URL)
    http.Response response = await http.put(uri,
        headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body)["Friction"];
      print("Response Success");
      print(response.statusCode);
      print(data["message"]);
      setState(() {
        showBlueWidget = true;
      });
      startTimer(2);
    } else {
      print(response.statusCode);
      print("Response Failure");
      setState(() {
        showRedWidget = true;
      });
      startTimer(2);
    }
  }
  void startTimer(int seconds) {
    Duration duration = Duration(seconds: seconds);
    Timer timer = Timer(duration, onEnd);
  }

  void onEnd() {
    setState(() {
      showBlueWidget = false;
      showRedWidget = false;
    });
    // This is the callback function that executes when the timer ends.
    print('Timer has ended!');
  }
}

class InputItem extends StatelessWidget {
  final String hText;
  final String lText;
  final String sIconPath ;
  const InputItem({super.key, required this.hText, required this.lText, required this.sIconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.0),
      height: 33,
      child: TextFormField(
        // The validator receives the text that the user has entered.
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: hText,
          suffix: Center(child: Image.asset(sIconPath)),
          labelText: lText,



          // filled: false,
        ),

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
  void initState() {
    _typeAheadController.text = widget.hdText;
    /*if(widget.ldText == 'Select Service Tech*') {
      _typeAheadController.text = widget.hdText;
    }*/
    super.initState();
  }
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
            if(widget.ldText == 'Select Rail Line'){
              railUnitLocationId = _typeAheadController.text;
            }
            // if(widget.ldText == 'Select Service Tech*'){
            //   _typeAheadController.text = 'james.j.gantzer@loram.com';
            //
            // }
            setState(() {
            });

          },
          suggestionsCallback: (String search) {
            return [
              '1',
              '2',
              '3',
              'a'
            ];
          },
        )


    );
  }
}


class activityData {
  int _serviceTech=1;
  int _railLine=1;

  activityData();

  int get serviceTech => _serviceTech;

  set serviceTech(int value) {
    _serviceTech = value;
  }

  int get railLine => _railLine;

  set railLine(int value) {
    _railLine = value;
  }
}






