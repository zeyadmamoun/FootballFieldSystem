import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:football_fields_system/services/Provider.dart';
import 'package:football_fields_system/widget&constants/constants.dart';
import 'package:football_fields_system/widget&constants/widgets.dart';
import 'package:provider/provider.dart';

class PlayerProfileScreen extends StatefulWidget {
  @override
  _PlayerProfileScreenState createState() => _PlayerProfileScreenState();
}

class _PlayerProfileScreenState extends State<PlayerProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight:Radius.circular(30)),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.blue,
                      Colors.teal,
                    ],
                  )
              ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height/5.5,
                  width: MediaQuery.of(context).size.width,
                ),
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
                Text(Provider.of<UserModelUsed>(context).usedUserModel.username,
                  style: TextStyle(
                     fontSize: 30.0,
                     fontWeight: FontWeight.normal,
                     foreground: Paint()..shader = klinearGradient,
                  ),
                ),
                SizedBox(height: 5.0,),
                Text(Provider.of<UserModelUsed>(context).usedUserModel.email,
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/20,),
                Column(
                  children: [
                    ContactsCard(
                      email: Provider.of<UserModelUsed>(context).usedUserModel.email,
                      phoneNumber: Provider.of<UserModelUsed>(context).usedUserModel.phone,
                    ),
                    SizedBox(height: 20.0,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(left: 15.0,top: 7.0,bottom: 5.0,right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        color: Colors.white,
                        boxShadow: [BoxShadow(blurRadius: 3, color: Colors.black26, spreadRadius: 1)],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Player Rating',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 15.0,),
                          RatingBar.builder(
                            glow: true,
                            itemSize: 30,
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal:0.3),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          TextButton(onPressed: (){},
                            child: Text('Rate',
                            style: TextStyle(
                              color: Colors.teal,
                              fontSize: 15,
                            ),
                          ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
