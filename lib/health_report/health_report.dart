import 'package:flutter/material.dart';

class HealthReport extends StatefulWidget{

  @override
  State<HealthReport> createState() => new _HealthReportState();
}

class _HealthReportState extends State<HealthReport>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: new Text('健康报告'),),
    );
  }
}