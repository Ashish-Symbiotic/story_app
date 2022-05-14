import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:story_app/db/notes_database_service.dart';
import 'package:story_app/models/payment.dart';
import 'package:story_app/routes/routes.dart';

class PaymentHome extends StatefulWidget {
  @override
  _PaymentHomeState createState() => _PaymentHomeState();
}

enum PaymentType { Borrow, Give }

class _PaymentHomeState extends State<PaymentHome> {
  TextEditingController nameCon = new TextEditingController();
  TextEditingController totalAmtCon = new TextEditingController();
  TextEditingController paidCon = new TextEditingController();
//TextEditingController balCon = new TextEditingController();
  TextEditingController descCon = new TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  var dateFormat = DateFormat("dd-MM-yyyy");
  String textValue = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name = "";
  int totalamt = 0;
  int paid = 0;
  int bal = 0;
  String desc = "";
  String date = "";
  String payType = "";

  DateTime selectedDate = DateTime.now();

  PaymentType? _paymentType = PaymentType.Give;
  bool borrowField = false;
 DatabaseService _db = DatabaseService();


  @override
  Widget build(BuildContext context) {
    dateTimeController.clear();
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
                    labelStyle: TextStyle(
                        letterSpacing: 0, fontWeight: FontWeight.w200),
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  controller: nameCon,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter data";
                    }
                  },
                  onFieldSubmitted: (value) {
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
                    labelStyle: TextStyle(
                        letterSpacing: 0, fontWeight: FontWeight.w200),
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  keyboardType: TextInputType.number,
                  controller: totalAmtCon,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter data";
                    }
                  },
                  onFieldSubmitted: (value) {
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
                          onChanged: (value) {
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
                          onChanged: (value) {
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
                    labelText: borrowField ? "Disabled" : "Paid",
                    filled: true,
                    fillColor: borrowField ? Colors.red : Colors.transparent,
                    contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    labelStyle: TextStyle(
                        letterSpacing: 0,
                        fontWeight: FontWeight.w200,
                        color: borrowField ? Colors.black : Colors.black12),
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  keyboardType: TextInputType.number,
                  enabled: !borrowField,
                  controller: paidCon,
                  validator: (value) {
                    if (borrowField == false && value!.isEmpty) {
                      // paidCon.text=bal.toString();
                      return "Please Enter data";
                    }
                  },
                  onFieldSubmitted: (value) {
                    paidCon.text = value.toString();
                    _showBal();
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                BalTextField(),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Description",
                    contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    labelStyle: TextStyle(
                        letterSpacing: 0, fontWeight: FontWeight.w200),
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  controller: descCon,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter data";
                    }
                  },
                  onFieldSubmitted: (value) {
                    descCon.text = value.toString();
                  },
                  onTap: () {
                    _showBal();
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                    title: Text(date.isEmpty
                        ? "Choose Date"
                        : date.toString()),
                    leading: Icon(Icons.date_range),
                    onTap: () => showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2015, 8),
                      lastDate: DateTime(2101),
                    ).then((value) => {
                      print(value),
                      setState(() {
                      date = dateFormat.format(value!).toString();
                      })
                    })),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  child: InkWell(
                      child: Container(
                        height: 40,
                        width: 100,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.circular(5)),
                        alignment: Alignment.center,
                        child: Text(
                          "Save",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          //  print("Wrong data");
                          setState(() {
                            name = nameCon.text.toString();
                            totalamt = int.parse(totalAmtCon.text.toString());
                            payType = _paymentType.toString();
                            // bal = int.parse(balCon.text.toString());
                            if (borrowField == true) {
                              paid = 0;
                            } else {
                              paid = int.parse(paidCon.text.toString());
                            }


                            desc = descCon.text.toString();
                          });
                          _showBal();

                          print(name +
                              date +
                              desc +
                              paid.toString() +
                              bal.toString() +
                              payType +
                              totalamt.toString());
                          var now = new DateTime.now();
                          var formatter = new DateFormat('dd-MM-yyyy');
                          String formattedDate = formatter.format(now);
                          print(formattedDate);
                          Payment pay = Payment(total: totalamt,txn_amt: paid,bal: bal,type:payType,desc: desc, name:name,date:date.isEmpty ? formattedDate :date);
                             Future<int>  statusCode= _db.saveNewInfo(pay);
                                    if (statusCode == 0)
                                             {
                                                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Data Not Inserted")));
                                             }
                          await Future.delayed(Duration(seconds: 1));
                          await Navigator.pushNamed(context,MyRoutes.PaymentViewRoute);

    // Navigator.pop(context)

                        } else {
                          print("Wrong data");
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  Text("Please Enter Data")));
                          /*name = nameCon.text.toString();
                         totalamt = int.parse(totalAmtCon.text.toString());
                         payType = _paymentType.toString();
                         bal = int.parse(balCon.text.toString());
                         paid = int.parse(paidCon.text.toString());
                         date = dateTimeController.text.toString();
                         desc = descCon.text.toString();

                         print(name+date+desc+paid.toString()+bal.toString()+payType+totalamt.toString());*/

                        }
                      }),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

  void _showBal() {
    int totalAmt = 0;
    print(_paymentType.toString()+"This is payment type");
    bal = 0;
    if (_paymentType.toString() == "PaymentType.Borrow") {
      if (totalAmtCon.text.isEmpty) {
        borrowField = true;
        print("PaidCon is Empty");
      } else {
        totalAmt = int.parse(totalAmtCon.text.toString());
        bal = totalAmt;
        print("bal from borrow type"+bal.toString());
        setState(() {
          bal= totalamt;
        });
      }
    } else {
      if (paidCon.text.isEmpty || totalAmtCon.text.isEmpty) {
        // error= true;
      } else {
        print(paidCon.text.toString() +
            "This is amount paid  from the Give Type");
        print(totalAmtCon.text.toString() + "This is total amount");
        totalAmt = int.parse(totalAmtCon.text.toString()) -
            int.parse(paidCon.text.toString());
        bal = totalAmt;

        print(bal.toString() + "This is bal");
      }
    }
  }

  void _checkRadio(String string) {
    debugPrint(string);
    if (string == "PaymentType.Borrow") {
      borrowField = true;
      paidCon.clear();
      print("yes");
    } else if (string == "PaymentType.Give") {
      borrowField = false;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        dateTimeController.text = picked.toString();
      });
    } else {
      dateTimeController.text = "";
    }
  }
  Widget BalTextField(){
    return Text(bal.toString().isEmpty ? "Balance" : "Balance"+bal.toString());


  }

}
