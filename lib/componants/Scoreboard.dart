import 'package:flutter/material.dart';


class Scoreboard extends StatelessWidget {
  final int teamScore;
   const Scoreboard({super.key, this.teamScore = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
        height: 230,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          border: Border.all(
            color: Colors.black12,
            width: 2,),
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
                      child: Text('Avg Time',
                        style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1), fontSize: 13,
                            fontWeight: FontWeight.w400,letterSpacing: 1,fontFamily: 'WorkSans'),),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      child: Image.asset('assets/icons/respons.jpg'),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(teamScore==0?'09:56 Hrs': '189:04 Hrs',
                        style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1), fontSize: 13,
                            fontWeight: FontWeight.w600,letterSpacing: 1,fontFamily: 'WorkSans'),),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Text('Avg Sixty Day\nInspection Time',
                        style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1), fontSize: 13,
                            fontWeight: FontWeight.w400,letterSpacing: 1,fontFamily: 'WorkSans'),),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      child: Image.asset('assets/icons/earth.jpg'),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(teamScore==0?'12:56 Hrs': '140:46 Hrs',
                        style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1), fontSize: 13,
                            fontWeight: FontWeight.w600,letterSpacing: 1,fontFamily: 'WorkSans'),),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
                      child: Text('Avg Commute',
                        style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1), fontSize: 13,
                            fontWeight: FontWeight.w400,letterSpacing: 1,fontFamily: 'WorkSans'),),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      child: Image.asset('assets/icons/speed.jpg'),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(teamScore==0?'1234 Miles':'6254 Miles',
                        style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1), fontSize: 13,
                            fontWeight: FontWeight.w600,letterSpacing: 1,fontFamily: 'WorkSans'),),
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(

                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                      child: Text('% Prod Work',
                        style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1), fontSize: 13,
                            fontWeight: FontWeight.w400,letterSpacing: 1,fontFamily: 'WorkSans'),),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      child: Image.asset('assets/icons/system.jpg'),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Text(teamScore==0?'09:56 Hrs': '169:56 Hrs',
                        style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1), fontSize: 13,
                            fontWeight: FontWeight.w600,letterSpacing: 1,fontFamily: 'WorkSans'),),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(30, 10, 10, 10),
                      child: Text('% Off Work',
                        style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1), fontSize: 13,
                            fontWeight: FontWeight.w400,letterSpacing: 1,fontFamily: 'WorkSans'),),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      child: Image.asset('assets/icons/production.jpg'),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Text(teamScore==0?'12:56 Hrs': '472:13 Hrs',
                        style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1), fontSize: 13,
                            fontWeight: FontWeight.w600,letterSpacing: 1,fontFamily: 'WorkSans'),),
                    ),
                  ],
                ),
                SizedBox(
                  width: 120,
                ),
              ],
            ),
          ],
        )
    );
  }
}