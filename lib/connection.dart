import 'dart:convert';
import 'package:http/http.dart' as http;
viewnotes()async{
  var url = Uri.parse('http://192.168.0.129:8080/viewallnotes');
  var response = await http.post(url);
  return(response.body);
}
editordeletenotes(date,title,content,time,url1)async{
  var url = Uri.parse('http://192.168.0.129:8080/$url1');
  var response =
  await http.post(url, body:{
    "date":date,"title":title,"content":content,"time":time,
  }
  );
}
addnewnotes(title,message)async{
  String info;
  var url = Uri.parse('http://192.168.0.129:8080/addnotes');
  var response = await http.post(url, body: {"title":title,"content":message,});

}
