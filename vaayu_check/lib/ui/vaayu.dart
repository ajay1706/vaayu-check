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

String _cityEntered;

  Future _goToNextScreen(BuildContext context) async {
    Map results = await Navigator.of(context).push(
      new MaterialPageRoute<Map>(  builder: (BuildContext context) => new ChangeCity())
    );

    if(results != null && results.containsKey('enter')){

_cityEntered = results['enter'];
    }

  }

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
          onPressed: () {
              _goToNextScreen(context);
          },
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
    child: new Text("${_cityEntered==null ? util.defaultCity : _cityEntered} ",
    style:cityStyle() ,),
  ),
  new Container(


    alignment: Alignment.center,
    child: new Image.asset("images/light_rain.png")
  ),
  new Container(
    margin: const EdgeInsets.fromLTRB(135.0,500.0,0.0,0.0),
    child: updateTempWidget(_cityEntered),
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

  updateTempWidget(String city) {

    return new FutureBuilder(
      future: getWeather(util.appId, city==null ? util.defaultCity : city ),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot){


        if(snapshot.hasData)
          {
            Map content = snapshot.data;
            return new Container(
child: new Column(

  children: <Widget>[

    ListTile(
      title: new Text(content['main']['temp'].toString(),
      style: tempStyle(),),
    )

  ],
),


            );


          }


      else {
        return new Container();
        }
      },


    );

  }

}


class ChangeCity extends StatelessWidget {

  var _cityFieldController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Change city"),
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),

      body: new Stack(
       children: <Widget>[
         new Center(
    child: new Image.asset("images/white_snow.png",
    width: 400.0,
    height: 1200.0,
    fit: BoxFit.fill,),
    ),
    new ListView(
    children: <Widget>[
      new ListTile(
    title: new TextField(
    decoration: new InputDecoration(
    hintText: "Enter your city"
    ),
    controller: _cityFieldController,
    keyboardType: TextInputType.text,
    ),

    ),
    new ListTile(
    title: new FlatButton(
    onPressed: (){
      Navigator.pop(context, {
        'enter' : _cityFieldController.text
      });
    },
    textColor: Colors.white70,
    color: Colors.black54,
    child: new Text("Submit"),
    ),
    )
    ],
    )
    ],

    ),);
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