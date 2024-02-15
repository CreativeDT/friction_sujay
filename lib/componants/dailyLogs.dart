//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:friction/componants/ActivityData.dart';
import 'package:friction/componants/DownloadCenter.dart';
import 'package:friction/componants/updateActivity.dart';
import 'dart:convert';
import 'package:friction/ApiStrings.dart';
import 'package:friction/componants/SharedPreference.dart';
import 'package:friction/componants/workStartPage.dart';
import 'package:friction/data/model/DailyLogData.dart';
import 'package:http/http.dart' as http;

import '../home.dart';

List<DailyLogData> dailyLogList = [];
DailyLogData dataToPass = DailyLogData();
DownloadCenter downloadCenter = DownloadCenter();
Set<int> expandedTiles = {};
Set<String> serviceTechList = {};
ValueNotifier<bool> showHeader = ValueNotifier<bool>(true);
ValueNotifier<bool> filterOn = ValueNotifier<bool>(false);

class dailyLogs extends StatelessWidget {
  const dailyLogs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(21, 134, 202, 1),
        title: Text('Daily Logs',
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
    dailyLogList.clear();
    getDailyLogs();
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
        child: Stack(
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: filterOn,
              builder: (context, value, child){
                return Visibility(
                  visible: !filterOn.value,
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
                            child: Column(
                              children: [

                                Container(
                                  margin: EdgeInsets.fromLTRB(5, 0, 5, 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,

                                        child: Container(
                                          height: 32,
                                          child: ElevatedButton(

                                              onPressed: (){
                                                downloadCenter.logsDownload(dailyLogList);

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
                                      ),
                                      SizedBox(width: 10,),
                                      Container(
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
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 15, 10, 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(),),
                                      InkWell(
                                          onTap: (){
                                            filterOn.value = true;
                                          },
                                          child: Image.asset('assets/icons/filters.png')),
                                    ],
                                  ),
                                ),
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
                );
              },
            ),
            ValueListenableBuilder<bool>(
                valueListenable: filterOn,
                builder: (context, value, child){
                  return Visibility(
                    visible: false,
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      height: 320,
                      width: 400,
                      child: Card(
                        borderOnForeground: true,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          side: BorderSide(
                            color: Color.fromRGBO(0, 0, 0, 0.25), // Border color
                            width: 1.0,          // Border width
                          ),
                        ),
                        child: Stack(
                          children: [
                            Column(mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text('Filters',
                                      style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1), fontSize: 14,
                                          fontWeight: FontWeight.w700,letterSpacing: 1,fontFamily: 'WorkSans'),
                                    )),

                                Container(
                                  height: 33,
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 10,),

                                      Expanded(
                                        flex: 1,
                                        child: TextFormField(
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle( fontSize: 12,
                                                  fontWeight: FontWeight.w400,letterSpacing: 0,fontFamily: 'WorkSans'),
                                              labelText: 'Select Service Tech*',
                                              hintStyle:  TextStyle( fontSize: 12,
                                                  fontWeight: FontWeight.w400,letterSpacing: 0,fontFamily: 'WorkSans'),
                                              suffixIcon: const Icon(Icons.keyboard_arrow_down,
                                                size: 25 ,),
                                              border: OutlineInputBorder(),
                                            )
                                        ),

                                      ),
                                      SizedBox(width: 20,),
                                      Expanded(
                                        flex: 1,
                                        child: TextFormField(
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle( fontSize: 12,
                                                  fontWeight: FontWeight.w400,letterSpacing: 0,fontFamily: 'WorkSans'),
                                              labelText: 'Select Activity type',
                                              hintStyle:  TextStyle( fontSize: 12,
                                                  fontWeight: FontWeight.w400,letterSpacing: 0,fontFamily: 'WorkSans'),
                                              suffixIcon: const Icon(Icons.keyboard_arrow_down,
                                                size: 25 ,),
                                              border: OutlineInputBorder(),
                                            )
                                        ),

                                      ),
                                      SizedBox(width: 10,)


                                    ],
                                  ),
                                ),
                                Container(
                                  height: 33,
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 10,),

                                      Expanded(
                                        flex: 1,
                                        child: TextFormField(
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle( fontSize: 12,
                                                  fontWeight: FontWeight.w400,letterSpacing: 0,fontFamily: 'WorkSans'),
                                              labelText: 'select Work start',
                                              hintStyle:  TextStyle( fontSize: 12,
                                                  fontWeight: FontWeight.w400,letterSpacing: 0,fontFamily: 'WorkSans'),
                                              suffixIcon: const Icon(Icons.keyboard_arrow_down,
                                                size: 25 ,),
                                              border: OutlineInputBorder(),
                                            )
                                        ),

                                      ),
                                      SizedBox(width: 20,),
                                      Expanded(
                                        flex: 1,
                                        child: TextFormField(
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle( fontSize: 12,
                                                  fontWeight: FontWeight.w400,letterSpacing: 0,fontFamily: 'WorkSans'),
                                              labelText: 'select Work end',
                                              hintStyle:  TextStyle( fontSize: 12,
                                                  fontWeight: FontWeight.w400,letterSpacing: 0,fontFamily: 'WorkSans'),
                                              suffixIcon: const Icon(Icons.keyboard_arrow_down,
                                                size: 25 ,),
                                              border: OutlineInputBorder(),
                                            )
                                        ),

                                      ),
                                      SizedBox(width: 10,)


                                    ],
                                  ),
                                ),
                                Container(
                                  height: 33,
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 10,),

                                      Expanded(
                                        flex: 1,
                                        child: TextFormField(
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle( fontSize: 12,
                                                  fontWeight: FontWeight.w400,letterSpacing: 0,fontFamily: 'WorkSans'),
                                              labelText: 'Select Rail Line',
                                              hintStyle:  TextStyle( fontSize: 12,
                                                  fontWeight: FontWeight.w400,letterSpacing: 0,fontFamily: 'WorkSans'),
                                              suffixIcon: const Icon(Icons.keyboard_arrow_down,
                                                size: 25 ,),
                                              border: OutlineInputBorder(),
                                            )
                                        ),

                                      ),
                                      SizedBox(width: 20,),
                                      Expanded(
                                        flex: 1,
                                        child: TextFormField(
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle( fontSize: 12,
                                                  fontWeight: FontWeight.w400,letterSpacing: 0,fontFamily: 'WorkSans'),
                                              labelText: 'Select Mile Post',
                                              hintStyle:  TextStyle( fontSize: 12,
                                                  fontWeight: FontWeight.w400,letterSpacing: 0,fontFamily: 'WorkSans'),
                                              suffixIcon: const Icon(Icons.keyboard_arrow_down,
                                                size: 25 ,),
                                              border: OutlineInputBorder(),
                                            )
                                        ),

                                      ),
                                      SizedBox(width: 10,)


                                    ],
                                  ),
                                ),
                                Container(
                                  height: 33,
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 10,),

                                      Expanded(
                                        flex: 1,
                                        child: TextFormField(
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle( fontSize: 12,
                                                  fontWeight: FontWeight.w400,letterSpacing: 0,fontFamily: 'WorkSans'),
                                              labelText: 'Enter Division',
                                              hintStyle:  TextStyle( fontSize: 12,
                                                  fontWeight: FontWeight.w400,letterSpacing: 0,fontFamily: 'WorkSans'),
                                              suffixIcon: const Icon(Icons.keyboard_arrow_down,
                                                size: 25 ,),
                                              border: OutlineInputBorder(),
                                            )
                                        ),

                                      ),
                                      SizedBox(width: 20,),
                                      Expanded(
                                        flex: 1,
                                        child: TextFormField(
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle( fontSize: 12,
                                                  fontWeight: FontWeight.w400,letterSpacing: 0,fontFamily: 'WorkSans'),
                                              labelText: 'Enter Sub-Division',
                                              hintStyle:  TextStyle( fontSize: 12,
                                                  fontWeight: FontWeight.w400,letterSpacing: 0,fontFamily: 'WorkSans'),
                                              suffixIcon: const Icon(Icons.keyboard_arrow_down,
                                                size: 25 ,),
                                              border: OutlineInputBorder(),
                                            )
                                        ),

                                      ),
                                      SizedBox(width: 10,)


                                    ],
                                  ),
                                ),

                                Container(
                                  height: 33,
                                  margin: EdgeInsets.fromLTRB(0, 25, 0, 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 10,),

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
                                          child:  Text('Clear filters',
                                            style: TextStyle(color: Color.fromRGBO(26, 179, 148, 1), fontSize: 12,
                                                fontWeight: FontWeight.w600,letterSpacing: 0,fontFamily: 'WorkSans'),),
                                        ),

                                      ),
                                      SizedBox(width: 20,),
                                      Expanded(
                                        flex: 1,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                            });
                                            //Navigator.push(context, MaterialPageRoute(builder: (context) => WorkStartPage()));
                                          },
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
                                            backgroundColor: Color.fromRGBO(26, 179, 148, 1),
                                            side: BorderSide(color: Color.fromRGBO(26, 179, 148, 1), width: 1),
                                          ),
                                          child: const Text('Apply',
                                            style: TextStyle(color: Colors.white, fontSize: 12,
                                                fontWeight: FontWeight.w600,letterSpacing: 0,fontFamily: 'WorkSans'),),
                                        ),

                                      ),
                                      SizedBox(width: 10,)


                                    ],
                                  ),
                                ),

                              ],
                            ),
                            Positioned(top: 5,
                                right: 5,
                                child: InkWell(
                                    onTap: (){
                                      setState(() {
                                        filterOn.value = false;
                                      });
                                      //Navigator.of(context).pop();
                                    },
                                    child: Image.asset('assets/icons/close.png')))
                          ],
                        ),
                      ),
                    ),
                  );
                }
            ),


          ],
        ),

      ),

    );
  }


  List<Widget> generateCardList(int count) {
    List<ActivityCard> cardList = [];
    for(var data in dailyLogList){
      cardList.add(ActivityCard(itemData: data));
    }
    return cardList;
  }
  getDailyLogs() async {
    apiService.getDailyLogs(1).then((data) {
      for (var data in data) {
        dailyLogList.add(DailyLogData.fromJson(data));
      }
      setState(() {

      });
    }
    );
  }
}

