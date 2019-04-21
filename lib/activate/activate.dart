import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'activate_service.dart';
import '../utils/opertaion_status.dart';

class Activate extends StatefulWidget{

  @override
  State<Activate> createState() => new _ActivateState();

}

class _ActivateState extends State<Activate>{

  final _formKey = new GlobalKey<FormState>();
  String _activateId;
  String _password1,_password2;
  String _activateCode;
  String _activateStatus='激活中';
  bool _isObscure = true;
  Color _eyeColor;
  bool _showLoading = false;
  ActivateService activateService = new ActivateService();

  Padding buildTitle(){
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '账户激活',
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

  TextFormField buildActivateCodeTextField(BuildContext context){
    return TextFormField(
      onSaved: (String value) => _activateCode = value,
      decoration: InputDecoration(
        labelText: '验证码',
        hintText: '请向工作人员索取验证码'
      ),
      validator: (actCode){
        var codeReg = RegExp("^\\d{4}\$");
        if (actCode.isEmpty){
          return '请输入验证码';
        } else if(!codeReg.hasMatch(actCode)){
          return '验证码应为4位数字';
        }
      },
    );
  }

  TextFormField buildPassword1TextField(BuildContext context) {
    return TextFormField(
      onSaved: (String value) => _password1 = value,
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
      validator: (inputPassword) {
        if(inputPassword.isEmpty){
          return '请输入密码';
        } else if(inputPassword!=_password2){
          print(_password2);
          return '两次密码输入不一致';
        }
      },
    );
  }

  TextFormField buildPassword2TextField(BuildContext context) {
    return TextFormField(
      onSaved: (String value) => _password2 = value,
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
      validator: (inputPassword) {
        if(inputPassword.isEmpty){
          return '请输入密码';
        } else if(_password1!=inputPassword){
          print(_password1);
          return '两次密码输入不一致';
        }
      },
    );
  }

  TextFormField buildIdTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'ID/手机号码/邮箱',
      ),
      validator: (idValue) {
        var phoneReg = RegExp("^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\\d{8}\$");
        var emailReg = RegExp("^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$");
        var ltcIdReg = RegExp("^\\d{10}\$");
        if(idValue.isEmpty){
          return '请输入ID/手机号码/邮箱';
        } else {
          if (!phoneReg.hasMatch(idValue)&&!emailReg.hasMatch(idValue)&&!ltcIdReg.hasMatch(idValue)){
            return '请检查输入格式是否正确';
          }
        }
      },
      onSaved: (String value) => _activateId = value,
    );
  }

  Align buildActivateButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 55.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            '激活',
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: Theme.of(context).accentColor,
          onPressed: () {
            _formKey.currentState.save();
            if(_formKey.currentState.validate()){
              setState(() {
                _activateStatus = '激活中...';
                _showLoading = true;
              });
              activateService.activate(_activateId, _password1,_activateCode).then((onValue) {
                if (onValue == OperationStatus.SUCCESSFUL){
                  print('激活成功');
                  Navigator.pop(context,OperationStatus.SUCCESSFUL);
                  setState(() {
                    _showLoading = false;
                  });
                } else {
                  setState(() {
                    _activateStatus = '激活失败\n请重试';
                  });
                  Future.delayed(Duration(seconds: 3),(){
                    print('激活失败');
                    setState(() {
                      _showLoading = false;
                    });
                  });
                }
              });
            }
          },
          shape: StadiumBorder(),
        ),
      ),
    );
  }

  Stack activateBody () {
    List<Widget> bodyView = [];
    final _activateForm = new Form(
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
            buildPassword1TextField(context),
            SizedBox(height: 30.0),
            buildPassword2TextField(context),
            SizedBox(height: 30.0),
            buildActivateCodeTextField(context),
            SizedBox(height: 60.0),
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
                        Text(_activateStatus,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ]),
                ))));

    bodyView.add(_activateForm);
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
      appBar: AppBar(title: new Text('激活账户'),),
      body: activateBody()
    );
  }
}