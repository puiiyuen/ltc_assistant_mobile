import 'package:flutter/material.dart';

class Suggestion extends StatefulWidget {
  @override
  State<Suggestion> createState() => new _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {

  var status = '';

  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text('意见反馈'),
      ),
      body: new Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              '我们认真倾听您的声音',
              style: TextStyle(fontSize: 25.0),
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: new TextField(
              controller: controller,
              decoration: InputDecoration(border: OutlineInputBorder(),
              hintText: '输入意见'),
              maxLength: 200,
              maxLengthEnforced: true,
              maxLines: 6,
            ),
          ),
          SizedBox (
            height: 30,
            child: new Text(status,style:TextStyle(
              fontSize: 20,
              color: Colors.red
            ),),
          ),
          SizedBox(
            height: 55.0,
            width: 240.0,
            child: new RaisedButton(
              child: new Text(
                '提交意见',
                style: Theme.of(context).primaryTextTheme.headline,
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {
                setState(() {
                  status = '提交中...';
                });
                Future.delayed(Duration(seconds: 1),(){
                  setState(() {
                    status = '感谢你的反馈';
                    controller.clear();
                  });
                });
              },
              shape: StadiumBorder(),
            ),
          )
        ],
      ),
    );
  }
}
