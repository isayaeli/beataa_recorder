import 'dart:convert';

import 'package:bit_recorder/pages/audioPlayer/play.dart';
import 'package:bit_recorder/pages/instrument/guitar.dart';
import 'package:bit_recorder/pages/instrument/marimba.dart';
import 'package:bit_recorder/pages/instrument/modal.dart';
import 'package:bit_recorder/pages/instrument/piano.dart';
import 'package:bit_recorder/pages/instrument/trumpet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Instrument extends StatefulWidget {
  @override
  _InstrumentState createState() => _InstrumentState();
}

class _InstrumentState extends State<Instrument> {
  
//   Future<List<Instruments>> _fetchData(http.Client client) async{
//    var response = await client.get("http://10.0.2.2:8000/api/instrument/");
//    if(response.statusCode == 200){
//      List jsonResponse = json.decode(response.body);
//      return jsonResponse.map((e) => Instruments.fromJson(e)).toList();
//    }
//   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.teal,
        child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
              children:[
               InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Guitar(

                ))) ,
             child: Card(
             color: Colors.teal[200],
             margin:EdgeInsets.all(15.0),
             elevation: 10.0,
             child:Column(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children:[
                    CircleAvatar(
                      radius:55,
                  //backgroundImage: NetworkImage(data[i].img),
                ),
                Text('Guitar',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                  ]
                ), 
            
            ),
              ),
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Piano(

                  ))) ,
                  child: Card(
                    color: Colors.teal[200],
                    margin:EdgeInsets.all(15.0),
                    elevation: 10.0,
                    child:Column(
                        mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                        children:[
                          CircleAvatar(
                            radius:55,
                            //backgroundImage: NetworkImage(data[i].img),
                          ),
                          Text('Piano',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ]
                    ),

                  ),
                ),

                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Marimba(

                  ))) ,
                  child: Card(
                    color: Colors.teal[200],
                    margin:EdgeInsets.all(15.0),
                    elevation: 10.0,
                    child:Column(
                        mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                        children:[
                          CircleAvatar(
                            radius:55,
                            //backgroundImage: NetworkImage(data[i].img),
                          ),
                          Text('Marimba',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ]
                    ),



                  ),
                ),

                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Trumpet(

                  ))) ,
                  child: Card(
                    color: Colors.teal[200],
                    margin:EdgeInsets.all(15.0),
                    elevation: 10.0,
                    child:Column(
                        mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                        children:[
                          CircleAvatar(
                            radius:55,
                            //backgroundImage: NetworkImage(data[i].img),
                          ),
                          Text('Trumpets',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ]
                    ),



                  ),
                )
       ]
        ),
      ),
    );
  }
}