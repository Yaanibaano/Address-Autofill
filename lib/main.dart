import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "package:geolocator/geolocator.dart";
import "package:geocoder/geocoder.dart";

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: GoogleApiApp(),
    title: "googleApiApp",
  ));
}

class GoogleApiApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GoogleApiApp();
  }
}

class _GoogleApiApp extends State<GoogleApiApp> {


  FocusNode citynode = FocusNode();
  FocusNode areanode = FocusNode();
  FocusNode statenode = FocusNode();
  FocusNode countrynode = FocusNode();
  FocusNode pinnode = FocusNode();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController areacontroller = TextEditingController();
  TextEditingController statecontroller = TextEditingController();
  TextEditingController countrycontroller = TextEditingController();
  TextEditingController pincontroller = TextEditingController();

  void getLocation() {
  Geolocator locator = Geolocator()..forceAndroidLocationManager;
  locator
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
      .then((v) async {
    var cos = Coordinates(v.latitude, v.longitude);
    var addrs = await Geocoder.local.findAddressesFromCoordinates(cos);
    var first = addrs.first;
    String g = first.addressLine;
    List<String> listy = g.split(",");
    var m = listy.getRange(0, 4).toList(); 
    replace(m.join(", "), first.locality, first.postalCode, first.adminArea, first.countryName);
  });
}

  
  void replace(String area,String city,String zip,String state,String country){
    setState(() {
      areacontroller.value = TextEditingValue(text:area);
      citycontroller.value = TextEditingValue(text:city);
      statecontroller.value = TextEditingValue(text:state);
      countrycontroller.value = TextEditingValue(text:country);
      pincontroller.value = TextEditingValue(text:zip);
    });
  }

  void clear(){
    areacontroller.clear();
    countrycontroller.clear();
    pincontroller.clear();
    statecontroller.clear();
    citycontroller.clear();
  }
  
  Widget _country() {
    return Container(
      margin: EdgeInsets.only(
        top: 20.0,
        left: 30.0,
        right: 30.0,
      ),
      child: TextFormField(
        controller: countrycontroller,
        focusNode: countrynode,
        style: TextStyle(color:Colors.yellow),
        decoration: InputDecoration(
            labelStyle:countrynode.hasFocus?  TextStyle(color: Colors.yellow):TextStyle(color: Colors.yellow[100]),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow[100]),
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow)),
            labelText: "Country"),
      ),
    );
  }

  Widget _state() {
    return Container(
      margin: EdgeInsets.only(
        top: 20.0,
        left: 30.0,
        right: 30.0,
      ),
      child: TextFormField(
        focusNode: statenode,
        controller: statecontroller,
         style: TextStyle(color:Colors.yellow),
        decoration: InputDecoration(
            labelStyle:statenode.hasFocus?  TextStyle(color: Colors.yellow):TextStyle(color: Colors.yellow[100]),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow[100]),
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow)),
            labelText: "State"),
      ),
    );
  }

  Widget _area() {
    return Container(
      margin: EdgeInsets.only(
        top: 20.0,
        left: 30.0,
        right: 30.0,
      ),
      child: TextFormField(
        controller: areacontroller,
      focusNode: areanode,
       style: TextStyle(color:Colors.yellow),
        decoration: InputDecoration(
            labelStyle:areanode.hasFocus?  TextStyle(color: Colors.yellow):TextStyle(color: Colors.yellow[100]),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow[100]),
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow)),
            labelText: "Area"),
      ),
    );
  }

  Widget _pincode() {
    return Container(
      margin: EdgeInsets.only(
        top: 20.0,
        left: 30.0,
        right: 30.0,
      ),
      child: TextFormField(
        focusNode: pinnode,
        controller: pincontroller,
        style: TextStyle(color:Colors.yellow),
        decoration: InputDecoration(
            labelStyle:pinnode.hasFocus?  TextStyle(color: Colors.yellow):TextStyle(color: Colors.yellow[100]),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow[100]),
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow)),
            labelText: "PinCode"),
      ),
    );
  }

  Widget _city() {
    return Container(
      margin: EdgeInsets.only(
        top: 20.0,
        left: 30.0,
        right: 30.0,
      ),
      child: TextFormField(
        focusNode: citynode,
        controller: citycontroller,
         style: TextStyle(color:Colors.yellow),
        decoration: InputDecoration(
           labelStyle:citynode.hasFocus?  TextStyle(color: Colors.yellow):TextStyle(color: Colors.yellow[100]),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow[100]),
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow)),
            labelText: "City"),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  }

  @override
  Widget build(BuildContext context) {
    double mainWidth = MediaQuery.of(context).size.width;
    print(MediaQuery.of(context).size.width);
    return Material(
        child: Scaffold(
      body: Center(
        child: Container(
            child: Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.2), BlendMode.dstATop),
                    image: AssetImage("images/GoogleMapTA.jpg"),
                    fit: BoxFit.cover)),
            child: Column(
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  flex: 6,
                  child: Opacity(
                    opacity: 0.8,
                                      child: Container(
                                        margin: EdgeInsets.only(bottom:10.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40)),
                          color: Color(0xffffdc34)),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            right:mainWidth/58.7142857143,
                            top:mainWidth/11.7428571429 ,
                           child:Icon(Icons.location_on,size: mainWidth/10.2857142857 ,color: Colors.black,)
                          ),
                          Positioned(
                            bottom: mainWidth/5.14285714286,
                            left: mainWidth/31.6483516484 ,
                            child: Text(
                              "Hello!, Im Chandru",
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  color: Colors.black,
                                  fontSize: mainWidth/9.14285714286,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          Positioned(
                              bottom: 45,
                              left: 13,
                              child: Text("Hope you like this App",
                                  style: TextStyle(
                                      fontFamily: "Roboto",
                                      color: Colors.black,
                                      fontSize: mainWidth/20.5714285714,
                                      fontWeight: FontWeight.w900)))
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 12,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      // color: Colors.red,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          image: DecorationImage(
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(0.2),
                                  BlendMode.dstATop),
                              image: AssetImage("images/GoogleMapTA.jpg"),
                              fit: BoxFit.cover)),
                      child: Container(
                          child: ListView(
                        children: <Widget>[
                          _area(),
                          _city(),
                          _pincode(),
                          _state(),
                          _country(),
                          Container(
                              margin: EdgeInsets.only(top: 40.0),
                              // color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  RaisedButton(
                                    splashColor: Colors.pink,
                                    padding: EdgeInsets.only(
                                        top: 13,
                                        bottom: 13.0,
                                        left: 28.0,
                                        right: 28.0),
                                    child: Text(
                                      "Autofill",
                                      style: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 22,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.black),
                                    ),
                                    color: Color(0xffffdc34),
                                    onPressed: () {
                                      getLocation();
                                      // if(_currentPosition!=null){
                                      // print(_currentPosition.latitude);
                                      // }
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                  ),
                                ],
                              ))
                        ],
                      ))),
                )
              ],
            ),
          ),
        )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:  Color(0xffffdc34) ,
        tooltip: "clear all",
        child: Icon(Icons.delete,color: Colors.black,),
        onPressed: clear),
    ));
  }
}
