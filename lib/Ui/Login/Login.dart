import 'package:behtarino/Common/Extentions/StringExtentions.dart';
import 'package:behtarino/Common/Helper/Msacontext.dart';
import 'package:behtarino/Common/Variebles/Constants.dart';
import 'package:behtarino/Common/Widgets/Appbar.dart';
import 'package:behtarino/Common/Widgets/CustomButton.dart';
import 'package:behtarino/Common/Widgets/Inputs.dart';
import 'package:behtarino/Model/Home/Contact.dart';
import 'package:behtarino/Ui/Core/Ui_Methods.dart';
import 'package:behtarino/Ui/Login/LoginPresenter.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> implements UiMethodsBit {
  var submitted = false;
  final _UsernameController = TextEditingController();
  final _passController = TextEditingController();
  bool boolUsername = false;
  bool boolPass = false;
  String _validatePass = "";
  String _validateUser = "";
  void IsSuccess(bool IsSucces) {
    MsaNavigator(context).pushReplacementNamed("/Home");
  }

  void showError() {
    setState(() {
      submitted = false;
    });
  }

  LoginPresenter? lp;

  _LoginState() {
    lp = new LoginPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: MsaAppbar(),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 45,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [usernameField(), PasswordField(), SubmitBtn()],
          ),
        ),
      ),
    );
  }

  Widget usernameField() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      child: entryField("نام کاربری",
          userController: _UsernameController,
          validate: _validateUser, onChange: (text) {
        if (text.length == 0) {
          setState(() {
            _validateUser = "لطفا نام کاربری را وارد کنید";
            boolUsername = false;
          });
        } else
          setState(() {
            _validateUser = "";
            boolUsername = true;
          });
      }, textColor: Colors.white, fillcolors: Colors.grey[700]),
    );
  }

  Widget PasswordField() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      child: entryField("کلمه عبور",
          userController: _passController,
          validate: _validatePass, onChange: (text) {
        if (text.length == 0) {
          setState(() {
            _validatePass = "لطفا کلمه عبور را وارد کنید";
            boolPass = false;
          });
        } else
          setState(() {
            _validatePass = "";
            boolPass = true;
          });
      }, textColor: Colors.white, fillcolors: Colors.grey[700]),
    );
  }

  Widget SubmitBtn() {
    return Container(
      width: MediaQuery.of(context).size.width - 45,
      padding: EdgeInsets.symmetric(vertical: 15),
      child: CustomButton(
        btncolor: MsaColors.BaseColorLight,
        text: submitted
            ? SizedBox(
                height: 15,
                width: 15,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                "ورود",
                style: TextStyle(color: Colors.white),
              ),
        callback: submitLogin,
        borderRadius: 5,
        minWidth: MediaQuery.of(context).size.width,
      ),
      alignment: Alignment.center,
    );
  }

  void submitLogin() {
    if (submitted == false) {
      (_UsernameController.text.isNullOrEmpty() ||
              _passController.text.isNullOrEmpty())
          ? (() {
              if (_UsernameController.text.isNullOrEmpty()) {
                setState(() {
                  _validateUser = "لطفا نام کاربری را وارد کنید";
                });
              } else {
                setState(() {
                  _validateUser = "";
                });
              }
              if (_passController.text.isNullOrEmpty()) {
                setState(() {
                  _validatePass = "لطفا کلمه عبور را وارد کنید";
                });
              } else {
                setState(() {
                  _validatePass = "";
                });
              }
            })()
          : (() {
              setState(() {
                submitted = true;
              });
              lp?.load(
                  password: _passController.text,
                  username: _UsernameController.text);
            }());
    }
  }
}
