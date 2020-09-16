import 'package:bit_recorder/pages/beats/beats.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DrawerItems extends StatefulWidget {
  @override
  _DrawerItemsState createState() => _DrawerItemsState();
}

class _DrawerItemsState extends State<DrawerItems> {
   bool isDark = true;
   void changeMode(){
     setState(() {
       isDark = true;
     });
   }
   final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
           decoration: BoxDecoration(
           color: Colors.teal,
          ),
          currentAccountPicture: CircleAvatar(
            backgroundImage:NetworkImage("${user?.photoUrl}")
          ),
          accountName: Text("${user?.displayName}"),
           accountEmail: Text("${user?.email}")
           ),
          Card(
             color: Colors.teal,
            elevation:1.0,
            child: ListTile(
             leading:CircleAvatar(
                backgroundColor: Colors.black45,
               child: Icon(Icons.featured_play_list),),
             title:Text('Your Music'),
             subtitle: Text('7 tracks'),
           )
          ),
           InkWell(
             onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Beats())),
             child: Card(
                color: Colors.teal,
            elevation:1.0,
            child: ListTile(
             leading:CircleAvatar(
                backgroundColor: Colors.black45,
               child: Icon(Icons.music_note, color: Colors.lightBlueAccent,),),
             title:Text('Available Beats'),
              
           )
          ),
           ),
           Card(
              color: Colors.teal,
            elevation:1.0,
            child: ListTile(
             leading:CircleAvatar(
                backgroundColor: Colors.black45,
               child: Icon(Icons.settings,color: Colors.lightBlueAccent,),),
             title:Text('settings')
             
           )
          ),
            Card(
               color: Colors.teal,
            elevation:1.0,
            child: WillPopScope(
              onWillPop: (){},
              child:InkWell(
                onTap: (){
                  _signOut();
                  SystemNavigator.pop();
                },
                child:ListTile(
             leading:CircleAvatar(
                backgroundColor: Colors.black45,
               child: FaIcon(FontAwesomeIcons.signOutAlt,color: Colors.lightBlueAccent,),),
             title:Text('Log out')
              ),
              )
             
           )
          ),
           InkWell(
             onTap: ()=> Navigator.of(context).pop(),
              child: Card(
              color: Colors.teal,
              child:ListTile(
                leading:CircleAvatar(
                  backgroundColor: Colors.black45,
                  child: FaIcon(FontAwesomeIcons.times,color: Colors.lightBlueAccent, size: 25,),
                ),
                title: Text("close"),
              )
          ),
           )
      ],
      
    );
  }
  void _signOut(){
   googleSignIn.signOut();
   print('user sign out');
 }
}