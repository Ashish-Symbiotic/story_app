import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';


class PaymentHome extends StatefulWidget {
  @override
  _PaymentHomeState createState() => _PaymentHomeState();
}

enum PaymentType{Borrow,Give}

class _PaymentHomeState extends State<PaymentHome> {
TextEditingController nameCon = new TextEditingController();
TextEditingController totalAmtCon =new  TextEditingController();
TextEditingController paidCon = new TextEditingController();
TextEditingController balCon = new TextEditingController();
TextEditingController descCon = new TextEditingController();
TextEditingController dateTimeController = TextEditingController();
var dateFormat = DateFormat("dd-MM-yyyy");







final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name="";
  int totalamt=0;
  int paid=0;
  int bal=0;
  String desc="";
  String date ="";
  String payType="";




  PaymentType? _paymentType = PaymentType.Give;
bool borrowField = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Payment"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      labelText: "Name",
                      labelStyle: TextStyle(letterSpacing: 0,fontWeight: FontWeight.w200),
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal),
                          borderRadius: BorderRadius.circular(10)),

                    ),

                    controller: nameCon,
                    validator: (value){
                      if(value!.isEmpty)
                      {
                        return "Please Enter data";
                      }
                    },
                    onFieldSubmitted: (value){
                      nameCon.text = value.toString();
                    },
                  ),
                  SizedBox(
                    height: 10,

                  ),

                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Total Amount",
                        contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        labelStyle: TextStyle(letterSpacing: 0,fontWeight: FontWeight.w200),
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal),
                            borderRadius: BorderRadius.circular(10)),

                      ),
                      keyboardType: TextInputType.number,
                      controller: totalAmtCon,
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return "Please Enter data";
                        }
                      },
                       onFieldSubmitted: (value){
                        totalAmtCon.text = value.toString();
                          },


                    ),
                    Column(
                      children: <Widget>[
                        ListTile(
                          title: Text("Give"),
                          leading: Radio<PaymentType>(
                            value: PaymentType.Give,
                            groupValue: _paymentType,
                            onChanged: (value){
                              _checkRadio(value.toString());
                              setState(() {
                                _paymentType = value;
                              });
                            }),
                            
                          ),
                        ListTile(
                          title: Text("Borrow"),

                          leading: Radio<PaymentType>(
                              value: PaymentType.Borrow,
                              groupValue: _paymentType,
                              onChanged: (value){
                             _checkRadio(value.toString());
                                setState(() {
                                  _paymentType = value;
                                });
                              }),

                        ),


                      ],
                    ),


                  SizedBox(
                    height: 10,

                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: borrowField ? "Disabled":"Paid",
                      filled: true,
                      fillColor: borrowField? Colors.red: Colors.transparent,
                      contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      labelStyle: TextStyle(letterSpacing: 0,fontWeight: FontWeight.w200,color: borrowField?Colors.black
                      :Colors.black12),
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal),
                          borderRadius: BorderRadius.circular(10)),

                    ),
                    keyboardType: TextInputType.number,
                    enabled: !borrowField,
                    controller: paidCon,
                    validator: (value){
                      if(value!.isEmpty)
                      {
                        return "Please Enter data";
                      }
                    },
                    onFieldSubmitted: (value){
                      paidCon.text = value.toString();
                      _showBal(paidCon.text);
                    },
                  ),
                SizedBox(
                  height: 10,

                ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Balance",
                      contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      labelStyle: TextStyle(letterSpacing: 0,fontWeight: FontWeight.w200),
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal),
                          borderRadius: BorderRadius.circular(10)),

                    ),
                    enabled: false,
                    controller: balCon,
                    validator: (value){
                      if(value!.isEmpty)
                      {
                        return "Please Enter data";
                      }
                    },
                    onFieldSubmitted: (value){
                      balCon.text = value.toString();
                    },


                  ),
                  SizedBox(
                    height: 10,

                  ),

                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Description",

                      contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      labelStyle: TextStyle(letterSpacing: 0,fontWeight: FontWeight.w200),
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal),
                          borderRadius: BorderRadius.circular(10)),

                    ),
                    controller: descCon,
                    validator: (value){
                      if(value!.isEmpty)
                      {
                        return "Please Enter data";
                      }
                    },
                    onFieldSubmitted: (value){
                      descCon.text = value.toString();
                    },
                    onTap: (){
                      _showBal(paidCon.text);
                    },

                  ),
                  SizedBox(
                    height: 10,

                  ),
                  ListTile(
                    title: Text(dateTimeController.text.isEmpty ? "Choose Date" : dateTimeController.text.toString()),
                    leading: Icon(Icons.date_range),
                    onTap:(){
                      PhysicalKeyboardKey.close;
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
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    child: Container(
                      height: 40,
                      width: 100,
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(color: Colors.pinkAccent,borderRadius: BorderRadius.circular(5)),
                      alignment: Alignment.center,

                        child: Text("Save",style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,

                        ),),

                      ),

                      onTap: () {

                       if(_formKey.currentState!.validate()){
                       //  print("Wrong data");
                         name = nameCon.text.toString();
                         totalamt = int.parse(totalAmtCon.text.toString());
                         payType = _paymentType.toString();
                         bal = int.parse(balCon.text.toString());
                         paid = int.parse(paidCon.text.toString());
                         date = dateTimeController.text.toString();
                         desc = descCon.text.toString();

                         print(name+date+desc+paid.toString()+bal.toString()+payType+totalamt.toString());
                       }
                       else{
                        print("Wrong data");
                         /*name = nameCon.text.toString();
                         totalamt = int.parse(totalAmtCon.text.toString());
                         payType = _paymentType.toString();
                         bal = int.parse(balCon.text.toString());
                         paid = int.parse(paidCon.text.toString());
                         date = dateTimeController.text.toString();
                         desc = descCon.text.toString();

                         print(name+date+desc+paid.toString()+bal.toString()+payType+totalamt.toString());*/

                       }
                      }
                    ),

                ],
              ),
            ),
          )
        ),
        ),

    );
  }

  void _showBal(String paid) {
    int totalAmt=0;
    if(_paymentType == "Borrow")
      {
        if(paid.isEmpty || totalAmtCon.text.isEmpty)
        {
          borrowField= true;
        }
        else
        {
           totalAmt = int.parse(totalAmtCon.text.toString());
           balCon.text=totalAmt.toString();
        }

      }
    else{
      if(paid.isEmpty || totalAmtCon.text.isEmpty)
      {
       // error= true;
      }
      else
      {
        totalAmt = int.parse(totalAmtCon.text.toString()) - int.parse(paid);
        balCon.text=totalAmt.toString();
      }

    }
  }

  void _checkRadio(String string) {
    debugPrint(string);
    if(string == "PaymentType.Borrow")
      {
        borrowField = true;
        print("yes");
      }
    else if(string == "PaymentType.Give")
      {
        borrowField= false;
      }
  }
}
