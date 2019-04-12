import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'login_service.dart';
import '../utils/opertaion_status.dart';
import '../utils/session.dart';

class Login extends StatefulWidget{

  @override
  State<Login> createState() => new _LoginState();

}

class _LoginState extends State<Login> {
  final _formKey = new GlobalKey<FormState>();
  String _loginId;
  String _password;
  bool _isObscure = true;
  Color _eyeColor;
  bool _showLoading = false;
  LoginService loginService = new LoginService();
  Session session = new Session();

  Padding buildTitle(){
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '用户登录',
        style: TextStyle(fontSize: 45.0,fontWeight: FontWeight.bold),
      ),
    );
  }

  Padding buildTitleLine(){
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

  TextFormField buildPasswordTextField(BuildContext context) {
    return TextFormField(
      onSaved: (String value) => _password = value,
      obscureText: _isObscure,
      decoration: InputDecoration(
          labelText: '密码',
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyeColor,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                  _eyeColor = _isObscure
                      ? Colors.grey
                      : Theme.of(context).iconTheme.color;
                });
              })),
    );
  }

  TextFormField buildIdTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'ID/手机号码/邮箱',
      ),
      onSaved: (String value) => _loginId = value,
    );
  }

  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 55.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            '登录',
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: Theme.of(context).accentColor,
          onPressed: () {
            _formKey.currentState.save();
            setState(() {
              _showLoading = true;
            });
           loginService.login(_loginId, _password).then((onValue) {
             if (onValue == OperationStatus.SUCCESSFUL){
               print('登陆成功');
             } else {
               print('登陆失败');
             }
             setState(() {
               _showLoading = false;
             });
           });
          },
          shape: StadiumBorder(),
        ),
      ),
    );
  }

  Align buildActivateButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 55.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            '激活账户',
              style: Theme.of(context).primaryTextTheme.headline,
          ),
            color: Colors.redAccent,
            shape: StadiumBorder(),
            onPressed: () {
              session.isOnline().then((onValue) {
                print(onValue);
              });
            }
        ),
      ),
    );
  }

  Stack loginBody () {
    List<Widget> bodyView = [];
    final _loginForm = new Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 22.0),
          children: <Widget>[
            SizedBox(
              height: kToolbarHeight,
            ),
            buildTitle(),
            buildTitleLine(),
            SizedBox(height: 70.0),
            buildIdTextField(),
            SizedBox(height: 30.0),
            buildPasswordTextField(context),
            SizedBox(height: 60.0),
            buildLoginButton(context),
            SizedBox(height: 20.0),
            buildActivateButton(context),
          ],
        ));
    final _loadingContainer = Container(
        constraints: BoxConstraints.expand(),
        color: Colors.black45,
        child: Center(
          child: Opacity(
            opacity: 1,
            child: new Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.vertical(
                    top: Radius.elliptical(15, 15),
                    bottom: Radius.elliptical(15, 15)
                ),
                color: Colors.white,
              ),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SpinKitWave(
                    color: Colors.blue,
                    size: 50.0,
                  ),
                  Text('登录中...',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
              ),
            )
          ]),
        ))));

    bodyView.add(_loginForm);
    if (_showLoading) {
      bodyView.add(_loadingContainer);
    }
    return Stack(
      children: bodyView,
    );

  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: AppBar(title: new Text("用户登录"),),
      body: loginBody()
    );
  }
}