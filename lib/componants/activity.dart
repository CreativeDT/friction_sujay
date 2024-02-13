//import 'dart:ffi';

import 'dart:async';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:friction/componants/ActivityData.dart';
import 'package:friction/data/ApiService.dart';
import 'package:friction/data/model/RailLocationData.dart';
import 'package:friction/data/model/ServiceTechData.dart';
import 'package:friction/data/model/activityRequestData.dart';
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
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class Activity extends StatelessWidget {
  ActivityData? activityData;
   Activity({super.key, this.activityData });

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
        body: Container(
          child: MyCustomForm()
          ),
        );
  }
}

String  serviceTechId = "1";
String railUnitLocationId = "1";
String activityTypeId = "1";
String activityStatusId = "1";
String createdById = "1";
ActivityRequestData _activityRequestData = ActivityRequestData();
ApiService apiService = ApiService();
List<String> suggestionList = [];
List<String> serviceTechSuggestion = [];
List<String> railLineSuggestion = [];
List<String> divisionSuggestion = [];
List<String> subdivisionSuggestion = [];
List<String> milePostSuggetion = [];

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  bool showGreenWidget = false;
  bool showRedWidget = false;
  final _formKey = GlobalKey<FormState>();
  //TextEditingController serviceTechIdController = TextEditingController();
 // TextEditingController railUnitLocationIdController = TextEditingController();
 @override
  void initState() {
    fetchAllSuggestion();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(16, 16, 0, 0),
                          child: Text('Create Activity',style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                            fontWeight: FontWeight.w600, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black12,
                                width: 2,)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InputDropDownItem(hdText: '',
                                ldText: 'Select Service Tech*',
                                sdIconPath: 'assets/icons/profile/down.png',
                              ),
                              CustomDropDown(),
                              InputDropDownItem(hdText: '',
                                ldText: 'Select Est Work Start Date with time*',
                                sdIconPath: 'assets/icons/menu/Calendar.png',
                              ),
                              InputDropDownItem(hdText: '',
                                ldText: 'Select Est Work End Date with time*',
                                sdIconPath: 'assets/icons/menu/Calendar.png',
                              ),
                              InputDropDownItem(hdText: '',
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
                                width: 400,
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
                                  SizedBox(width: 10,),
                                  Expanded(
                                    flex: 1,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        side: BorderSide(color: Color.fromRGBO(26, 179, 148, 1), width: 1),
                                      ),
                                      child: const Text('Cancel',
                                        style: TextStyle(color: Color.fromRGBO(26, 179, 148, 1), fontSize: 14,
                                            fontWeight: FontWeight.w600,letterSpacing: 1,fontFamily: 'WorkSans'),),
                                    ),

                                  ),

                                  SizedBox(width: 10,),

                                  Expanded(
                                    flex: 1,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        showGreenWidget = false;
                                        showRedWidget = false;
                                        if (_formKey.currentState!.validate() == false) {
                                          addActivity();
                                          setState(() {
                                          });
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color.fromRGBO(26, 179, 148, 1),
                                        foregroundColor: Colors.white,
                                        side: BorderSide(color: Color.fromRGBO(26, 179, 148, 1), width: 5),
                                      ),

                                      child: const Text('Create Activity',
                                        style: TextStyle(color: Colors.white, fontSize: 14,
                                            fontWeight: FontWeight.w600,letterSpacing: 1,fontFamily: 'WorkSans'),),
                                    ),
                                  ),
                                  SizedBox(width: 10,),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ),
          ),
          Positioned(
            right: 2,
            top: 2,

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
                  child: Text('Activity created successfully, '
                      'please refer Activity list to start work',
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
                  child: Text('Failed to create Activity, Please Try Again',
                      style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1) , fontSize: 12,
                        fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',)),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

addActivity() async {
    apiService.addActivity(_activityRequestData).then((response){
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body)["Friction"];
        print("Response Success");
        print(response.statusCode);
        print(data["message"]);
        print(data["data"]);
        SharedPreference().saveStringToSharedPreferences("activityId", data["data"]["ActivityTypeSerialId"]);
        setState(() {
          showGreenWidget = true;
        });
        startTimer(3);

      } else {
        print("Response Failure");
        setState(() {
          showRedWidget = true;
        });
        startTimer(3);
      }

    });
}
  void startTimer(int seconds) {
    Duration duration = Duration(seconds: seconds);
    Timer timer = Timer(duration, onEnd);
  }

  void onEnd() {
    setState(() {
      showGreenWidget = false;
      showRedWidget = false;
    });
    // This is the callback function that executes when the timer ends.
    print('Timer has ended!');
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
  DateTime selectedDate = DateTime.now();
  final TextEditingController _typeAheadController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 33,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 14),
      child: TypeAheadField<String>(
        controller: _typeAheadController,
        hideWithKeyboard: false,
        hideOnUnfocus: true,
        showOnFocus: widget.sdIconPath=='assets/icons/menu/Calendar.png'?false:true,
        builder: (context, controller, focusNode) {
          //FocusManager.instance.primaryFocus?.unfocus();
          print(controller.text);
          setInputData(widget.ldText, _typeAheadController);
          return TextFormField(
            controller: controller,
            focusNode: focusNode,
            onChanged: (value){
              //SystemChannels.textInput.invokeMethod('TextInput.hide');

            },

            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                String error =  'Please enter some text';
                return error;
              }
              return null;
            },
            decoration: InputDecoration(
              isDense: false,
              contentPadding:
              const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
              //hintText: widget.hdText,
              suffixIcon:  Image.asset(widget.sdIconPath),
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
            onTap:() {
              // if (FocusScope.of(context).hasPrimaryFocus) {
              //   FocusScope.of(context).unfocus();
              // }
              if(widget.sdIconPath == 'assets/icons/menu/Calendar.png'){

                showOmniDateTimePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                  is24HourMode: false,
                  isShowSeconds: false,
                  minutesInterval: 1,
                  secondsInterval: 1,
                  borderRadius: const BorderRadius.all(Radius.circular(2)),
                  constraints: const BoxConstraints(
                    maxWidth: 350,
                    maxHeight: 600,
                  ),
                  transitionBuilder: (context, anim1, anim2, child) {
                    return FadeTransition(
                        opacity: anim1.drive(
                      Tween(
                        begin: 0,
                        end: 1,
                      ),
                    ),
                      child: child,
                    );
                  },
                    transitionDuration: const Duration(milliseconds: 200),
              barrierDismissible: true,
                ).then((value) => {
                  if (value != null && value != selectedDate){
                    setState((){
                      selectedDate = value;
                      _typeAheadController.text = '${selectedDate.toLocal()}';
                })
                  }
                });


              }

            },
          );
        },
        itemBuilder: (context, suggestion) {
            return Text(suggestion);
            },
        onSelected: (String value) {
              FocusScope.of(context).unfocus();
              _typeAheadController.text = value;
              setState(() {});
            },
        suggestionsCallback: (String search) {
          List<String> suggestions =[];
          var itemSuggetionList = setSuggestion(widget.ldText);
          print(itemSuggetionList.toString());
          suggestions.addAll(itemSuggetionList);

          /*if(widget.ldText== 'Select Rail Line'){
           suggestions = createSuggestion(widget.ldText);
           setState(() {
           });
          }else{
            suggestions = createSuggestion(widget.ldText);
          }*/

          //List<String> suggestions = fetchSuggestion(widget.ldText);
              return suggestions;
              /*['1','2','3','4','5','a'];*/
            },
          )


    );
  }

   setInputData(String ldText, TextEditingController typeAheadController) {
    switch(ldText){
      case 'Select Service Tech*':
        _activityRequestData.serviceTechId = typeAheadController.text;
      case 'Select Est Work Start Date with time*':
        _activityRequestData.estimatedWorkStartDate = typeAheadController.text;
      case 'Select Est Work End Date with time*':
        _activityRequestData.estimatedWorkEndDate = typeAheadController.text;
      case 'Select Rail Line':
        _activityRequestData.railUnitLocationId = typeAheadController.text;
      case 'Select Activity Type*':
      _activityRequestData.activityTypeId = typeAheadController.text;
      default:
        break;

    }

  }
}

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({Key? key}) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              'Select Item',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: items
                .map((String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ))
                .toList(),
            value: selectedValue,
            onChanged: (String? value) {
              setState(() {
                selectedValue = value;
              });
            },
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 40,
              width: 140,
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
          ),
        ),
      );
  }
}


