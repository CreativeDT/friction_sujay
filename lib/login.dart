import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:friction/ApiStrings.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:friction/Strings.dart';
import 'package:friction/componants/checkin_list_view.dart';
import 'package:friction/componants/SharedPreference.dart';
import 'package:friction/home.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          elevation: 0,
        ),
        backgroundColor: const Color.fromRGBO(21, 134, 202, 1),
        body: SingleChildScrollView(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(0),
                  child: Stack(
                    children: <Widget>[
                      const Positioned(
                          top: -240,
                          left: -196,
                        child: HalfWhiteCircle()
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                              child: Image.asset('assets/icons/logo.png'),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(28, 100, 19, 20),
                              child: const Text(Strings.appName,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1) , fontSize: 32,
                                    fontWeight: FontWeight.w700, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',
                                  shadows: [
                                  Shadow(
                                  blurRadius:5.0,  // shadow blur
                                  color: Colors.white, // shadow color
                                  offset: Offset(0.5,0.5), // how much shadow will be shown
                                ),
                                ],
                              ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(0, 60, 0, 50),
                              child: const Text(Strings.login,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1), fontSize: 24,
                                    fontWeight: FontWeight.w700,letterSpacing: 1.12,fontFamily: 'WorkSans',
                                  shadows: [
                                    Shadow(
                                      blurRadius:10.0,  // shadow blur
                                      color: Colors.black, // shadow color
                                      offset: Offset(2.0,2.0), // how much shadow will be shown
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Container(
                              width: 380,
                              height: 50,
                              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 10,

                                  backgroundColor: Colors.white, // background
                                ),
                                onPressed: () {
                                  //fetchDataWithParameters('s');
                                  loginMicrosoft();

                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Image.asset('assets/icons/microsoft.png'),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        child: const Text(Strings.loginButton,
                                          style: TextStyle(color: Color.fromRGBO(26, 179, 148, 1), fontSize: 16,
                                            fontWeight: FontWeight.w700,letterSpacing: 1,fontFamily: 'WorkSans',
                                          ),
                                      )
                                      )
                                    ]
                                )
                              ),

                            ),
                          ]
                      ),
                    ],
                  )
              ),
            ],
          ),
        )
    );
  }

  Future<void> fetchDataWithParameters(String emailT) async {
    //final String baseUrl = '172.16.116.221:8080';
    //final String endpoint = '/acetaxi/driver/login';// Replace with your API URL
    final String apiUrl = 'https://172.16.116.65:8001/api/v1/user/user-login';
    final Map<String, String> parameters = {
      "email": "sandeep.kiran@global-csg.com"
    };
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
    final Uri uri = Uri.http(ApiStrings.baseUrl, ApiStrings.endpiont_login);
  //Uri.parse(apiUrl)
    http.Response response = await http.post(uri, headers: headers,body: jsonEncode(parameters));
    //final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON data.
      final data = json.decode(response.body);
      // Process the data here.
      print(response.statusCode);
      print(data);
      //Fluttertoast.showToast(msg: data);
    } else {
      // If the server did not return a 200 OK response, throw an exception or handle the error accordingly.
      print(response.statusCode);
      //Fluttertoast.showToast(msg: response.statusCode.toString());
    }
  }

  loginMicrosoft() async {
    //const String API_URL = "http://172.16.116.65:8001/api/v1/user/user-login";
    final Uri uri = Uri.parse(ApiStrings.baseUrl+ ApiStrings.endpiont_login);
    const Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    const Map<String, String> body = {
      "email": "sandeep.kiran@global-csg.com",
    };
    //Uri.parse(API_URL)
    http.Response response = await http.post(uri,
        headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body)["Friction"];
      print("Response Success");
      print(response.statusCode);
      print(data["token"]);
      SharedPreference().saveStringToSharedPreferences("token", data["token"]);

      print("from shared prefrence: ${SharedPreference().getStringFromSharedPreferences("token")}");
    } else {
      print("Response Failure");
    }
  }

}
class HalfWhiteCircle extends StatelessWidget {
  const HalfWhiteCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*2, // Adjust the size of the circle as needed
      height: 400,
      decoration: const BoxDecoration(
        color: Colors.white, // Set your desired background color
        shape: BoxShape.circle,
      ),

    );
  }
}