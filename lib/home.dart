import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic>data = [];
  Future<void>getData()async{
    http.Response response = await http.get(Uri.parse("http://www.mocky.io/v2/5d565297300000680030a986"));
  setState(() {
    if(response.statusCode == 200){
      var responseData = json.decode(response.body);
      data=responseData;
      print("responseData");
    }
  });
  }
  @override
  void initState(){
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor:Colors.cyan.shade700,
      title: Text("Employee List"),
    ),
      body:SafeArea(
          child:ListView.builder(
            itemBuilder:(ctx,index){
              return ListTile(
                title: Text(data[index]['name'] ??'',),
                subtitle: Text(data[index]['email']??'',),
                leading: CircleAvatar(radius: 30,backgroundColor: Colors.white,
                  backgroundImage:
                  NetworkImage(data[index]['profile_image']??'',),
                ),
              );
            },
itemCount:data.length,
      )

    ),

    );
  }
}
