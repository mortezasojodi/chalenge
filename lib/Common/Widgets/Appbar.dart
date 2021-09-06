import 'package:behtarino/Common/Helper/Msacontext.dart';
import 'package:behtarino/Common/Variebles/Constants.dart';
import 'package:flutter/material.dart';

PreferredSize MsaAppbar(
    {Widget? left, Widget? Right, Widget? center, Color? color}) {
  return new PreferredSize(
    child: new Container(
      height: 100,
      padding:
          new EdgeInsets.only(top: MediaQuery.of(Msacontext()).padding.top),
      child: new Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Stack(
          children: [
            Align(alignment: Alignment.centerLeft, child: left ?? Container()),
            Align(child: center ?? Container()),
            Align(alignment: Alignment.centerRight, child: Right ?? Container())
          ],
        ),
      ),
      decoration: new BoxDecoration(
        color: color ?? MsaColors.BaseColorLight,
      ),
    ),
    preferredSize: new Size(MediaQuery.of(Msacontext()).size.width, 150.0),
  );
}
