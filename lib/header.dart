import 'package:covid_19/main.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'constant.dart';
import 'info_screen.dart';


class MyHeader extends StatelessWidget {
  final String image;
  final String textTop;
  final String textBottom;
  //final double offset;
  const MyHeader(
      {Key? key, required this.image, required this.textTop, required this.textBottom})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(left: 40,top: 50,right: 20),
        height: 350,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0XFF3383CD),
              Color(0XFF11249F),
            ],
          ),
          image: DecorationImage(
            image: AssetImage("assets/images/virus.png"),
          ),

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Info_Screen();
                    },
                  ),
                );
              },
              onDoubleTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomeScreen();
                    },
                  ),
                );
              },
              child: SvgPicture.asset("assets/icons/menu.svg"),
            ),

            SizedBox(height: 60),

            Expanded(

              child:Stack(
                children:<Widget>[
                  SvgPicture.asset(
                    image,
                    width: 260,
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                  ),
                  Positioned(
                    top: 20,
                    left: 170,
                    child:Text(
                      "$textTop \n$textBottom",
                      style: kHeadingTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),

                  ),
                  Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path=Path();
    path.lineTo(0, size.height-80);
    path.quadraticBezierTo(size.width/2, size.height, size.width, size.height-80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }

}


