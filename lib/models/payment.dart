class Payment{
  int? id;
   int total;
  int txn_amt;
  int bal;
  String type;
  String desc;
  String name;
  String date;

  Payment({
    this.id,
    required this.total,
    required this.txn_amt,
    required this.bal,
    required this.type,
    required this.desc,
    required this.name,
    required this.date,
});


  Map<String,dynamic> toMap(){
    return {'id':id,'total':total,'txn_amt':txn_amt,'bal':bal,'type':type,'desc':desc,'name':name,'date':date};

  }


  factory Payment.fromMap(Map<String,dynamic> map){
    return Payment(total: map['total']?? 0, txn_amt: map['txn_amt'] ?? 0, bal: map['bal'] ?? 0, type: map['type'] ?? '', desc: map['desc'] ?? '', name: map['name'] ?? '', id: map['id'] ?? '',date: map['date'] ?? '');

  }
  @override
  String toString()=> 'Payment(id: $id,total:$total,txn_amt:$txn_amt,bal:$bal,type: $type,desc:$desc,name:$name,date:$date)';
}