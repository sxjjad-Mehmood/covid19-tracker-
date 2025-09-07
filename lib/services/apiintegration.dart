import 'dart:convert';
import 'package:covid_app/Models/DataModel.dart';
import 'package:covid_app/services/apilist.dart';
import 'package:http/http.dart'as http;
class Api {
  Future<DataModel> getapi() async{
    var response= await http.get(Uri.parse(appurl.Wordstate));
    var data=jsonDecode(response.body.toString());

    if(response.statusCode==200){

      return DataModel.fromJson(data);
    }
    else{
    throw Exception("error");
    }

  }
  Future<List<dynamic>> getcounties() async{
    var response=await http.get(Uri.parse(appurl.countries));

    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      return data;
    }
    else{
     throw Exception("error");
    }
  }

}