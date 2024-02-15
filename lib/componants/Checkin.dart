import 'package:flutter/material.dart';
import 'package:friction/home.dart';


class Checkin extends StatelessWidget {
  final int teamScore;
  final int locationScore;
  const Checkin({super.key,  this.teamScore = 0, this.locationScore = 0});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        locationScore == 0?Container(
          width: 130,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: const Text('Latest Checkins',
            style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1), fontSize: 14,
                fontWeight: FontWeight.w600,letterSpacing: 1,fontFamily: 'WorkSans'),
          ),):Container(
            width: 130,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: const Text('Latest Checkins',
            style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1), fontSize: 14,
                fontWeight: FontWeight.w400,letterSpacing: 1,fontFamily: 'WorkSans'),
              )),
        locationScore==0?InkWell(
          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Home(team: teamScore, location: 1,)));},
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            height: 30,
            width: 30,
            child: Image.asset('assets/icons/toggle.png'),

          ),
        ): InkWell(
          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Home(team: teamScore, location: 0,)));},
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            height: 30,
            width: 30,
            child: Image.asset('assets/icons/toggle1.png'),

          ),
        ),
        locationScore == 0?Container(
          width: 80,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: const Text('Locations',
            style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1), fontSize: 14,
                fontWeight: FontWeight.w400,letterSpacing: 1,fontFamily: 'WorkSans'),
          ),):Container(
            width: 80,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: const Text('Locations',
              style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1), fontSize: 14,
                  fontWeight: FontWeight.w600,letterSpacing: 1,fontFamily: 'WorkSans'),
            )),
        Container(
          padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
          height: 21,
          child: ElevatedButton(
            onPressed: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.fromLTRB(10, 2, 5, 2),
              backgroundColor: Colors.white,
              side: BorderSide(color: Color.fromRGBO(26, 179, 148, 1), width: 1),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Filters',
                  style: TextStyle(color: Color.fromRGBO(26, 179, 148, 1), fontSize: 12,
                      fontWeight: FontWeight.w600,letterSpacing: 0,fontFamily: 'WorkSans'),),
                SizedBox(width: 10,),
                Image.asset('assets/icons/setting4.png'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}