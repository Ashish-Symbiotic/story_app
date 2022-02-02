
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/utils/utils.dart';

class Mark_Attandance extends StatefulWidget {
  @override
  _Mark_AttandanceState createState() => _Mark_AttandanceState();
}

class _Mark_AttandanceState extends State<Mark_Attandance> {
 TextEditingController dateTimeController = new TextEditingController();
var dateFormat = DateFormat("dd-MM-yyyy");
 String dateText="";
 TextEditingController descController = new TextEditingController();


@override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    dateText = dateTimeController.text;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blue,
          body: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(
                    labelText: "Enter Date",
                    labelStyle: TextStyle(letterSpacing: 0,)
                  ),
                    onTap: (){
                    showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year),
                        lastDate: DateTime.now(),
                    ).then((value) => {
                    print(value),
                    setState(() {
                      dateTimeController.text = dateFormat.format(value!).toString();
                    })
                    });
                    },
                  controller: dateTimeController,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Enter Description",
                      labelStyle: TextStyle(letterSpacing: 0),
                    ),
                    controller:descController ,
                    onSubmitted:(value){
                      String? val="";
                    val = (value.isEmpty ?? "Not Provided any Value") as String?;
                      setState(() {
                        descController.text=val.toString();
                      });
                    }
                    ),

                ),
                ElevatedButton(onPressed: (){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(descController.text)));
                }, child: Text("Save Me"),),
              ],
            ),
          ),
        ),
    );
  }
}
