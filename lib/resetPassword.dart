import 'package:appetizer/alertDialog.dart';
import 'package:flutter/material.dart';
import 'package:appetizer/colors.dart';
import 'package:appetizer/strings.dart';
import 'package:appetizer/services/user.dart';

class ResetPassword extends StatefulWidget {
  final String token;

  const ResetPassword({Key key, this.token}) : super(key: key);
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  bool _obscureText = true;
  String oldPassword = "";
  String newPassword = "";

  final _formKey = new GlobalKey<FormState>();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      backgroundColor: appiBrown,
      leading: IconButton(
          splashColor: Colors.transparent,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          }),
      iconTheme: IconThemeData(
        color: appiYellow,
      ),
      elevation: 0.0,
    );

    // Check if form is valid before performing Login
    bool _validateAndSave() {
      final form = _formKey.currentState;
      if (form.validate()) {
        form.save();
        return true;
      }
      return false;
    }

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                appBar,
                Column(
                  children: <Widget>[
                    Container(
                      height: (MediaQuery.of(context).size.height) / 2 -
                          appBar.preferredSize.height,
                      width: MediaQuery.of(context).size.width,
                      color: appiBrown,
                      alignment: Alignment.centerRight,
                      child: Image(
                        alignment: Alignment.centerRight,
                        image: AssetImage('assets/images/reset_password.png'),
                        width: (MediaQuery.of(context).size.width) * 0.8,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("Reset Password",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .display1
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 48, right: 48),
                      child: Text(
                        forgotInstruction,
                        style: new TextStyle(
                          fontSize: 16.0,
                          color: appiRed.withOpacity(0.9),
                          fontFamily: "OpenSans",
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
                            child: new TextFormField(
                              maxLines: 1,
                              obscureText: _obscureText,
                              autofocus: false,
                              decoration: new InputDecoration(
                                suffixIcon: GestureDetector(
                                  child: new Icon(
                                    _obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: appiGreyIcon,
                                  ),
                                  onTap: _toggle,
                                ),
                                labelText: "Old Password",
                                labelStyle:
                                    Theme.of(context).primaryTextTheme.subhead,
                                icon: new Icon(
                                  Icons.lock,
                                  color: appiGreyIcon,
                                  size: 30,
                                ),
                              ),
                              validator: (value) => value.isEmpty
                                  ? 'Password can\'t be empty'
                                  : null,
                              onSaved: (value) => oldPassword = value,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
                            child: new TextFormField(
                              maxLines: 1,
                              obscureText: _obscureText,
                              autofocus: false,
                              decoration: new InputDecoration(
                                suffixIcon: GestureDetector(
                                  child: new Icon(
                                    _obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: appiGreyIcon,
                                  ),
                                  onTap: _toggle,
                                ),
                                labelText: "New Password",
                                labelStyle:
                                    Theme.of(context).primaryTextTheme.subhead,
                                icon: new Icon(
                                  Icons.lock,
                                  color: appiGreyIcon,
                                  size: 30,
                                ),
                              ),
                              validator: (value) => value.isEmpty
                                  ? 'Password can\'t be empty'
                                  : null,
                              onSaved: (value) => newPassword = value,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: OutlineButton(
                              highlightedBorderColor: appiYellow,
                              borderSide: BorderSide(
                                color: appiYellow,
                                width: 2,
                              ),
                              splashColor: Colors.transparent,
                              child: ListTile(
                                title: Text(
                                  "RESET PASSWORD",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .display1,
                                ),
                              ),
                              onPressed: () async {
                                if (_validateAndSave()) {
                                  showCustomDialog(context, "Updating Password");
                                  await userPasswordReset(widget.token,
                                          oldPassword, newPassword)
                                      .then((detail) {
                                    if (detail.detail ==
                                        "password changed successfully") {
                                      _scaffoldKey.currentState
                                          .showSnackBar(new SnackBar(
                                        content: new Text(
                                            "Password changed successfully"),
                                      ));
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                      _formKey.currentState.reset();
                                    } else {
                                      _formKey.currentState.reset();
                                      _scaffoldKey.currentState
                                          .showSnackBar(new SnackBar(
                                        content: new Text(
                                            "Something Wrong Ocurred!!"),
                                      ));
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                    }
                                  });
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
