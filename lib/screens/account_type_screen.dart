import 'package:flutter/material.dart';
import 'package:football_fields_system/screens/owner_signup.dart';
import 'package:football_fields_system/screens/player_Signup.dart';
import 'package:football_fields_system/services/Provider.dart';
import 'package:football_fields_system/widget&constants/constants.dart';
import 'package:football_fields_system/widget&constants/widgets.dart';
import 'package:provider/provider.dart';

enum AccountType {player, owner,}

class AccountTypeScreen extends StatefulWidget {

  @override
  _AccountTypeScreenState createState() => _AccountTypeScreenState();
}

class _AccountTypeScreenState extends State<AccountTypeScreen> {

  var activeColor = Color(0x721A615B);
  var inactiveColor = Color(0xFFD2D1D1);
  AccountType selectedType;
  int localIndicator;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20.0,right: 20.0,bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height/4,),
            Text("Choose \nYour Account Type",
              style: ktextStyle1,
            ),
            SizedBox(height: 40.0,),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(        //player card on tapped function
                    onTap: (){
                      setState(() {
                        selectedType = AccountType.player;
                        localIndicator =1;
                      });
                    },
                    child: AccountCard(
                      color: selectedType == AccountType.player? activeColor : inactiveColor,
                      image: 'images/soccer-player.png',
                      text: 'Player',
                    ),
                  ),
                ),
                SizedBox(width: 20.0,),
                Expanded(
                  child: GestureDetector(        //owner card on tapped function
                    onTap: (){
                      setState(() {
                        selectedType = AccountType.owner;
                        localIndicator=2;
                      });
                    },
                    child: AccountCard(
                      color: selectedType == AccountType.owner? activeColor : inactiveColor,
                      image: 'images/Group 1.png',
                      text: 'Owner',
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height/12,),
            AuthButton(
              text:'Confirm',
              onPressed: (){
                Provider.of<Indicator>(context,listen: false).changeIndicator(localIndicator);
                Provider.of<Indicator>(context,listen: false).setOwnerFlag(Provider.of<Indicator>(context,listen: false).indicator);
                if(selectedType == AccountType.player){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayerSignupScreen()));
                }else{
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>OwnerSignupScreen()));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}


