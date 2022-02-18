import 'package:flutter/material.dart';
import 'package:story_app/db/notes_database_service.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Material(
          child: FutureBuilder<List<Notes>>(
            future:_db.notes(),
            builder: (context,snapshot){
              if (snapshot.connectionState == ConnectionState.waiting)
               {
                 print(snapshot);
                 return  const Center(
                   child: CircularProgressIndicator(color: Colors.black,
                   backgroundColor: Colors.amber,),
                 );
               }
              else
                {
                  return Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical :10),
                   child: ListView.separated(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context,index){
                      final notes = snapshot.data![index];
                      print("hello");
                      return _buildNotesCard(notes);
                  }, separatorBuilder: (BuildContext context, int index) => SizedBox(
                     height: 10,
                   ),
                  ),);
                }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNotesCard(Notes notes) {
    return  ListTile(
      title: Text(notes.desc),
      subtitle: Text(notes.type),
      trailing: Text(notes. date),
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      onLongPress: (){
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(notes.id.toString())));
      },
      tileColor: Colors.black12,
      horizontalTitleGap: 10,
      minVerticalPadding:10,

    );


  }
}
