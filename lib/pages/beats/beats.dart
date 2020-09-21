

import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:bit_recorder/pages/audioPlayer/play.dart';
import 'package:bit_recorder/pages/draweritems/drawer_items.dart';
import 'package:bit_recorder/pages/record/record.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bit_recorder/pages/beats/modal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Beats extends StatefulWidget {
  @override
  _BeatsState createState() => _BeatsState();
}

class _BeatsState extends State<Beats> {

  AudioPlayer audioPlayer = AudioPlayer();

   bool isDark = true;
   void changeMode(){
     setState(() {
       isDark = false;
     });
   }

     Future<List<Beat>> _fetchData(http.Client client) async {
    var response =  await client.get('https://beatrecoder.pythonanywhere.com/api/beats/');
    //  this line below check if statust code is not EQUAL to 404(404 is a statuscode for data not found )
    if(response.statusCode == 200){
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((beat) => Beat.fromJson(beat)).toList();
    }else{
      throw Exception('Failed to get data');
    }
 
  }
  @override
  Widget build(BuildContext context) {
    return Theme(
      data:isDark? ThemeData(brightness:Brightness.dark):ThemeData(brightness:Brightness.light),
      child: Scaffold(
        backgroundColor: Colors.teal,
        // appBar: AppBar(
        //   title:Text('Beats'),
        //   actions: <Widget>[
        //     isDark?IconButton(onPressed: (){
        //       setState(() {
        //         isDark = false;
        //       });
        //     }, icon: Icon(Icons.lightbulb_outline),):IconButton(onPressed: (){
        //       setState(() {
        //         isDark = true;
        //       });
        //     }, icon: Icon(Icons.lightbulb_outline),)
        //   ],
        // ),
        drawer: Drawer(
          child: DrawerItems(),
        ),
        body:Container(
          child:FutureBuilder(
            future: _fetchData(http.Client()),
            builder: (BuildContext context , AsyncSnapshot snapshot){
              List<Beat> data = snapshot.data;
              if(snapshot.hasData){
                 return ListView.builder(
                itemCount:data.length,
                itemBuilder: (context, i){
                  return Card(
              color:Colors.teal[800],
              elevation:4.0,
              child:InkWell(
              onTap:()
              //   await audioPlayer.play(data[i].beat,);
              // },
              =>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Play(
                  beat: data[i].beat,
              ))),
                child:ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(data[i].img,),
              ),
              title: Text(data[i].producer),
              subtitle: Text(data[i].title,),
              trailing: IconButton(icon: Icon(Icons.more_vert,color: Colors.lightBlueAccent,), 
              onPressed:(){
              showDialog(
                context: context,
                builder: (context){
                 return AlertDialog(
              //  backgroundColor: Colors.grey[700],
              backgroundColor: Colors.teal,
               title: Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("EXPLORE", style: TextStyle(color: Colors.white),),
              SizedBox(width:30),
              IconButton( color: Colors.lightBlueAccent, icon:FaIcon(FontAwesomeIcons.backspace), 
              onPressed: ()=> Navigator.of(context).pop(),
              )
            ],
          ),
          content: Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children:<Widget>[
              FlatButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Play(
                beat: data[i].beat,
              ))).whenComplete(
                Navigator.of(context).pop
              ), 
              child:Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:<Widget>[
                  Text('PLAY',style: TextStyle(color: Colors.white)),
                   Icon(Icons.play_arrow, color: Colors.lightBlueAccent,)
                ]
                )
                ),
              FlatButton(onPressed: () =>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Record(
                beat: data[i].beat,
              ))), 
              child: Row(
                mainAxisAlignment:MainAxisAlignment.start,
                children:<Widget>[
                  Text('RECORD', style: TextStyle(color: Colors.white)),
                  SizedBox(width:10),
                  FaIcon(FontAwesomeIcons.microphone, color: Colors.lightBlueAccent,)
                ]
              ))
            ]
          )
        );
      }
      );
  
              }),
            )
              )
            );
                },
              );
              }else if(snapshot.hasError){
                return Center(child:Text('${snapshot.error}'));
              }else{
                return Center(child:CircularProgressIndicator());
              }
             
            },
          )
        )
    ),
    );
  }

  }


