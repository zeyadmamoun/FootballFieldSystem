import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:football_fields_system/screens/bottom_sheet_screen.dart';
import 'package:football_fields_system/screens/owner_profile_extra_screen.dart';
import 'package:football_fields_system/services/Provider.dart';
import 'package:football_fields_system/widget&constants/constants.dart';
import 'package:football_fields_system/widget&constants/widgets.dart';
import 'package:provider/provider.dart';

class OwnerProfile extends StatefulWidget {

  @override
  _OwnerProfileState createState() => _OwnerProfileState();
}

class _OwnerProfileState extends State<OwnerProfile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight:Radius.circular(30) ),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.blue,
                    Colors.teal,
                  ],
                )
            ),
          ),//The gradiant container
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height/5.5,
                  width: MediaQuery.of(context).size.width,
                ),
                /////////Circle Avatar starts here/////////////
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black26, spreadRadius: 3)],
                  ),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person,color: Colors.lightBlue,size: 60,)
                  ),
                ),
                SizedBox(height: 10.0,),
                Text( Provider.of<UserModelUsed>(context,listen: false).usedUserModel.username,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.normal,
                    foreground: Paint()..shader = klinearGradient,
                  ),
                ),
                SizedBox(height: 5.0,),
                Text(Provider.of<UserModelUsed>(context,listen: false).usedUserModel.email,
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                ///////////circle avatar ends here
                SizedBox(height: MediaQuery.of(context).size.height/25,),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      ContactsCard(
                        email: Provider.of<UserModelUsed>(context,listen: false).usedUserModel.email,
                        phoneNumber: Provider.of<UserModelUsed>(context,listen: false).usedUserModel.phone,
                      ),
                      SizedBox(height: 20.0,),
                      MaterialButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>OwnerFieldsScreen()));
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        minWidth: MediaQuery.of(context).size.width,
                        color: Colors.teal,
                        child: Text('See all fields',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton:SpeedDial(
        backgroundColor:  Colors.teal,
        animatedIcon: AnimatedIcons.menu_arrow,
        children: [
          SpeedDialChild(
              labelWidget: Text('Log out   ',
                style: TextStyle(color: Colors.white),
              ),
              child: Icon(Icons.logout,color:  Colors.teal,),
              backgroundColor:Colors.white,
              onTap: (){
                Navigator.pop(context);
              }
          ),
          SpeedDialChild(
              labelWidget: Text('Add Field  ',
                style: TextStyle(color: Colors.white),
              ),
              child: Icon(Icons.add_rounded,color: Colors.teal,),
              backgroundColor:Colors.white,
              onTap: (){
                showModalBottomSheet(context: context, builder: (context)=> AddFieldScreen());
              }
          ),
        ],
      ),
    );
  }
}




