import 'package:flutter/material.dart';
import 'package:football_fields_system/screens/Field-schedule.dart';
import 'package:football_fields_system/services/Provider.dart';
import 'package:football_fields_system/widget&constants/widgets.dart';

// ignore: must_be_immutable
class FieldScreen extends StatefulWidget {

  PlaygroundModel playgroundModel = PlaygroundModel();
  FieldScreen({this.playgroundModel});

  @override
  _FieldScreenState createState() => _FieldScreenState();
}

class _FieldScreenState extends State<FieldScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.playgroundModel.name),
              background: Image.asset(
                'images/Soccerfield-at-Night.jpg', fit: BoxFit.cover,),
            ),
          ),
          SliverFillRemaining(
            child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Description',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        Text(widget.playgroundModel.description,
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 13.0,
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 20),
                          child: Divider(thickness: 1.5,),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            SizedBox(width: MediaQuery
                                .of(context)
                                .size
                                .width / 11.5,),
                            CardDetails(
                              title: 'Owner',
                              content: widget.playgroundModel.owner.toString(),
                            ),
                            SizedBox(width: MediaQuery
                                .of(context)
                                .size
                                .width / 3,),
                            CardDetails(
                              title: 'Price',
                              content: widget.playgroundModel.price.toString(),
                            ),
                          ],
                        ),
                        SizedBox(height: 40,),
                        Row(
                          children: [
                            SizedBox(width: MediaQuery
                                .of(context)
                                .size
                                .width / 11.5,),
                            CardDetails(
                              title: 'Owner Phone',
                              content: '0100231561919',
                            ),
                            SizedBox(width: MediaQuery
                                .of(context)
                                .size
                                .width / 4.5,),
                            CardDetails(
                              title: 'Address',
                              content: widget.playgroundModel.address,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          child: Divider(thickness: 1.5,),
                        ),
                        Text('Field Rating',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 15.0,),
                        buildRatingBar(),
                        TextButton(onPressed: () {}, child: Text('Rate',
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 15,
                          ),
                        ),
                        ),
                        SizedBox(height: 10,),
                        AuthButton(
                          text: 'See Field schedule',
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => FieldTable(playgroundID: widget.playgroundModel.id,)));
                          },
                        ),
                      ],
                    ),
                  ],
                )
            ),
          ),
        ],
      ),
    );
  }
}
