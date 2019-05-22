import 'package:flutter/material.dart';


class HealthReport extends StatefulWidget {
  @override
  State<HealthReport> createState() => new _HealthReportState();
}

class _HealthReportState extends State<HealthReport> {

  ListView _healthList;

  _HealthReportState(){
    _healthList = new ListView(
      children: <Widget>[
        buildTitle('最新报告'),
        latestRecord(),
        buildRecord('健康建议：少吃辛辣食物'),
        buildTitle('历史记录'),
        new Divider(color: Colors.black),
        buildRecord('身高：170，体重：56'),
        new Divider(color: Colors.black),
        buildRecord('身高：170，体重：58'),
        new Divider(color: Colors.black),
        buildRecord('身高：171，体重：55'),
        new Divider(color: Colors.black),
        buildRecord('身高：170，体重：56'),
        new Divider(color: Colors.black),
        buildRecord('身高：171，体重：52'),

      ],
    );


  }

  GestureDetector buildRecord(record){
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
        child: Text(
          record,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      onTap: (){
        HealthRecord healthRecord = new HealthRecord('report12341', 170, 65, 72, 120, 75, 5, 5.2, 3.4, '无', '2019-05-21');
        Navigator.push(context,
          new MaterialPageRoute(
              builder: (context) => new HealthDetail(1,healthRecord))
        );
      },
    );
  }

  Padding buildTitle(title) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Padding buildTitleLine() {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, top: 4.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Theme.of(context).primaryColor,
          width: 120.0,
          height: 4.0,
        ),
      ),
    );
  }

  Table latestRecord() {
    HealthRecord healthRecord = new HealthRecord('report12341', 170, 65, 72,
        120, 75, 5, 5.2, 3.4, '无', '2019-05-21');
    return Table(
      children: <TableRow>[
        TableRow(children: <Widget>[
          SizedBox(
            height: 50,
            child: Text(
              '身高: ${healthRecord.height}',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 50,
            child: Text(
              '体重: ${healthRecord.weight}',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 50,
            child: Text(
              '心率: ${healthRecord.heartRate}',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ]),
        TableRow(children: <Widget>[
          SizedBox(
            height: 50,
            child: Text(
              '舒张压: ${healthRecord.bpDiastolic}',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 50,
            child: Text(
              '收缩压: ${healthRecord.bpSystolic}',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 50,
            child: Text(
              '血糖: ${healthRecord.bloodGlucose}',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ]),
        TableRow(children: <Widget>[
          SizedBox(
            height: 50,
            child: Text(
              '血脂: ${healthRecord.bloodLipids}',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 50,
            child: Text(
              '尿酸: ${healthRecord.uricAcid}',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ])
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text('健康报告'),
      ),
      body: new Container(
        child: RefreshIndicator(
            onRefresh: () {
              return Future.delayed(Duration(seconds: 3), () {
                print('报告更新成功');
              });
            },
          child: _healthList
        ),
      ),
    );
  }
}

class HealthDetail extends StatefulWidget{

  final int index;
  final HealthRecord records;

  HealthDetail(this.index,this.records);

  @override
  State<HealthDetail> createState()
    => new _HealthDetail(this.index,this.records);

}

class _HealthDetail extends State<HealthDetail>{

  int index;
  HealthRecord records;
  _HealthDetail(this.index,this.records);

  Padding buildRecord(record){
    return Padding(
      padding: EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
      child: Text(
        record,
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: new Text('报告详情'),),
      body: new ListView(
        children: <Widget>[
          SizedBox(height: 10.0,),
          buildRecord('身高：${records.height}'),
          new Divider(color: Colors.black),
          buildRecord('体重：${records.weight}'),
          new Divider(color: Colors.black),
          buildRecord('心率：${records.heartRate}'),
          new Divider(color: Colors.black),
          buildRecord('血压（收缩压）：${records.bpSystolic}'),
          new Divider(color: Colors.black),
          buildRecord('血压（舒张压）：${records.bpDiastolic}'),
          new Divider(color: Colors.black),
          buildRecord('血糖：${records.bloodGlucose}'),
          new Divider(color: Colors.black),
          buildRecord('血脂：${records.bloodLipids}'),
          new Divider(color: Colors.black),
          buildRecord('尿酸：${records.uricAcid}'),
        ],
      ),
    );
  }

}


class HealthRecord{

  String reportId;
  double height;
  double weight;
  int heartRate;
  int bpSystolic;
  int bpDiastolic;
  double bloodGlucose;
  double bloodLipids;
  double uricAcid;
  String suggestion;
  String recordDate;

  HealthRecord(this.reportId,this.height,this.weight,this.heartRate,
      this.bpSystolic,this.bpDiastolic,this.bloodGlucose,
      this.bloodLipids,this.uricAcid,this.suggestion,this.recordDate);

  HealthRecord.fromJson(Map<String,dynamic> json)
      : reportId = json['reportId'],
        height = json['height'],
        weight = json['weight'],
        heartRate = json['heartRate'];



}
