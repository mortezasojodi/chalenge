import 'package:behtarino/Common/Extentions/StringExtentions.dart';
import 'package:behtarino/Common/Helper/LocalStorage.dart';
import 'package:behtarino/Common/Helper/Msacontext.dart';
import 'package:behtarino/Common/Variebles/Constants.dart';
import 'package:behtarino/Common/Widgets/CustomButton.dart';
import 'package:behtarino/Common/Widgets/Inputs.dart';
import 'package:behtarino/Ui/Core/Ui_Methods.dart';
import 'package:flutter/material.dart';

import 'FirstLoginPresenter.dart';

class FirstLogin extends StatefulWidget {
  const FirstLogin({Key? key}) : super(key: key);

  @override
  _FirstLoginState createState() => _FirstLoginState();
}

class _FirstLoginState extends State<FirstLogin> implements UiMethodsBit {
  var submitted = false;
  final _Controller = TextEditingController();
  String _validate = "";
  void IsSuccess(bool IsSucces) {
    print("");
    MsaNavigator(context).pushReplacementNamed("/Login");
  }

  void showError() {
    print("");
    setState(() {
      submitted = false;
    });
  }

  FirstLoginPresenter? lp;

  _FirstLoginState() {
    lp = new FirstLoginPresenter(this);
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
            children: [phoneField(), SubmitBtn()],
          ),
        ),
      ),
    );
  }

  Widget phoneField() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      child: entryField("نام کاربری",
          userController: _Controller, validate: _validate, onChange: (text) {
        if (text.length == 0) {
          setState(() {
            _validate = "لطفا نام کاربری را وارد کنید";
          });
        } else
          setState(() {
            _validate = "";
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
      (_Controller.text.isNullOrEmpty())
          ? (() {
              if (_Controller.text.isNullOrEmpty()) {
                setState(() {
                  _validate = "لطفا نام کاربری را وارد کنید";
                });
              } else {
                setState(() {
                  _validate = "";
                });
              }
            })()
          : (() {
              setState(() {
                submitted = true;
              });
              lp?.load(
                phone: _Controller.text,
              );
            }());
    }
  }
}
