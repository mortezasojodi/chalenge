import 'package:behtarino/Common/Helper/Msacontext.dart';
import 'package:behtarino/Common/Variebles/Constants.dart';
import 'package:flutter/material.dart';

Widget CardView(CardItem item) {
  return Container(
    height: 100,
    width: MediaQuery.of(Msacontext()).size.width,
    child: new Card(
      color: item.color ?? Colors.blue,
      elevation: 4, // Change this
      shadowColor: MsaColors.BaseColorLight,
      child: ListTile(
        isThreeLine: true,
        leading: item.leading ?? Container(),
        title: item.title ?? Container(),
        subtitle: item.subtitle ?? Container(),
        onTap: () {
          item.onTap != null ? item.onTap!(item.Id ?? 0) : () {};
        },
        trailing: item.trailing ?? Container(),
      ),
    ),
  );
}

typedef voidint = Function(int a);

class CardItem {
  const CardItem(
      {this.Id,
      this.index,
      this.title,
      this.subtitle,
      this.color,
      this.leading,
      this.trailing,
      this.onLongPress,
      this.onTap});
  final int? Id;
  final int? index;
  final Widget? title;
  final Widget? subtitle;
  final Color? color;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onLongPress;
  final voidint? onTap;
}
