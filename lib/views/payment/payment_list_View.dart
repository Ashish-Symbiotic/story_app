import 'package:flutter/material.dart';
import 'package:story_app/db/notes_database_service.dart';
import 'package:story_app/db/payment_db_service.dart';
import 'package:story_app/models/payment.dart';

class Payment_View extends StatefulWidget {
  @override
  _Payment_ViewState createState() => _Payment_ViewState();

}



class _Payment_ViewState extends State<Payment_View> {
   DatabaseService _db = DatabaseService();
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
          child: FutureBuilder<List<Payment>>(
            future:_db.payment(),
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

  Widget _buildNotesCard(Payment payment) {
    String pay;
    if(payment.type.contains("PaymentType.Give"))
      {
       pay="Give";
      }
    else
      {
        pay="Borrow";
      }
    print("Free"+payment.type);
    return  ListTile(
      title: Text("Name : "+payment.name+"\n"+"Total Amount : "+payment.total.toString()),
      subtitle: Text("Type : "+pay ),
      trailing: Text("Balance : "+payment.bal.toString()+"\n"+"Date :  "+payment. date+"\n"+"Txn amount"+payment.txn_amt.toString()),
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      onLongPress: (){
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Desc :"+payment.desc)));
      },
      tileColor: Colors.black12,
      horizontalTitleGap: 10,
      minVerticalPadding:10,
    );


  }
}



