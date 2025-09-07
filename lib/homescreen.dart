import 'package:covid_app/Models/DataModel.dart';
import 'package:covid_app/countriespage.dart';
import 'package:covid_app/services/apiintegration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> with TickerProviderStateMixin{
  late final AnimationController controller=AnimationController(vsync: this,duration: Duration(seconds: 2))..repeat();
  void dispose(){
    super.dispose();
    controller.dispose();
  }
  @override
    List <Color>colorslist=[
    Colors.green,
    Colors.red,
    Colors.blue
  ];
Api api=Api();
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black12,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Expanded(

                  child: FutureBuilder(

                    future: api.getapi(),
                      builder: (context,AsyncSnapshot<DataModel> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: SpinKitCircle(
                              size: 70,
                              controller: controller,
                              color: Colors.white30
                            ),
                          );
                        }
                        else {
                          return Column(
                            children: [
                          PieChart(
                          dataMap: {"Cases": double.parse(
                          snapshot.data!.cases.toString()),
                          "Deaths": double.parse(
                          snapshot.data!.deaths.toString()),
                          "Recovered": double.parse(
                          snapshot.data!.recovered.toString())
                          },

                            colorList: colorslist,
                            legendOptions: LegendOptions(
                              legendTextStyle: TextStyle(
                                  color: Colors.white, fontSize: 20),
                              legendPosition: LegendPosition.left,
                              legendShape: BoxShape.rectangle,

                            ),
                            chartRadius: 200,
                            chartType: ChartType.ring,
                            chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            chartLegendSpacing: 50,


                          ),
                          SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.08,
                          ),
                          Card(

                            color: Colors.brown.shade900,
                            child: Column(
                              children: [
                                reusablerow(title: "Todaycases",
                                  value: snapshot.data!.todayCases.toString(),),
                                reusablerow(title: "Active",
                                    value: snapshot.data!.active.toString()),
                                reusablerow(title: "Critical",
                                    value: snapshot.data!.critical.toString()),
                                reusablerow(title: "Population",
                                    value: snapshot.data!.population
                                        .toString()),
                                reusablerow(title: "AffectedCountries",
                                    value: snapshot.data!.affectedCountries
                                        .toString()),
                                reusablerow(title: "Updated",
                                    value: snapshot.data!.updated.toString()),

                              ],
                            ),
                          ),
                              SizedBox(height: 15,),
                              InkWell(

                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade900,
                                    borderRadius: BorderRadius.circular(10),

                                  ),
                                  child: Text("Track Countries",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                                  height: 50,
                                  width: 300,
                                  alignment: Alignment.center,
                                ),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => countries()));
                                },
                              )
                            ],
                          );

                        }
                      }
                  ),
                ),


              ],
            ),
          ),
        )
      )
    );
  }
}
class reusablerow extends StatelessWidget {
  String title,value;
  reusablerow({super.key,required this.title,required this.value});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height *.03),
      child: Column(
        children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,style: TextStyle(color:Colors.white ,fontSize: 20),),
            Text(value,style: TextStyle(color: Colors.white,fontSize: 20),),
          ],

        ),

          Divider(
            color: Colors.grey.shade50,
          ),
      ],
      ),
    );
  }
}
