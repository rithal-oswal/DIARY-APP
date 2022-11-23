import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'connection.dart';
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
class addentry extends StatefulWidget {
  const addentry({Key? key}) : super(key: key);

  @override
  State<addentry> createState() => _addentryState();
}
class _addentryState extends State<addentry> {
  String? message,title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new Entry"),
        centerTitle: true,
      ),
      body: Form(
        key:_formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0,20, 0,20),
              child: TextFormField(
                minLines: 1,
                maxLines: 3,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Title',
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(100),
                ],
                onSaved: (value) => title = value,
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              cursorColor: Color(0xFF3C4858),
              decoration: InputDecoration.collapsed(
                  hintText:
                  'Add Content'),

              onSaved: (value) => message = value,
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: () async {
                _formKey.currentState!.save();
                addnewnotes(title,message);
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildPopupDialog(context),
                );
              },
              child: Container(
                height: 45,
                child: Material(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.blue[800],
                  elevation: 7,
                  child: Center(
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
            "Your notes are saved. \n go to view entries to view."),
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