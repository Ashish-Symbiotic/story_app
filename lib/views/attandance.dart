import 'package:flutter/material.dart';
import 'package:story_app/db/database_service.dart';
import 'package:story_app/models/note.dart';

class Attendence extends StatefulWidget {
  const Attendence({Key? key}) : super(key: key);

  @override
  _AttendenceState createState() => _AttendenceState();
}

class _AttendenceState extends State<Attendence> {
  final DatabaseService _db = DatabaseService();
  Future<List<Notes>> _getBreeds() async {
    return await _db.notes();
  }
  // Future<List<Notes>> x;


  @override
  void initState() {
    // TODO: implement initState
  super.initState();
  _db.insert();


  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List<Notes>>(
          future:_db.notes(),
          builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.waiting)
             {
               print(snapshot);
               return  const Center(
                 child: CircularProgressIndicator(color: Colors.black,
                 backgroundColor: Colors.amber,),
               );}
            else
              {
                return Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0),
                 child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context,index){
                    final notes = snapshot.data![index];
                    print("hello");
                    return _buildNotesCard(notes);
                },),
                );
              }

          },
        ),

      ),
    );
  }

  Widget _buildNotesCard(Notes notes) {
    return  ListTile(
      title: Text(notes.title),
      subtitle: Text(notes.desc),
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      onLongPress: (){
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(notes.id.toString())));
      },
    );


  }
}
