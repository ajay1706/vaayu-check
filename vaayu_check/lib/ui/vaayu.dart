import 'package:flutter/material.dart';
import '../utils/utils.dart' as util;
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


class Vaayu extends StatefulWidget {
  @override
  _VaayuState createState() => _VaayuState();
}

class _VaayuState extends State<Vaayu> {

  void showStuff() async{
    Map data = await getWeather(util.appId, util.defaultCity);
    print(data.toString());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: new AppBar(
        title: Text("vaayu-check",
        style: new TextStyle(
          color: Colors.white
        ),),
        backgroundColor: Colors.black54,
        actions: <Widget>[

          new IconButton(
            icon:new  Icon(Icons.menu),
          onPressed: showStuff,
          ),
     ],
      ),

body: new Stack(

children: <Widget>[

new Center(
  child: new Image.asset('images/umbrella.png',
  width: 490.0,
  height: 1200.0,
      fit: BoxFit.fill,),

),
  new Container(
    alignment: Alignment.topRight,
    margin: const EdgeInsets.fromLTRB(0.0,11.0,21.0,0.0),
    child: new Text("Hyderabad",
    style:cityStyle() ,),
  ),
  new Container(


    alignment: Alignment.center,
    child: new Image.asset("images/light_rain.png")
  ),
  new Container(
    margin: const EdgeInsets.fromLTRB(30.0,500.0,0.0,0.0),
    child: updateTempWidget("hyderabad"),
  ),


],


),
    );
  }



  Future<Map> getWeather(String appId, String city) async{
String apiUrl = "http://api.openweathermap.org/data/2.5/weather?q=$city&APPID=${util.appId}&units=imperial";
http.Response response = await http.get(apiUrl);

return json.decode(response.body);

  }

Widget updateTempWidget(String city){

    return new FutureBuilder(

      builder: (BuildContext context,AsyncSnapshot<Map> snapshot){

        if(snapshot.hasData){

          Map content = snapshot.data;
          return new Container(

            child: new Column(

              children: <Widget>[

                new ListTile(

                  title: new Text(content['main']['tmep'].toString()),

                )


              ],
            ),
          );

        }


      },
    );
}

}

TextStyle cityStyle(){
  return new TextStyle(
    fontStyle: FontStyle.normal,
    fontSize: 22.9,
    color: Colors.white


  );
}
TextStyle tempStyle(){
  return TextStyle(


    fontSize: 49.9,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    color: Colors.white
  );
}