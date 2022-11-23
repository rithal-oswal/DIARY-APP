import 'dart:convert';
import 'package:bugsmirror/viewpecnote.dart';
import 'package:flutter/material.dart';
import 'connection.dart';
class viewentry extends StatefulWidget {
  final String notes;
  const viewentry(
      {Key? key, required this.notes})
      : super(key: key);
  @override
  State<viewentry> createState() => _viewentryState();
}

class _viewentryState extends State<viewentry> {
  List notes=[];
  void initState() {
    notes = json.decode(widget.notes) as List;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("past Entries"),
        centerTitle: true,
      ),
      body:(notes.length>0)?ListView.builder(
        // scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: notes.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 3.0),
                    Card(

                      margin: EdgeInsets.all(2),
                      child: Stack(
                        children:[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(onPressed:(){
                                Navigator.push(context, MaterialPageRoute(builder: (_) => viewspecnotes(date:notes[index]["date"],title:notes[index]["title"],content:notes[index]["content"],time:notes[index]["time"])));

                              }, icon: Icon(Icons.edit, color:Colors.grey, ),
                                alignment: Alignment.center,    ),
                              IconButton(onPressed:(){

                                editordeletenotes(notes[index]["date"],notes[index]["title"],notes[index]["content"],notes[index]["time"],"delete");
                                setState(() =>( notes.removeAt(index)));

                                 }, icon: Icon(Icons.close, color:Colors.grey, ),
                                alignment: Alignment.center,    ),
                            ],
                          ),
                          Positioned(child: Column(children: [
                            Text(
                              '${notes[index]["date"]}',
                              style: TextStyle(
                                  fontSize: 20,

                                  color: Colors.black),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              '${notes[index]["title"]}',
                              style: TextStyle(
                                  fontSize: 33,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],)),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }):Center(child:Text("No Notes has been added", style: TextStyle(color: Colors.red,fontSize: 20)),
    ),);
  }
}


