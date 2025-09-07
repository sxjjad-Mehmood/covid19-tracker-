import 'package:covid_app/homescreen.dart';
import 'package:flutter/material.dart';

class detalis extends StatefulWidget {

      String country;
  String cases;
  String deaths;
      String todayDeaths;
      String recovered;
      String active;
      String critical;
      String image;

      detalis(
          {
 required this.country,
  required this.cases,
  required this.deaths,
  required this.todayDeaths,
  required this.recovered,
  required this.active,
  required this.critical,
  required this.image
  }
  );

  @override
  State<detalis> createState() => _detalisState();
}

class _detalisState extends State<detalis> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
backgroundColor: Colors.black,
        appBar: AppBar(title:Text(widget.country),
        elevation: 10,
        automaticallyImplyLeading: true,
        actions: [
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          )
        ],
        backgroundColor: Colors.grey.shade700,
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 20),
        titleSpacing: 10,
        toolbarHeight: 100,
        centerTitle:true),
        body: SafeArea(
          child:  Column(
            mainAxisAlignment:MainAxisAlignment.center ,
            children: [
              Stack(
                alignment: Alignment.topCenter,
children: [
  Padding(
    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.09),
    child: Card(
      color: Colors.grey.shade900,
      child: Column(
        children: [
          reusablerow(title: "Cases", value: widget.cases.toString(),),
          reusablerow(title: "Deaths", value: widget.deaths.toString(),),
          reusablerow(title: "Active", value: widget.active.toString(),),
          reusablerow(title: "Recovered", value: widget.recovered.toString(),),
        ],
      ),
    ),
  ),
  CircleAvatar(
    radius: 50,
    backgroundImage: NetworkImage(widget.image),
  )
  
],
              )
            ],
          ),
        ),
      ),
    );
  }
}
