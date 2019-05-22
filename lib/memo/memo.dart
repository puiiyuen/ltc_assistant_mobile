import 'package:flutter/material.dart';

List toDoList = new List();
List finishedList = new List();

class Memo extends StatefulWidget{


  @override
  State<Memo> createState() => new _MemoState();
}

class _MemoState extends State<Memo> {

  Padding buildTitle(title) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 30.0,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Card addCard(memoContent){
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.album),
              title: Text(
                memoContent,
                style: TextStyle(
                  fontSize: 20,
                ),)
            ),
            ButtonTheme.bar( // make buttons use the appropriate styles for cards
              child: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text('已完成',style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),),
                    onPressed: () {
                      setState(() {
                        toDoList.remove(memoContent);
                        finishedList.insert(0,memoContent);
                      });
                    },
                  ),
                  FlatButton(
                    child: const Text('删除',style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.red
                    ),),
                    onPressed: (){
                      setState(() {
                        toDoList.remove(memoContent);
                      });
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      );
  }

  Card finishCard(memoContent){
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
              leading: Icon(Icons.assignment_turned_in),
              title: Text(
                memoContent,
                style: TextStyle(
                  fontSize: 20,
                ),)
          ),
          ButtonTheme.bar( // make buttons use the appropriate styles for cards
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('未完成',style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),),
                  onPressed: () {
                    setState(() {
                      finishedList.remove(memoContent);
                      toDoList.insert(0,memoContent);
                    });
                  },
                ),
                FlatButton(
                  child: const Text('删除',style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.red
                  ),),
                  onPressed: (){
                    setState(() {
                      finishedList.remove(memoContent);
                    });
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget renderList(BuildContext context,int index){
    if (index == 0 ){
      return buildTitle('待办事项');
    } else if (index == toDoList.length+1){
      return buildTitle('已完成事项');
    } else if (index > 0 && index <= toDoList.length){
      return addCard(toDoList[index-1]);
    } else {
      return finishCard(finishedList[index-(toDoList.length+2)]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: new Text('事项提醒'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) => AddDrawer()).then((onValue){
            setState(() {
              if (onValue!=null){
                toDoList.insert(0,onValue);
              }
            });
        });
      },
      child: new Icon(Icons.add),),
      body: ListView.builder(
          itemBuilder: renderList,
          itemCount: 1+toDoList.length+1+finishedList.length,
      ),
    );
  }
}

class AddDrawer extends StatefulWidget{
  @override
  State<AddDrawer> createState() => new _AddDrawer();
}

class _AddDrawer extends State<AddDrawer>{

  TextEditingController addMemoController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              '新建事项',
              style: TextStyle(fontSize: 25.0),
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: new TextField(
              controller: addMemoController,
              decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: '新建事项'),
              maxLength: 200,
              maxLengthEnforced: true,
              maxLines: 6,
            ),
          ),
          SizedBox(
            height: 55.0,
            width: 240.0,
            child: new RaisedButton(
              child: new Text(
                '新建',
                style: Theme.of(context).primaryTextTheme.headline,
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {
                Navigator.of(context).pop(addMemoController.text);
              },
              shape: StadiumBorder(),
            ),
          )
        ],
      ),
    );
  }

}