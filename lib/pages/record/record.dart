import 'dart:io';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:bit_recorder/pages/audioPlayer/play.dart';
import 'package:bit_recorder/pages/draweritems/drawer_items.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';


class Record extends StatefulWidget {

  final beat;
  Record({this.beat});

  @override
  _RecordState createState() => _RecordState();
}

class _RecordState extends State<Record> {
  bool isPlaying  = false;
   String statusText = "";
  bool isComplete = false;
  
  String _currentTime = "00:00";
  String _completeTime = "00:00";

  AudioPlayer audioPlayer = AudioPlayer();

                     
  @override
  void initState() {
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
    return  WillPopScope(
        onWillPop: (){
           if (isPlaying) {
            audioPlayer.stop();
            stopRecord();
          }
          return new Future.value(true);
        },
        child: Scaffold(
          backgroundColor: Colors.teal,
          appBar: AppBar(
            backgroundColor:Colors.transparent
          ),
          drawer: Drawer(
            child:DrawerItems()
          ),
        body: Stack(
          children: <Widget>[

            Container(
              margin: EdgeInsets.only(top:30),
              alignment:Alignment.topCenter,
              child:CircleAvatar(
              radius:150,
              backgroundColor: Colors.black54,
              // child: FaIcon(FontAwesomeIcons.microphoneAlt,size: 180,color: Colors.lightBlueAccent,),
              backgroundImage: AssetImage('images/mic.jpg'),
            )
            ),

            Container(
              margin: EdgeInsets.only(top:500),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                children:<Widget>[

                   IconButton(
                    icon:FaIcon(FontAwesomeIcons.backward,size: 20,color: 
                    Colors.lightBlueAccent,),
                    onPressed: (){},
                    ),
                    IconButton(
                    icon:isPlaying?FaIcon(FontAwesomeIcons.pause,size: 20,color: Colors.lightBlueAccent,):FaIcon(
                      FontAwesomeIcons.recordVinyl,size: 20,color: Colors.red,),
                    onPressed: () async{
                       await audioPlayer.play(widget.beat);
                       startRecord();
                      setState(() {
                        isPlaying = true;
                      });
                      
                    },
                    ),
                    IconButton(
                    icon:FaIcon(FontAwesomeIcons.stop,size: 20,color: Colors.lightBlueAccent,
                    ),
                    onPressed: ()async{
                      await audioPlayer.stop();
                      stopRecord();
                      setState(() {
                        isPlaying = false;
                      });
                      showDialog(context: context,
                      child: AlertDialog(
                        title: Text("File recorder at $recordFilePath",
                         style: TextStyle(fontSize: 15),
                        ),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.close), 
                              onPressed: (){
                                Navigator.of(context).pop();
                              }),
                              FlatButton(
                                onPressed:()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Play())), 
                              child: Row(
                                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                children:<Widget>[
                                  Text('Listen to it'),
                                  Icon(Icons.play_arrow)
                                ]
                              )
                              )
                          ],
                        ),
                      )
                      );
                      
                    },
                    ),
                    IconButton(
                    icon:FaIcon(FontAwesomeIcons.forward,size: 20,color: 
                    Colors.lightBlueAccent,),
                    onPressed: (){},
                    )

                ]
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:400),
              child:Row(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                children:<Widget>[
                  isPlaying==false?Text('PRESS RED BUTTON TO RECORD', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900)):
                   Text('RECORDING..', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900)),
                   
                ]
              )
            ),
            Container(
              margin: EdgeInsets.only(top:450),
              child:Row(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                children:<Widget>[
                  Text(_currentTime, style: TextStyle(color: Colors.lightBlueAccent, fontWeight: FontWeight.bold),),
                   Text(_completeTime,style: TextStyle(color: Colors.lightBlueAccent, fontWeight: FontWeight.w900), ),
                   
                ]
              )
            )
          ],
        ),
        
      ),
      
    );
  }
  
   Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      statusText = "Recording...";
      recordFilePath = await getFilePath();
      isComplete = false;
      RecordMp3.instance.start(recordFilePath, (type) {
        statusText = "Record error--->$type";
        setState(() {});
      });
    } else {
      statusText = "No microphone permission";
    }
    setState(() {});
  }

 void pauseRecord() {
    if (RecordMp3.instance.status == RecordStatus.PAUSE) {
      bool s = RecordMp3.instance.resume();
      if (s) {
        statusText = "Recording...";
        setState(() {});
      }
    } else {
      bool s = RecordMp3.instance.pause();
      if (s) {
        statusText = "Recording pause...";
        setState(() {});
      }
    }
  }


   void stopRecord() {
    bool s = RecordMp3.instance.stop();
    if (s) {
      statusText = "Record complete";
      isComplete = true;
      setState(() {});
    }
  }


  void resumeRecord() {
    bool s = RecordMp3.instance.resume();
    if (s) {
      statusText = "Recording...";
      setState(() {});
    }
  }

  String recordFilePath;

  void play() {
    if (recordFilePath != null && File(recordFilePath).existsSync()) {
      AudioPlayer audioPlayer = AudioPlayer();
      audioPlayer.play(recordFilePath, isLocal: true);
    }
  }

  int i = 0;



  Future<String> getFilePath() async {
    Directory storageDirectory = await getExternalStorageDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: false);
    }
  
    return sdPath + "/test_${i++}.mp3";
  }
 
}