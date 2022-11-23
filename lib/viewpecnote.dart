
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'connection.dart';
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class viewspecnotes extends StatefulWidget {
  String date,title,content,time;
  viewspecnotes({Key? key,required this.date,required this.title,required this.content,required this.time}) : super(key: key);

  @override
  State<viewspecnotes> createState() => _viewspecnotesState();
}

class _viewspecnotesState extends State<viewspecnotes> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("DIARY"),
        centerTitle: true,
      ),
      body:ListTile(
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 3.0),
              Stack(
                children:[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.date}',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      IconButton(onPressed:(){

                        editordeletenotes(widget.date,widget.title,widget.content,widget.time,"delete");
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => _buildPopupDialog(context),
                        );
                      }, icon: Icon(Icons.close, color:Colors.grey, ),
                        alignment: Alignment.center,    ),

                    ],
                  ),
                  Form(
                    child: Column(children: [
                        Padding(

                          padding: EdgeInsets.fromLTRB(0,20, 0,20),
                          child: TextFormField(
                            initialValue: widget.title,
                            minLines: 1,
                            maxLines: 3,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
                            textAlign: TextAlign.center,
                            onSaved: (String? value) {
                              widget.title = value!;
                            },
                          ),
                        ),
                        TextFormField(
                          initialValue: widget.content,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                          onSaved: (String? value) {
                           widget.content = value!;
                          },
                        ), SizedBox(height: 20,),

                      RaisedButton(
                        onPressed: (){
                          _formKey.currentState?.save();
                          print(widget.title);
                          editordeletenotes(widget.date,widget.title,widget.content,widget.time,"edit");
                        },
                        color: Colors.blue,
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),

                      ),
                ],
              ),
                  ),

            ],
          ),


],
    ),
        ),)
    );
  }
}
Widget _buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    // title: const Text('Popup example'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            "Your note is deleted"),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme
            .of(context)
            .primaryColor,
        child: const Text('Close'),
      ),
    ],
  );
}