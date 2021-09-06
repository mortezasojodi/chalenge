import 'package:behtarino/Common/Variebles/Constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? callback;
  final Widget? text;
  final Color btncolor;
  final Color? textcolor;
  final double borderRadius;
  final double minWidth;
  final double height;

  const CustomButton(
      {Key? key,
      this.callback,
      this.text,
      this.btncolor = Colors.blue,
      this.textcolor,
      this.borderRadius = 30,
      this.minWidth = 200,
      this.height = 65})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: minWidth,
      height: height,
      padding: EdgeInsets.all(8),
      child: ElevatedButton(
        child: text,
        onPressed: callback,
        style: ElevatedButton.styleFrom(
          primary: btncolor,
          onPrimary: MsaColors.TextColorLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
      // child: Material(

      //   color: btncolor,
      //   elevation: 6,
      //   borderRadius: BorderRadius.circular(borderRadius),
      //   child: MaterialButton(

      //     onPressed: callback,
      //     minWidth: minWidth,
      //     height: height,
      //     child: text,
      //   ),
      // ),
    );
  }
}

// BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(5)),
//           boxShadow: <BoxShadow>[
//             BoxShadow(
//                 color: Colors.grey.shade200,
//                 offset: Offset(2, 4),
//                 blurRadius: 5,
//                 spreadRadius: 2)
//           ],
//           gradient: LinearGradient(
//               begin: Alignment.centerLeft,
//               end: Alignment.centerRight,
//               colors: [                  
//                 Colors.lightBlueAccent,
//                       Colors.blue,]))