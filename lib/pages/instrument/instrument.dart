import 'dart:convert';

import 'package:bit_recorder/pages/audioPlayer/play.dart';
import 'package:bit_recorder/pages/instrument/modal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Instrument extends StatefulWidget {
  @override
  _InstrumentState createState() => _InstrumentState();
}

class _InstrumentState extends State<Instrument> {
  
   Future<List<Instruments>> _fetchData(http.Client client) async{
    var response = await client.get("http://10.0.2.2:8000/api/instrument/");
    if(response.statusCode == 200){
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => Instruments.fromJson(e)).toList();
    }
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.teal,
        child:FutureBuilder(
          future: _fetchData(http.Client()),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            List<Instruments> data = snapshot.data;
            if(snapshot.hasData ){
              return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2
              ),
              itemCount: data.length,
              itemBuilder: (context, i){
              return InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Play(
                  audio: data[i].audio,
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
                  backgroundImage: NetworkImage(data[i].img),
                ),
                Text(data[i].name,
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                  ]
                ), 
            
            ),
              );
              },
              );
            }else if(snapshot.hasError){
              return Center(child:Text('${snapshot.error}'));
            }else{
              return Center(child: CircularProgressIndicator(),);
            }
          },
        ),
      ),
    );
  }
}