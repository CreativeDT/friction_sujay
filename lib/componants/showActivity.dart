import 'package:flutter/material.dart';
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
  activityData activitydata = activityData();

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
                        ActivityItem()

                      ],
                    ),

              ),

        ),
      );
  }

  showActivityActivity() async {
    String? token = await SharedPreference().getStringFromSharedPreferences("token");
    print(token);
    //const String tocken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNhbmRlZXAua2lyYW5AZ2xvYmFsLWNzZy5jb20iLCJpYXQiOjE3MDU1NjA5NzN9.jVqyyJw6gcLJJCS554HwOHOAPtfZ1Ve3jnv5LMEnNEQ";
    //const String API_URL = "http://172.16.116.65:8001/api/v1/user/user-login";
    final Uri uri = Uri.parse(ApiStrings.baseUrl+ ApiStrings.endpoint_create_activity);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    const Map<String, String> body = {

      "estimatedWorkStartDate": "16/03/2024 11:03:10",
      "estimatedWorkEndDate": "16/03/2024 13:03:10",
      "actualWorkStartDate": "16/03/2024 11:03:10",
      "actualWorkEndDate": "16/03/2024 13:03:10",
      "actualWorkStartLat": "41.74585",
      "actualWorkStartLong": "-88.34061",
      "actualEndWorkLat": "-88.34061",
      "actualWorkEndLong": "-88.34061",
      "truckId": "1245",
      "mileageStart": "4321",
      "mileageEnd": "4521",
      "serviceTechId": "1",
      "railUnitLocationId": "1",
      "activityTypeId": "1",
      "activityStatusId": "1",
      "createdById": "1"
    };
    //Uri.parse(API_URL)
    http.Response response = await http.post(uri,
        headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body)["Friction"];
      print("Response Success");
      print(response.statusCode);
      print(data["message"]);
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => updateActivity()));
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
                    Text(idText,
                      style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                        fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                    SizedBox(
                      height: 10,
                    ),
                    Text(serviceText,
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






