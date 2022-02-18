import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:story_app/db/notes_database_service.dart';
import 'package:story_app/models/note.dart';
import 'package:story_app/routes/routes.dart';


class Mark_Attandance extends StatefulWidget {
  @override
  _Mark_AttandanceState createState() => _Mark_AttandanceState();
}

class _Mark_AttandanceState extends State<Mark_Attandance> {
 TextEditingController dateTimeController = TextEditingController();
var dateFormat = DateFormat("dd-MM-yyyy");
 String dateText="";
 TextEditingController descController = TextEditingController();
 TextEditingController typeController = TextEditingController();

 DatabaseService _db = DatabaseService();

 Future<int> _insertNotes(Notes n) async {
   return await _db.insertNote(n);
 }

 final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Enter Date",
                      labelStyle: TextStyle(letterSpacing: 0,fontWeight: FontWeight.w200)
                    ),
                      validator: (value){
                      if(value!.isEmpty)
                        {
                          return "Please Enter data";
                        }
                      },
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
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Enter Description",
                        labelStyle: TextStyle(letterSpacing: 0,fontWeight: FontWeight.w200),
                      ),
                      controller:descController ,
                        validator: (value){
                          if(value!.isEmpty)
                          {
                            return "Please Enter data";
                          }
                        },
                      onChanged:(value){

                        setState(() {
                          descController.text=value.toString();
                        });
                      }
                      ),
                  ),
                  TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Enter Description",
                        labelStyle: TextStyle(letterSpacing: 0,fontWeight: FontWeight.w200),
                      ),
                      controller:typeController ,
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return "Please Enter data";
                        }
                      },
                      onChanged:(value){


                        setState(() {
                          typeController.text=value.toString();
                        });
                      }
                  ),
                 MaterialButton(onPressed: () => moveToHome(context),

                 child: const Text("Save ME"),
                 color: Colors.pinkAccent,
                 ),
                ],
              ),
            ),
          ),

    );
  }

  moveToHome(BuildContext context) async{
   if(_formKey.currentState!.validate()){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  Text(typeController.text+descController.text+dateTimeController.text)),);
     Notes n = Notes(date: dateTimeController.text, desc: descController.text, type: typeController.text);
     Future<int> statusCode=  _insertNotes(n);
     //_db.insertNotes();

     //print(statusCode);
     if (statusCode == 0)
     {
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Data Not Inserted")));
     }
     await Future.delayed(Duration(seconds: 1));
     await Navigator.pushNamed(context,MyRoutes.AttandanceRoute);
     // Navigator.pop(context);
   }
    else{
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  Text("Please Enter Data")));
    }
  }
}

