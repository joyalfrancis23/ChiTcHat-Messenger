import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../pickers/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);

  final Color logoGreen = Color(0xff25bcbb);
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  BuildContext ctx;
  var _isSignUp = false;
  File _userImage;
  void _imagePicker(File image){
    _userImage=image;
  }
  
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    _signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    final User user =
        ((await _auth.signInWithCredential(credential)).user);
        if(user.emailVerified){
         Navigator.pushReplacementNamed(context,'/chatScreen');
        }else{
          print("Cannot verify your gmail credentials");
        }
        
  }
  Future<void> _signIn ()async{
    try{
    print(nameController.toString());
    print(passwordController.toString());
    UserCredential firebaseuser = await FirebaseAuth.instance.signInWithEmailAndPassword(email: nameController.text.trim(), password: passwordController.text.trim());
    Navigator.pushReplacementNamed(context,'/chatScreen');
    print(firebaseuser.user);
    }catch(e){
      print(e.message);
    }
  }
  Future<void> _signUp()async{
    print(_isSignUp);
    if(_userImage==null){
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: Text('Please pick an image'),));
    }
    try{
      UserCredential _signUpUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: nameController.text, password: passwordController.text,);

      final imagePath=FirebaseStorage.instance.ref().child('user_images').child(_signUpUser.user.uid+'.jpg');
      await imagePath.putFile(_userImage);
      final _imageUrl=await imagePath.getDownloadURL();

      Navigator.pushReplacementNamed(context,'/chatScreen');
      await FirebaseFirestore.instance.collection('userAccounts').doc(_signUpUser.user.uid).set({
        'username' : usernameController.text,
        'email' : nameController.text,
        'password' : passwordController.text,
        'image_url' : _imageUrl,
      });
      
      print(_signUpUser.user);
    }
    catch(e){
      print(e.message);
      return ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: Text(e.message)));
    }
    
  }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: primaryColor,
        body: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RichText(text: TextSpan(text:'Sign in to ',style: GoogleFonts.raleway(
          color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),
        children: <TextSpan>[
          TextSpan(
            text:'Chit',
            style: GoogleFonts.raleway(color: Colors.cyan,fontWeight: FontWeight.bold,fontSize: 15),
          ),
          TextSpan(
            text:'cHat',
            style: GoogleFonts.raleway(color: Colors.amber,fontWeight: FontWeight.bold,fontSize: 19),
          ),
          TextSpan(
            text:' and Continue',
            style: GoogleFonts.raleway(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),
          ),
        ]
        ),
        ),
                SizedBox(height: 5),
                Text(
                  'Enter your email and password below to continue and let the conversations begin!',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 14),
                ),
                SizedBox(
                  height: 20,
                ),
                
                if(_isSignUp)
                  SizedBox(child: ImagePickersection(_imagePicker)),
                
                SizedBox(height: 8,),
                if(_isSignUp)
                  _buildTextField(
                    usernameController, Icons.person_outline_rounded, 'Username'),
                SizedBox(height: 20),
                _buildTextField(
                    nameController, Icons.mail_outline_rounded, 'E-mail'),
                SizedBox(height: 20),
                _buildTextField(passwordController, Icons.lock, 'Password'),
                SizedBox(height: 30),
                MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 50,
                  onPressed: _isSignUp?_signUp:_signIn,
                  color: logoGreen,
                  child: Text(_isSignUp?'Sign-up':'Login',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  textColor: Colors.white,
                ),
                SizedBox(height: 20),
                MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 50,
                  onPressed: _signInWithGoogle,
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.google),
                      SizedBox(width: 10),
                      Text('Sign-in using Google',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ],
                  ),
                  textColor: Colors.white,
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: (){
                    setState(() {
                       _isSignUp = !_isSignUp;
                       usernameController.clear();
                       nameController.clear();
                       passwordController.clear();
                     });
                  },
                   child:Text(_isSignUp?'Already have an account? then Login':'Don\'t have an account? then Sign In.') ,
                   ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _buildFooterLogo(),
                )
              ],
            ),
          ),
        ));
  }

  _buildFooterLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        RichText(text: TextSpan(text:'ChiT',style: GoogleFonts.raleway(
          color: Colors.cyan,fontWeight: FontWeight.bold,fontSize: 15),
        children: <TextSpan>[
          TextSpan(
            text:'cHat',
            style: GoogleFonts.raleway(color: Colors.amber,fontWeight: FontWeight.bold,fontSize: 25),
          ),
          TextSpan(
            text:'  Messenger',
            style: GoogleFonts.raleway(color: Colors.white,)      
          )
        ]
        ),
        )
      ],
    );
  }

  _buildTextField(
      TextEditingController controller, IconData icon, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: secondaryColor, border: Border.all(color: Colors.blue)),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.white),
            icon: Icon(
              icon,
              color: Colors.white,
            ),
            // prefix: Icon(icon),
            border: InputBorder.none),
      ),
    );
  }
}