/*createSuggestion (String ltext){
  int n = 5;
  switch(ltext){
    case 'Select Service Tech*':
             n = 10;
    case 'Activity Type Id*':
       n= 5;
    case 'Select Rail Line':
       n=3;
    default :
      n=5;

  }

    for (var i = 1; i <= n; i++) {
      suggestionList.add(i.toString());
    }
  if(ltext == 'Select Rail Line') {
    suggestionList.add("a");
  }

  return suggestionList;

}*/

setSuggestion (var ldtext,){
  switch(ldtext){
    case 'Select Service Tech*':
      return serviceTechSuggestion;
    case 'Select Rail Line':
      return railLineSuggestion;
    case 'Enter Division':
      return divisionSuggestion;
    case 'Enter Subdivision':
      return subdivisionSuggestion;
    case 'Mile Post':
      return milePostSuggetion;
      default:
        return ['1','2','3','a'];
  }
}
fetchAllSuggestion () {
  print("fetchAllSuggestion called");
  fetchServiceTechSuggestion();
  fetchRailLineSuggestion();
}
fetchServiceTechSuggestion () {
  serviceTechSuggestion.clear();
  List<ServiceTechData> serviceTechList = [];
  Set<String> serviceList ={} ;
  apiService.getServiceTech().then((data){
    for(var value in data){
      serviceTechList.add(ServiceTechData.fromJson(value));
    }
    for (var item in serviceTechList){
      serviceList.add(item.ServiceTechEmail.toString());
    }
    serviceTechSuggestion.addAll(serviceList.toList());
  }

  );

  
}
fetchRailLineSuggestion () {
  railLineSuggestion.clear();
  divisionSuggestion.clear();
  milePostSuggetion.clear();
  subdivisionSuggestion.clear();

  Set<String> divisionList ={} ;
  Set<String> subdivisionList ={} ;
  Set<String> milePostList = {};
  List<RailLocationData> railLocationList = [];
  apiService.getRailUnitLocations().then((data){
    for(var data in data){
      railLocationList.add(RailLocationData.fromJson(data));
    }
    for (var item in railLocationList){
      railLineSuggestion.add(item.RailUnitLocationId.toString());
      divisionList.add(item.Division.toString());
      subdivisionList.add(item.SubDivision.toString());
      milePostList.add(item.MilePost.toString());
    }
    divisionSuggestion.addAll(divisionList.toList());
    subdivisionSuggestion.addAll(subdivisionList.toList());
    milePostSuggetion.addAll(milePostList.toList());

    print(railLocationList.toString());
    print(divisionSuggestion.toString());
    print(subdivisionSuggestion.toString());
  });

}









