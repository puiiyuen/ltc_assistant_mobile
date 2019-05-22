import 'package:flutter/material.dart';

import 'bill_service.dart';
import 'paypal.dart';

class Bill extends StatefulWidget{

  @override
  State<Bill> createState() => new _BillState();
}

class _BillState extends State<Bill>{

  BillService billService = new BillService();

  GestureDetector buildRecord(record){
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
        child: Text(
          record,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('个人账单'),
          bottom: new TabBar(
            tabs: <Widget>[
              new Tab(text: '账单',),
              new Tab(text: '缴费记录',),
            ],
          ),
        ),
        floatingActionButton: new FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
              new MaterialPageRoute(builder: (context)=> new ToPayPal()));
            },
          tooltip: '支付账单',
          child: new Icon(Icons.payment),
        ),
        body: new TabBarView(
          children: <Widget>[
            new ListView(
              children: <Widget>[
                SizedBox(height: 10,),
                buildRecord('身高：170，体重：56'),
                new Divider(color: Colors.black),
                buildRecord('身高：170，体重：58'),
                new Divider(color: Colors.black),
                buildRecord('身高：171，体重：55'),
                new Divider(color: Colors.black),
                buildRecord('身高：170，体重：56'),
                new Divider(color: Colors.black),
                buildRecord('身高：171，体重：52'),
                new Divider(color: Colors.black),

              ],
            ),
            new ListView(
              children: <Widget>[
                SizedBox(height: 10,),
                buildRecord('身高：170，体重：56'),
                new Divider(color: Colors.black),
                buildRecord('身高：170，体重：58'),
                new Divider(color: Colors.black),
                buildRecord('身高：171，体重：55'),
                new Divider(color: Colors.black),
                buildRecord('身高：170，体重：56'),
                new Divider(color: Colors.black),
                buildRecord('身高：171，体重：52'),
                new Divider(color: Colors.black),

              ],
            ),
          ],
        ),
      ),
    );

  }
}