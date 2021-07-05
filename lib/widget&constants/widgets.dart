import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'constants.dart';

class AuthTextField extends StatelessWidget {

  AuthTextField({this.hintText,this.icon,this.obscure,this.onChanged});
  final hintText;
  final icon;
  final  obscure;
  final onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      obscureText: obscure,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(0xff6c6e7b),
          ),
          prefixIcon: icon,
          filled: true,
          fillColor:Color(0xffddddde),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: Colors.transparent)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(15.0),
          )
      ),
    );
  }
}

class AuthButton extends StatelessWidget {

  AuthButton({this.text,this.onPressed});
  final text;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(text,
        style: TextStyle(color: Colors.white),
      ),
      minWidth: MediaQuery.of(context).size.width,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
      ),
      color: Colors.teal,
      height: 60.0,
    );
  }
}

class AccountCard extends StatelessWidget {

  AccountCard({this.image,this.text,this.color});
  final image;
  final text;
  final color;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          color:color,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child:Column(
          children: [
            Image.asset(image),
            SizedBox(height: 10.0,),
            Text(text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        )
    );
  }
}

class FieldCard extends StatelessWidget {

  FieldCard({this.image,this.name,this.address,this.price,this.onTap});
  final image ;
  final name;
  final address;
  final price;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          elevation: 7,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20), ),
                child: Image.asset(
                  image,
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 7,),
              Padding(padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 5,),
                        Text( name,
                          style:TextStyle(
                              color: Colors.black87,
                              fontFamily: 'Roboto',
                              fontSize: 18
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.pin_drop_outlined,color: Colors.black26,),
                        SizedBox(width: 5,),
                        Text( address,
                          style: TextStyle(
                              color: Colors.black26,
                              fontFamily: 'Roboto',
                              fontSize: 14
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        RatingBar.builder(
                          itemSize: 20,
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal:0.5),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        Spacer(),
                        Text( price,
                          style: TextStyle(
                              color: Colors.teal,
                              fontFamily: 'Roboto',
                              fontSize: 15
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CardDetails extends StatelessWidget {

  final title;
  final content;
  CardDetails({this.content,this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
          style: TextStyle(
            fontSize: 20,
            foreground: Paint()..shader = klinearGradient,
          ),
        ),
        SizedBox(height: 10.0,),
        Text( content,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}

class ContactsCard extends StatelessWidget {

  final email;
  final phoneNumber;
  ContactsCard({this.email,this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 15.0,top: 13.0,bottom: 20,right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(7)),
        color: Colors.white,
        boxShadow: [BoxShadow(blurRadius: 3, color: Colors.black26, spreadRadius: 1)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contacts',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20.0,),
          Row(
            children: [
              SizedBox(width: 20.0,),
              Text( phoneNumber,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ],
          ),
          Divider(thickness: 1,),
          SizedBox(height: 5,),
          Row(
            children: [
              SizedBox(width: 20.0,),
              Text(email,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

RatingBar buildRatingBar() {
  return RatingBar.builder(
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
  );
}
