import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:friction/Strings.dart';
import 'package:friction/componants/Headline.dart';
import 'package:friction/componants/Scoreboard.dart';
import 'package:friction/componants/Checkin.dart';
import 'package:friction/componants/Footer.dart';
import 'package:friction/componants/checkin_list_view.dart';

class Activity extends StatelessWidget {
  const Activity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: const Color.fromRGBO(21, 134, 202, 1),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Image.asset('assets/icons/arrowright2.png'),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          title: Container(
        width: 180,
        child: Image.asset('assets/icons/logo.png'),
          ),

        centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(16, 16, 0, 0),
              child: Text('Create Activity',style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                fontWeight: FontWeight.w600, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),
              ),
            ),
            MyCustomForm()
          ],
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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Container(
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
              InputDropDownItem(hdText: '',
                            ldText: 'Select Service Tech*',
                            sdIconPath: 'assets/icons/profile/down.png',
                    ),
              InputDropDownItem(hdText: '',
                ldText: 'Select Work Start Date',
                sdIconPath: 'assets/icons/profile/down.png',
              ),
              InputDropDownItem(hdText: '',
                ldText: 'Select Work End Date Range',
                sdIconPath: 'assets/icons/profile/down.png',
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
              InputDropDownItem(hdText: 'Select Mile Post',
                ldText: 'Mile Post',
                sdIconPath: 'assets/icons/profile/down.png',
              ),
              InputDropDownItem(hdText: '',
                ldText: 'Select Helper',
                sdIconPath: 'assets/icons/profile/down.png',
              ),

                    Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
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
                return 'Please enter some text';
              }
              return null;
            },
            decoration: InputDecoration(
              //hintText: hdText,
              // suffix: Center(child: Image.asset(widget.sdIconPath)),
              labelText: widget.ldText,



              // filled: false,
            ),

          );
        },
            itemBuilder: (context, suggestion) {
            return Text(suggestion);
            },
            onSelected: (String value) {
              _typeAheadController.text = value;
              setState(() {

              });

            },
            suggestionsCallback: (String search) {
              return [
                'Flutter',
                'Dart',
                'Android',
                'iOS',
                'TypeScript',
                'JavaScript',
              ];
            },
          )


    );
  }
}






