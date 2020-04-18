import 'package:appetizer/globals.dart';
import 'package:appetizer/strings.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/viewmodels/password_models/forgot_password_model.dart';
import 'package:flutter/material.dart';
import 'package:appetizer/colors.dart';

class ForgotPass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  var formKey = new GlobalKey<FormState>();
  String _email;

  @override
  Widget build(BuildContext context) {
    return BaseView<ForgotPasswordModel>(
      builder: (context, model, child) => Scaffold(
        key: forgotPasswordViewScaffoldKey,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: (MediaQuery.of(context).size.height) / 2 -
                        AppBar().preferredSize.height,
                    width: MediaQuery.of(context).size.width,
                    color: appiBrown,
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: (MediaQuery.of(context).size.height) / 2 -
                              AppBar().preferredSize.height,
                          padding: const EdgeInsets.only(
                              bottom: 48, top: 8, right: 8, left: 8),
                          child: Image(
                            alignment: Alignment.bottomLeft,
                            image: AssetImage('assets/images/sppedy_paper.png'),
                            width: (MediaQuery.of(context).size.width / 2) - 16,
                          ),
                        ),
                        Container(
                          height: (MediaQuery.of(context).size.height) / 2 -
                              AppBar().preferredSize.height,
                          padding: const EdgeInsets.all(8.0),
                          child: Image(
                            alignment: Alignment.topRight,
                            image: AssetImage('assets/images/mailbox.png'),
                            width: (MediaQuery.of(context).size.width / 2) - 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Forgot Password?",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontSize: 24.0,
                        color: Colors.black,
                        fontFamily: "OpenSans",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 48, right: 48),
                    child: Text(
                      passInstruction,
                      style: new TextStyle(
                        fontSize: 14.0,
                        color: appiGreyIcon.withOpacity(0.9),
                        fontFamily: "OpenSans",
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                          autofocus: true,
                          validator: validateEmail,
                          initialValue: _email,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.mail,
                              size: 36,
                              color: appiGreyIcon,
                            ),
                            labelText: "Email address",
                            labelStyle:
                                Theme.of(context).primaryTextTheme.subhead,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: appiYellow, style: BorderStyle.solid),
                            ),
                          ),
                          cursorColor: appiYellow,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 16),
                          onSaved: (String value) {
                            this._email = value;
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: OutlineButton(
                      borderSide: BorderSide(
                        color: appiYellow,
                        width: 2,
                      ),
                      splashColor: appiYellow,
                      child: ListTile(
                        title: Text(
                          "SEND INSTRUCTIONS",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).primaryTextTheme.caption,
                        ),
                      ),
                      onPressed: () {
                        formKey.currentState.save();
                        if (formKey.currentState.validate()) {
                          model.sendResetEmail(_email);
                        }
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }
}
