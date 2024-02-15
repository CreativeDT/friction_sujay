

//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:friction/componants/ActivityData.dart';
import 'package:friction/componants/DownloadCenter.dart';
import 'package:friction/componants/updateActivity.dart';
import 'dart:convert';
import 'package:friction/ApiStrings.dart';
import 'package:friction/componants/SharedPreference.dart';
import 'package:friction/componants/workStartPage.dart';
import 'package:friction/data/model/UploadHistoryData.dart';
import 'package:http/http.dart' as http;

import '../data/ApiService.dart';


DownloadCenter downloadCenter = DownloadCenter();
Set<int> expandedTiles = {};
Set<String> serviceTechList = {};
ValueNotifier<bool> showHeader = ValueNotifier<bool>(true);
ValueNotifier<bool> filterOn = ValueNotifier<bool>(false);

final ApiService apiService = ApiService();
List<UploadHistoryData> uploadHistoryList = [];

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
      bottomNavigationBar: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Showing 1-10 out of 3000'),
          ],
        ),
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

  @override
  void initState() {
    uploadHistoryList.clear();
    getUploadHistory();
    expandedTiles.clear();
    showHeader.value = true;
    filterOn.value = false;
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  height: 32,
                  width:195,
                  child: SearchAnchor(
                      builder: (BuildContext context, SearchController controller) {
                        return SearchBar(
                          controller: controller,
                          side: MaterialStateProperty.all(const BorderSide(color: Color.fromRGBO(205, 205, 205, 1))),
                          constraints: const BoxConstraints(
                              maxWidth: 185,
                              maxHeight: 32
                          ),
                          onTap: () {
                            controller.openView();
                          },
                          onChanged: (_) {
                            controller.openView();
                          },
                          leading: const Icon(Icons.search,color: Color.fromRGBO(205, 205, 205, 1),
                            size: 25 ,),
                          hintText: 'Search For Rail List',
                          hintStyle:  MaterialStateProperty.all(TextStyle(color: Color.fromRGBO(158, 158, 158, 1), fontSize: 12,
                              fontWeight: FontWeight.w400,letterSpacing: 0,fontFamily: 'WorkSans')),
                        );
                      }, suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                    return List<ListTile>.generate(serviceTechList.length, (int index) {
                      final String item = serviceTechList.toList()[index];
                      return ListTile(
                        title: Text(item),
                        onTap: () {
                          setState(() {
                            controller.closeView(item);
                            //to do handling search
                          });
                        },
                      );
                    });
                  }),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: generateCardList(10),
        ),
        ]

      ),
      )

    );
  }


  List<Widget> generateCardList(int count) {
    List<ActivityCard> cardList = [];
    for(var data in uploadHistoryList){
      cardList.add(ActivityCard(itemData: data));
    }
    return cardList;
  }
  getUploadHistory() async {
    apiService.getUploadHistory().then((data) {
      for (var data in data) {
        uploadHistoryList.add(UploadHistoryData.fromJson(data));
      }
      setState(() {

      });
      /* String? token = await SharedPreference().getStringFromSharedPreferences("token");
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
      for(var item in activityDataList){
        serviceTechList.add(item.ServiceTechEmail!);
      }
      //print(activityDataList.toString());
      */ /*for(var value in activityDataList) {
        var items = ItemData(ID: value.ActivityTypeSerialId.toString(),
          serviceTech: value.ServiceTechEmail.toString(),
          activityType: value.ActivityType.toString(),);

          print(items.toString());

      */ /**/ /* itemList.add(ItemData(ID: value.ActivityTypeSerialId.toString(),
       serviceTech: value.ServiceTechEmail.toString(),
         activityType: value.ActivityType.toString(),
       ));
       //itemList.add(item);*/ /**/ /*

      }*/ /*
      */ /*{
        lastCreatedServiceId = activityDataList[0].ActivityTypeSerialId;
        lastCreatedActivityEmail = activityDataList[0].ServiceTechEmail;
      }*/ /*
      setState(() {
      });
      print ("activityDataList" + activityDataList.toString());
      print ("serviceTechList" + serviceTechList.toString());
      //print("itemList:" + itemList.toString() );
    } else {
      print("Response Failure");
    }
  }*/
    }
      );
        }
}

class ActivityCard extends StatefulWidget {
  final String idText;
  final String serviceText;
  final UploadHistoryData itemData;
  const ActivityCard({Key? key, this.idText = '965891', this.serviceText = 'james.j.gantzer@loram.com', required this.itemData}) : super(key: key);

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}
class _ActivityCardState extends State<ActivityCard> {

  bool showEdit = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(217, 217, 217, 1)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: ExpansionTile(
          childrenPadding: EdgeInsets.only(left: 10),
          onExpansionChanged: (value){
            showEdit = !showEdit;

          },
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 10,),
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
                    Visibility(
                      visible: false,
                      child: Row(
                        children: [
                          SizedBox(width: 50,height: 50,),

                        ],
                      ),
                    ),
                    Text('User Name',
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
                    Text(widget.itemData.UploadedDateTime ,
                      style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 14,
                        fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: false,
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
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => WorkStartPage()));
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
                                      //Navigator.push(context, MaterialPageRoute(builder: (context) => updateActivity(data: widget.itemData,)));
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

                    Text(widget.itemData.ServiceTechEmail,
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
                      Text('ID',
                        style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 12,
                          fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Upload Type',
                        style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 12,
                          fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Successful',
                        style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 12,
                          fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                    ],
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.itemData.ActivitySerialId,
                        style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 12,
                          fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                      SizedBox(
                        height: 10,
                      ),
                      Text(widget.itemData.UploadType,
                        style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 12,
                          fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                      SizedBox(height: 10,),
                      Text(widget.itemData.Status == true ? "Yes" : "No",
                        style: TextStyle(color: Color.fromRGBO(9, 137, 7, 1) , fontSize: 14,
                          fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),

                    ],
                  ),


                ],
              ),
            ),

            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}