class ActivityCard extends StatefulWidget {
  final String idText;
  final String serviceText;
  final DailyLogData itemData;
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
          childrenPadding: EdgeInsets.only(left: 5),
          onExpansionChanged: (value){
            showEdit = !showEdit;
            /*if (value) {
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
            print(expandedTiles.toString());*/

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
                    Text('ID',
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
                    Text("Date Created",
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
                    Text(widget.itemData.truckId.toString() ,
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

                    Text(widget.itemData.createdAt!,
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
                      Text('Work Start',
                        style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 12,
                          fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Work End',
                        style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 12,
                          fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Uploaded',
                        style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 12,
                          fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Country',
                        style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 12,
                          fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),

                      SizedBox(
                        height: 10,
                      ),
                      Text('State',
                        style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 12,
                          fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Railroad',
                        style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1) , fontSize: 12,
                          fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                      SizedBox(
                        height: 10,
                      ),
                      Text('#Helpers',
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
                      Text(widget.itemData.estimatedWorkStartDate!,
                        style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 12,
                          fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                      SizedBox(
                        height: 10,
                      ),
                      Text(widget.itemData.estimatedWorkEndDate!,
                        style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 12,
                          fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                      SizedBox(height: 10,),
                      Text(widget.itemData.uploadedDateTime!,
                        style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 12,
                          fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                      SizedBox(height: 10,),
                      Text(widget.itemData.country!,
                        style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 12,
                          fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                      SizedBox(height: 10,),
                      Text(widget.itemData.state!,
                        style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 12,
                          fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                      SizedBox(height: 10,),
                      Text(widget.itemData.railRoad!,
                        style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 12,
                          fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),
                      SizedBox(height: 10,),
                      Text(widget.itemData.helperCount.toString()!,
                        style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1) , fontSize: 12,
                          fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,fontFamily: 'WorkSans',),),

                    ],
                  ),


                ],
              ),
            ),
            Container(
              height: 27,
              width: 380,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex:1,
                      child: SizedBox(width: 200)),

                  Container(
                    width: 100,
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
                  SizedBox(width: 10,),

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




