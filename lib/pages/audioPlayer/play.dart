import 'package:bit_recorder/pages/draweritems/drawer_items.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

class Play extends StatefulWidget {

  final String beat;
  final audio;

  Play({ this.beat, this.audio});

  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
  

  bool isPlaying  = false;
  
  AudioPlayer audioPlayer = AudioPlayer();
  String _currentTime = "00:00";
  String _completeTime = "00:00";
  
  @override
  void initState() {
    audioPlayer.play(widget.beat);
    audioPlayer.play(widget.audio);
    isPlaying=true;
    audioPlayer.onAudioPositionChanged.listen((Duration duration){
      setState(() {
        _currentTime = duration.toString().split(".")[0];
      });
    });

    audioPlayer.onDurationChanged.listen((Duration duration){
      setState(() {
        _completeTime = duration.toString().split(".")[0];
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: (){
           if (isPlaying) {
            audioPlayer.stop();
          }
          return new Future.value(true);
        },
        child:  Scaffold(
          backgroundColor: Colors.teal,
          appBar: AppBar(
            backgroundColor: Colors.teal,
            actions: <Widget>[
             Padding(
               padding: EdgeInsets.only(right: 40),
              //  child:  FloatingActionButton(
              //  backgroundColor: Colors.white,
              //  onPressed: () async{
              //    String filePath = await FilePicker.getFilePath();
              //    int status = await audioPlayer.play(filePath, isLocal: true, stayAwake: true);

              //     if(status == 1){
              //       setState(() {
              //         isPlaying = true;
              //       });
              //     }

              //  },
              //  child: Icon(Icons.add, color: Colors.teal,),
              //  ),
             )
            ],
          ),
          drawer: Drawer(
            child:DrawerItems()
          ),
      body: Stack(
        children:<Widget>[

          Container(
              margin: EdgeInsets.only(top:30),
              alignment:Alignment.topCenter,
              child:CircleAvatar(
              radius:150,
              backgroundColor: Colors.black54,
              // child: FaIcon(FontAwesomeIcons.headphonesAlt,size: 150,color: Colors.lightBlueAccent,),
              backgroundImage: AssetImage('images/7.jpg'),
            )
            ),
       
            Container(
              margin:EdgeInsets.only(top:450),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon:FaIcon(FontAwesomeIcons.backward,size: 20,color: 
                    Colors.lightBlueAccent,),
                    onPressed: (){},
                    ),
                    IconButton(
                    icon:isPlaying?FaIcon(FontAwesomeIcons.pause,size: 20,color: Colors.lightBlueAccent,):FaIcon(
                      FontAwesomeIcons.play,size: 20,color: Colors.lightBlueAccent,),
                    onPressed: () async{
                      //  await audioPlayer.play(widget.beat);
                      // setState(() {
                      //   isPlaying = true;
                      // });
                      if(isPlaying){
                        audioPlayer.pause();
                        setState(() {
                          isPlaying=false;
                        });
                      }else{
                        audioPlayer.resume();
                        setState(() {
                          isPlaying=true;
                        });
                      }
                    },
                    ),
                    IconButton(
                    icon:FaIcon(FontAwesomeIcons.stop,size: 20,color: Colors.lightBlueAccent,
                    ),
                    onPressed: ()async{
                      await audioPlayer.stop();
                      setState(() {
                        isPlaying = false;
                      });
                    },
                    ),
                    IconButton(
                    icon:FaIcon(FontAwesomeIcons.forward,size: 20,color: 
                    Colors.lightBlueAccent,),
                    onPressed: (){},
                    )
              ],)
            ),
            Container(
              margin: EdgeInsets.only(top:400),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:<Widget>[
                  Text(_currentTime, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                   Text(_completeTime,style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900), )
                ]
              ),
            ),
           Container(
              margin: EdgeInsets.only(top:520, left: 300),
             child: FloatingActionButton(
               backgroundColor: Colors.lightBlueAccent,
               onPressed: play,
               child: Icon(Icons.add),
               )
           )
        ]
      ),
    ),
    );
  }

  play () async{
    String filePath = await FilePicker.getFilePath();
      int status = await audioPlayer.play(filePath, isLocal: true);

      if(status == 1){
        setState(() {
          isPlaying = true;
        });
      }else{
        throw Exception('Error Playing');
      }
  }
}