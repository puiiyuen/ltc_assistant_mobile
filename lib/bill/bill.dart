import 'package:flutter/material.dart';

import 'bill_service.dart';
import 'paypal.dart';

class Bill extends StatefulWidget{

  @override
  State<Bill> createState() => new _BillState();
}

class _BillState extends State<Bill>{

  BillService billService = new BillService();

  GestureDetector buildRecord(record,dateTime){
    return GestureDetector(
      child: ListTile(
        leading: Icon(Icons.attach_money),
        title: Text(
          record,
          style: TextStyle(fontSize: 20.0),
        ),
        subtitle: Text(dateTime,style: TextStyle(fontSize: 16),),
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
                buildRecord('¥170 餐食费用','记录日期：2019-05-20'),
                new Divider(color: Colors.black),
                buildRecord('¥2300 住宿费用','记录日期：2019-05-11'),
                new Divider(color: Colors.black),
                buildRecord('¥170 餐食费用','记录日期：2019-05-10'),
                new Divider(color: Colors.black),
                buildRecord('¥140 接送费用','记录日期：2019-05-08'),
                new Divider(color: Colors.black),
                buildRecord('¥150 餐食费用','记录日期：2019-05-05'),
                new Divider(color: Colors.black),
                buildRecord('¥160 服务费用','记录日期：2019-05-05'),
                new Divider(color: Colors.black),
                buildRecord('¥20 日用品','记录日期：2019-05-05'),
                new Divider(color: Colors.black),

              ],
            ),
            new ListView(
              children: <Widget>[
                SizedBox(height: 10,),
                buildRecord('缴费¥150','缴费日期：2019-05-05'),
                new Divider(color: Colors.black),
                buildRecord('缴费¥100','缴费日期：2019-05-15'),
                new Divider(color: Colors.black),
                buildRecord('缴费¥1550','缴费日期：2019-05-16'),
                new Divider(color: Colors.black),
                buildRecord('缴费¥130','缴费日期：2019-05-18'),
                new Divider(color: Colors.black),
                buildRecord('缴费¥130','缴费日期：2019-05-15'),
                new Divider(color: Colors.black),

              ],
            ),
          ],
        ),
      ),
    );

  }
}