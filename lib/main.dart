import 'package:covid_19/components/details.dart';
import 'package:covid_19/components/network.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'constant.dart';
import 'counter.dart';
import 'header.dart';
import 'info_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid-19',
      theme: ThemeData(

        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: kBodyTextColor),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  int lst = 10;
  int infected=0;
  int deaths=0;
  int reco=0;

  String country="Global";
  List<String> countrylist=[
    'Global',

  ];

  void getcountries() async
  {
    NetworkHelper networkhelper=NetworkHelper("https://api.covid19api.com/summary");
    var data=await networkhelper.getData();
    lst = data["Countries"].length;

    for(int i=0;i<lst;i++)
      {


        setState(() {
          countrylist.add(data["Countries"][i]["Country"]);
        });
      }
    setState(() {
      infected = data["Global"]["TotalConfirmed"];
      deaths = data["Global"]["TotalDeaths"];
      reco = infected-deaths;
    });

    print(data["Countries"].length);
    //return weatherData;
  }

  void caseupdate(String cntryname) async{

    NetworkHelper networkhelper=NetworkHelper("https://api.covid19api.com/summary");
    var data=await networkhelper.getData();
    int i;
    for(i=0;i<lst;i++)
      {
        if(data["Countries"][i]["Country"] == cntryname)
          break;
      }
    setState(() {
      infected = data["Countries"][i]["TotalConfirmed"];
      deaths = data["Countries"][i]["TotalDeaths"];
      reco = infected-deaths;
    });


  }

  @override
  void initState() {
    getcountries();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: <Widget>[

            MyHeader(
              image: "assets/icons/Drcorona.svg",
              textTop: "All you need",
              textBottom: "is stay at home.",
              //offset: offset,
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Color(0XFFE5E5E5),
                ),
              ),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset("assets/icons/maps-and-flags.svg"),
                  SizedBox(width: 20),
                  Expanded(
                      child: DropdownButton(
                        isExpanded: true,
                        underline: SizedBox(),
                        icon: SvgPicture.asset("assets/icons/dropdown.svg"),
                        value: country,
                        items: countrylist.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            country = value.toString();
                            caseupdate(country);
                            print(country);
                          });
                        },
                      ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                Row(
                    children: <Widget>[
                      RichText(
                          text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Case Update\n",
                              style: kTitleTextstyle,
                            ),
                            TextSpan(
                              text: "Newest update March 28",
                              style: TextStyle(
                              color: kTextLightColor,
                            ),
                          ),
                      ],
                    ),
                  ),
                      Spacer(),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  DetailWeb(
                                url: "https://www.worldometers.info/coronavirus/"
                            )),
                          );
                        },
                        child: Text(
                          "See details",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                ],
              ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Counter(
                          color: kInfectedColor,
                          number: infected,
                          title: "Infected",
                        ),
                        Counter(
                          color: kDeathColor,
                          number: deaths,
                          title: "Deaths",
                        ),
                        Counter(
                          color: kRecovercolor,
                          number: reco,
                          title: "Recovered",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Spread of Virus",
                        style: kTitleTextstyle,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  DetailWeb(
                                url: "https://covid19.who.int/"
                            )),
                          );
                        },
                        child: Text(
                          "See details",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(

                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(10),
                    height: 108,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      "assets/images/map.png",
                      fit: BoxFit.contain,
                    ),
                  ),
            ],
              ),
              ),
          ],
        ),
      ),
    );
  }
}






