import 'package:bit_recorder/pages/beats/beats.dart';
import 'package:bit_recorder/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      title: 'Music Beat',
      home: LoginPage(),
       
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool userIn = false;
  bool isLoaging = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<FirebaseUser> _handleSignIn() async {
  GoogleSignInAccount googleUser = await googleSignIn.signIn();
  GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  final AuthResult authResult = await _auth.signInWithCredential(credential);
  FirebaseUser user = authResult.user;
  print("signed in " + user.displayName);

  setState(() {
    userIn = true;
  
  });

 setState(() {
   isLoaging =true;
 });

  return user;

}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       home:  Scaffold(
        backgroundColor: Colors.teal,
           body:Stack(
             children:<Widget>[
               Container(
                 height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                   decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("images/4.jpg")
                  )
                ),
               ),
               Container(
                 width: MediaQuery.of(context).size.width,
                 margin: EdgeInsets.only(top:80),
                //  alignment: Alignment.topCenter,
                 child:Card(
                   
                   color:Colors.transparent,
                   child: Padding(padding: EdgeInsets.only(left:30),
                    child: Text('Automated Music Beat \n \t Generation System ',
                  style: TextStyle(fontSize: 30, fontWeight:FontWeight.w900, color: Colors.black),
                 ),
                   )
                 )
               ),
          //      Container(
          //        alignment: Alignment.center,
          //        child: FaIcon(FontAwesomeIcons.microphoneAlt,size: 250,color: Colors.lightBlueAccent,),
           
          //    height: MediaQuery.of(context).size.height,
          //  ),
             Container(
               
               height: 80,
               
               margin:EdgeInsets.only(top:550, bottom: 50, left: 30, right: 30),
               decoration: BoxDecoration(
                 color:Colors.white,
                 borderRadius:BorderRadius.all(Radius.circular(50))
               ),
               child: FlatButton(
                 highlightColor: Colors.teal,
                 color: Colors.transparent,
                   onPressed: () => _handleSignIn().then((FirebaseUser user) => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()))),
                   child:Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: <Widget>[
                       Text('Sign In With ', style: TextStyle(color:Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),),
                      //  Image(image: AssetImage('images/g2.png'))
                      FaIcon(FontAwesomeIcons.google, color: Colors.blue,)
                     ],
                   )
                 )
             )
             ]
           )
         )
    );
  }
}
