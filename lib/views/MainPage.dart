import 'package:flutter/material.dart';

import 'package:story_app/routes/routes.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Ashish"),
        ),
        body: Material(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(child:ElevatedButton(onPressed: (){
                       // Navigator.pop(context);
                        Navigator.pushNamed(context,MyRoutes.AttandanceRoute);
                      }, child: Text("Attandance"),style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.white),backgroundColor: MaterialStateProperty.all<Color>(Colors.red),shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.red),
            ))))),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child:ElevatedButton(onPressed: (){
                       // Navigator.pop(context);
                        Navigator.pushNamed(context,MyRoutes.MarkAttanRoute);
                      }, child: Text("Mandir"),style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.white),backgroundColor: MaterialStateProperty.all<Color>(Colors.red),shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.red),
                      ))))),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child:ElevatedButton(onPressed: (){}, child: Text("Notes"),style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.white),backgroundColor: MaterialStateProperty.all<Color>(Colors.red),shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.red),
                      ))))),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child:ElevatedButton(onPressed: (){
                        Navigator.pushNamed(context,MyRoutes.PaymentMainRoute);
                      }, child: Text("Payment"),style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.white),backgroundColor: MaterialStateProperty.all<Color>(Colors.red),shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.red),
                      ))))),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(child: Text("Drawer Header"),
                decoration: BoxDecoration(color:Colors.blue),),
              InkWell(
                child: const ListTile(
                  leading:Text("First Option"),
                ),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context,MyRoutes.AttandanceRoute);
                },
              ),
              InkWell(
                child: const ListTile(
                  leading:Text("Second Option"),
                ),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context,MyRoutes.PaymentViewRoute);
                },
              ),
              InkWell(
                child: const ListTile(
                  leading:Text("Third Option"),
                ),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context,MyRoutes.AttandanceRoute);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
