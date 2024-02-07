


import 'dart:convert';

import 'package:friction/ApiStrings.dart';
import 'package:friction/componants/sharedPreference.dart';
import 'package:friction/data/model/UserProfile.dart';
import 'package:friction/data/model/activityRequestData.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  /*Api for add activity*/
  addActivity(ActivityRequestData activityRequestData) async{
    String? token = await SharedPreference().getStringFromSharedPreferences("token");
    final Uri uri = Uri.parse(ApiStrings.baseUrl+ ApiStrings.endpoint_create_activity);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    Map<String, dynamic> body = activityRequestData.toJson();
    print("Body --- ${body}");
    http.Response response = await http.post(uri,
        headers: headers, body: jsonEncode(body));
    /*if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body)["Friction"];
      print(response.statusCode);
      print(data["message"]);
      return data;
    } else {
      print("Response Failure");

    }*/
    return response;


  }

  /*Api to get user profile*/
   getUserProfile() async {
    String? token = await SharedPreference().getStringFromSharedPreferences("token");
    final Uri uri = Uri.parse(ApiStrings.baseUrl+ ApiStrings.endpoint_get_user_profile);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    Map<String, String> body = {
        "email": "sandeep.kiran@global-csg.com"
    };
    http.Response response = await http.put(uri,
        headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body)["Friction"];
      print(response.statusCode);
      print(data["message"]);
      return data["data"];
    } else {
      print("Response Failure");
      
    }
  }
  /*Api to get all Upload History */
  getUploadHistory() async {
    String? token = await SharedPreference().getStringFromSharedPreferences("token");
    final Uri uri = Uri.parse(ApiStrings.baseUrl+ ApiStrings.endpoint_get_upload_histories);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    http.Response response = await http.get(uri, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body)["Friction"];
      print(data["message"]);
      print(response.statusCode);
      print(data["data"]);
      return data["data"];
    } else {
      print("Response Failure");

    }
  }

 /*Api to get all rail Location Units*/
  getRailUnitLocations() async {
    String? token = await SharedPreference().getStringFromSharedPreferences("token");
    final Uri uri = Uri.parse(ApiStrings.baseUrl+ ApiStrings.endpoint_get_all_rail_locations);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    http.Response response = await http.put(uri, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body)["Friction"];
      //print(data["message"]);
      print(response.statusCode);
      return data["data"];
    } else {
      print("Response Failure");

    }
  }

  /*Api to get all daily logs*/
  getDailyLogs(int activityId) async {
    String? token = await SharedPreference().getStringFromSharedPreferences("token");
    final Uri uri = Uri.parse(ApiStrings.baseUrl+ ApiStrings.endpoint_get_daily_logs);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    Map<String, int> body = {
      "activityId": activityId,
    };
    http.Response response = await http.put(uri, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body)["Friction"];
      //print(data["message"]);
      print(response.statusCode);
      return data["data"];
    } else {
      print("Response Failure");

    }
  }

  /*Api to get Service Tech*/
 getServiceTech () async {
   String? token = await SharedPreference().getStringFromSharedPreferences("token");
   final Uri uri = Uri.parse(ApiStrings.baseUrl+ ApiStrings.endpoint_get_all_service_techs);
   Map<String, String> headers = {
     'Content-type': 'application/json',
     'Accept': 'application/json',
     'Authorization': 'Bearer ${token}'
   };

   http.Response response = await http.get(uri, headers: headers);
   if (response.statusCode == 200 || response.statusCode == 201) {
     final data = json.decode(response.body)["Friction"];
     //print(data["message"]);
     print(response.statusCode);
     return data["data"];
   } else {
     print("Response Failure");

   }

 }
}