import 'package:behtarino/Common/Extentions/StringExtentions.dart';
import 'package:behtarino/Common/Helper/Msacontext.dart';
import 'package:behtarino/Common/Variebles/Constants.dart';
import 'package:flutter/material.dart';

Widget entryField(String hint,
    {String? Title,
    String? hintText,
    Color? textColor,
    Function(String)? onChange,
    bool isPassword = false,
    String validate = "",
    Color? fillcolors,
    TextEditingController? userController}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Title == null
            ? Container()
            : Text(
                hint,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
        Title == null
            ? Container()
            : SizedBox(
                height: 10,
              ),
        TextField(
          onChanged: onChange,
          style: TextStyle(color: textColor ?? MsaColors.TextColorLight),
          controller: userController,
          textAlign: TextAlign.right,
          obscureText: isPassword,
          decoration: InputDecoration(
            fillColor: fillcolors ?? Color(0xfff3f3f4),
            errorText: validate != "" ? validateUser(validate) : null,
            // fillColor: Colors.grey[700],
            filled: true,
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        )
      ],
    ),
  );
}

Widget entryFieldBordered(String title,
    {String? hintText,
    bool isPassword = false,
    int maxLines = 1,
    String validateUsers = "",
    TextEditingController? userController,
    TextInputType? inputtype,
    VoidCallback? ontap,
    bool? keybordHide,
    Color? enableBorder,
    Color? focusedBorder}) {
  return GestureDetector(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            TextField(
              showCursor: keybordHide,
              readOnly: keybordHide ?? false,
              onTap: ontap,
              keyboardType: inputtype,
              maxLines: maxLines,
              style: TextStyle(color: MsaColors.TextColorLight),
              controller: userController,
              textAlign: TextAlign.right,
              obscureText: isPassword,
              decoration: InputDecoration(
                fillColor: Color(0xfff3f3f4),
                errorText:
                    validateUsers != "" ? validateUser(validateUsers) : null,
                // fillColor: Colors.grey[700],

                filled: true,
                hintText: hintText ?? title,
                hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: enableBorder ?? MsaColors.BaseColorLight,
                      width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: focusedBorder ?? Colors.blue, width: 2.0),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget entryFieldBorderedSample(String title,
    {String? hintText,
    bool isPassword = false,
    int maxLines = 1,
    String validateUsers = "",
    TextEditingController? userController,
    TextInputType? inputtype,
    bool? keybordHide,
    VoidCallback? ontap,
    void Function(String)? onchange}) {
  return TextField(
      showCursor: keybordHide,
      readOnly: keybordHide ?? false,
      onChanged: (value) {
        onchange == null ? () {} : onchange(value);
      },
      keyboardType: inputtype,
      onTap: ontap,
      maxLines: maxLines,
      style: TextStyle(color: MsaColors.TextColorLight),
      controller: userController,
      textAlign: TextAlign.right,
      obscureText: isPassword,
      decoration: InputDecoration(
        fillColor: Color(0xfff3f3f4),
        errorText: validateUsers != "" ? validateUser(validateUsers) : null,
        // fillColor: Colors.grey[700],

        filled: true,
        hintText: hintText ?? title,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
        // enabledBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.blue, width: 1.0),
        // ),
        // focusedBorder: OutlineInputBorder(
        //   borderSide:
        //       BorderSide(color: AzColors.BaseColorLightPrsTimeCard, width: 2.0),
        // ),
      ));
}

Widget dropdown<T>(Map<String, dynamic> list,
    {String? title,
    String? hintText,
    Function(T)? OnChange,
    String? validate,
    Color? enableBorder,
    Color? focusedBorder}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
    child: Column(
      children: [
        title == null
            ? Container()
            : Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
        Center(
            child: DropdownButtonFormField<T>(
          validator: (s) {},

          decoration: InputDecoration(
            errorText:
                !validate!.isNullOrEmpty() ? validateUser(validate) : null,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: enableBorder ?? MsaColors.BaseColorLight, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: focusedBorder ?? Colors.blue, width: 2.0),
            ),
          ),
          style: TextStyle(),
          isExpanded: true,

          hint: Align(
            alignment: Alignment.centerRight,
            child: Text(
              hintText ?? "",
            ),
          ), // Not necessary for Option 1
          onTap: () {
            FocusScope.of(Msacontext()).requestFocus(new FocusNode());
          },
          onChanged: (newValue) => OnChange!(newValue!),
          items: list
              .map((description, value) {
                return MapEntry(
                    description,
                    DropdownMenuItem<T>(
                      value: value,
                      child: Center(
                        child: Text(
                          description,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ));
              })
              .values
              .toList(),
        )),
      ],
    ),
  );
}

Widget InputForm(String labelText,
    {TextEditingController? controller,
    VoidCallback? ontap,
    Color? fillcolor}) {
  return TextFormField(
    controller: controller,

    decoration: InputDecoration(
        filled: true,
        fillColor: fillcolor,
        labelText: labelText,
        border: OutlineInputBorder()),

    // keyboardType: widget.keyboardType,
    // style: widget.style,
    // textAlign: widget.textAlign,
    // autofocus: widget.autofocus,
    // obscureText: widget.obscureText,
    // autocorrect: widget.autocorrect,
    // maxLengthEnforcement: widget.maxLengthEnforcement,
    // maxLines: widget.maxLines,
    // maxLength: widget.maxLength,
    // scrollPadding: widget.scrollPadding,
    // textCapitalization: widget.textCapitalization,
    // inputFormatters: widget.inputFormatters,
    // enabled: widget.enabled,
    // onFieldSubmitted: (value) {
    //   if (widget.onFieldSubmitted != null) {
    //     return widget.onFieldSubmitted!(_value);
    //   }
    // },
    validator: (value) {
      return " widget.validator!(_value);";
    },
    onTap: ontap,
    // onSaved: (value) {
    //   if (widget.onSaved != null) {
    //     return widget.onSaved!(_value);
    //   }
    // },
  );
}

String? validateUser(String value) {
  return value;
}
