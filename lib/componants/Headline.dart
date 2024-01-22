import 'package:flutter/material.dart';
import 'package:friction/home.dart';

class Headline extends StatelessWidget {
  final int teamScore;
  final int locationScore;
  const Headline({super.key, this.teamScore = 0, this.locationScore = 0});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        teamScore==0?Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: const Text('Me',
            style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1), fontSize: 14,
                fontWeight: FontWeight.w600,letterSpacing: 1,fontFamily: 'WorkSans'),
          ),
        ): Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: const Text('Me',
                style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1), fontSize: 14,
                    fontWeight: FontWeight.w400,letterSpacing: 1,fontFamily: 'WorkSans'),
              ),
        ),
        teamScore==0?InkWell(
          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Home(team: 1, location: locationScore,)));},
          child: Container(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            height: 30,
            child: Image.asset('assets/icons/toggle.png'),

          ),
        ): InkWell(
          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Home(team: 0, location: locationScore,)));},
          child: Container(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            height: 30,
            child: Image.asset('assets/icons/toggle1.png'),

          ),
        ),
        teamScore==0?Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: const Text('My Team',
            style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1), fontSize: 14,
                fontWeight: FontWeight.w400,letterSpacing: 1,fontFamily: 'WorkSans'),
          ),
        ): Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: const Text('My Team',
            style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1), fontSize: 14,
                fontWeight: FontWeight.w600,letterSpacing: 1,fontFamily: 'WorkSans'),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
          height: 24,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(26, 179, 148, 1), // background
            ),
            onPressed: () {  },
            child: const Text('Punch In',
              style: TextStyle(color: Colors.white, fontSize: 13,
                  fontWeight: FontWeight.w600,letterSpacing: 1,fontFamily: 'WorkSans'),
            ),

          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          height: 24,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(26, 179, 148, 1), // background
            ),
            onPressed: () {  },
            child: const Text('Punch Out',
              style: TextStyle(color: Colors.white, fontSize: 13,
                  fontWeight: FontWeight.w600,letterSpacing: 1,fontFamily: 'WorkSans'),
            ),

          ),
        ),
      ],
    );
  }
}