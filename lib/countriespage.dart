
import 'package:covid_app/detalis.dart';
import 'package:covid_app/services/apiintegration.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class countries extends StatefulWidget {
  const countries({super.key});

  @override
  State<countries> createState() => _countriesState();
}
TextEditingController screencontrol = TextEditingController();
class _countriesState extends State<countries> {

  Api api=Api();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          actions: [
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },

                child: Icon(Icons.arrow_back))

          ],
          backgroundColor: Colors.black,

        ),
        body:SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height: 10,),
                TextField(
                  controller:screencontrol,
                 onChanged: (value)
                 {
                    setState(() {

                    });
                 },
                  style: TextStyle(color: Colors.white,fontSize: 20),
                  decoration: InputDecoration(
                      hintText: "Search For The Countries",

                      suffixIcon: Icon(Icons.search,color: Colors.grey,),
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                              color: Colors.grey,
                              width: 5
                          ),
                      ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.brown)
                    )

                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                      future:api.getcounties() ,
                      builder:( context,AsyncSnapshot<List<dynamic>> snapshort){
                        if(!snapshort.hasData){
                          return Shimmer.fromColors(child:ListView.builder(
                              itemCount: 4,
                              itemBuilder: (context,index){

                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading:Container(height:50,width: 50,color: Colors.white,),
                                        title: Container(height:10,width: 80,color: Colors.white,),
                                        subtitle: Container(height:10,width: 80,color: Colors.white,),

                                      )
                                    ],
                                  ),
                                );
                              }

                          ),
                              baseColor: Colors.grey.shade900, highlightColor: Colors.grey.shade100);
                        }
                        else{
                          return ListView.builder(
                              itemCount: snapshort.data!.length,

                              itemBuilder: (context,index) {
                                String  name = snapshort.data![index]['country'];
                                if (screencontrol.text.isEmpty) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap:(){
                                          Navigator.push(context, MaterialPageRoute(builder:(context) =>
                                              detalis(
                                              country:snapshort.data![index]['country'].toString(),
                                            cases: snapshort.data![index]['cases'].toString(),
                                                deaths: snapshort.data![index]['deaths'].toString(),
                                                todayDeaths: snapshort.data![index]['todayDeaths'].toString(),
                                                recovered: snapshort.data![index]['recovered'].toString(),
                                                active: snapshort.data![index]['active'].toString(),
                                            critical:snapshort.data![index]['critical'].toString(),
                                            image: snapshort.data![index]['countryInfo']['flag'].toString(),




                                          )

                                          ));
                                  },
                                        child: ListTile(

                                          leading: Image(
                                              height: 50,
                                              width: 50,
                                              image: NetworkImage(snapshort.data![index]['countryInfo']['flag'])),
                                          title: Text(snapshort.data![index]["country"]),
                                          subtitle: Text("Cases :" + snapshort.data![index]['cases'].toString()),
                                          textColor: Colors.white,
                                          trailing: Text("Deaths " + snapshort.data![index]['deaths'].toString()),
                                          style: ListTileStyle.list,



                                        ),
                                      ),
                                    ],
                                  );
                                }else if (name.toLowerCase().contains(screencontrol.text.toLowerCase())){
                                  return  Column(
                                    children: [
                                      InkWell(
                                        onTap:(){
                                          Navigator.push(context, MaterialPageRoute(builder:(context) =>
                                              detalis(
                                                country:snapshort.data![index]['country'].toString(),
                                                cases: snapshort.data![index]['cases'].toString(),
                                                deaths: snapshort.data![index]['deaths'].toString(),
                                                todayDeaths: snapshort.data![index]['todayDeaths'].toString(),
                                                recovered: snapshort.data![index]['recovered'].toString(),
                                                active: snapshort.data![index]['active'].toString(),
                                                critical:snapshort.data![index]['critical'].toString(),
                                                image: snapshort.data![index]['countryInfo']['flag'].toString(),




                                              )

                                          ));
                                        },
                                        child: ListTile(

                                          leading: Image(
                                              height: 50,
                                              width: 50,
                                              image: NetworkImage(snapshort.data![index]['countryInfo']['flag'])),
                                          title: Text(snapshort.data![index]["country"]),
                                          subtitle: Text("cases :" + snapshort.data![index]['cases'].toString()),
                                          textColor: Colors.white,
                                          trailing: Text("Deaths " + snapshort.data![index]['deaths'].toString()),
                                          style: ListTileStyle.list,



                                        ),
                                      ),
                                    ],
                                  );
                                }else{
                                   return Container();
                                }
                              }
                          );
                        }
                      }
                  ),
                )
              ],
            ),
          ),
        ),
      ) ,
    );

  }
}
