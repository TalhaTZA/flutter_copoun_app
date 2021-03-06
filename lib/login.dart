import 'package:flutter/material.dart';
import './list.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _validateName = false;
  bool _validatePassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Screen')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Sign In',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    labelText: 'User Name',
                    hintText: 'Enter Your User Name',
                    errorText:
                        _validateName ? 'User Name Cannot Be Empty' : null),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter Your Password',
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    errorText:
                        _validatePassword ? 'Password Cannot Be Empty' : null),
              ),
            ),
            Container(
                height: 70,
                padding: EdgeInsets.all(10.0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Text('Login'),
                  onPressed: () {
                    _validateData();
                  },
                ))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_textListenerName);
    _passwordController.addListener(_textListenerPassword);
  }

  void _textListenerName() {
    setState(() {
      _nameController.text.isEmpty
          ? _validateName = true
          : _validateName = false;
    });
  }

  void _textListenerPassword() {
    setState(() {
      _passwordController.text.isEmpty
          ? _validatePassword = true
          : _validatePassword = false;
    });
  }

  void _validateData() {
//    print('$_validateName $_validatePassword');
    if (_nameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ListPage()));
    } else {
      setState(() {
        _nameController.text.isEmpty
            ? _validateName = true
            : _validateName = false;
        _passwordController.text.isEmpty
            ? _validatePassword = true
            : _validatePassword = false;
      });
    }
  }
}
