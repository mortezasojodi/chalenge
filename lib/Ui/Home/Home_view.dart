import 'package:behtarino/Common/Helper/Msacontext.dart';
import 'package:behtarino/Common/Socket/MqttServer.dart';
import 'package:behtarino/Common/Variebles/Constants.dart';
import 'package:behtarino/Common/Widgets/Appbar.dart';
import 'package:behtarino/Common/Widgets/Card.dart';
import 'package:behtarino/Common/Widgets/InfiniteList.dart';
import 'package:behtarino/Model/Home/Contact.dart';
import 'package:behtarino/Ui/Chat/Chat.dart';
import 'package:behtarino/Ui/Core/Ui_Methods.dart';
import 'package:behtarino/Ui/Home/HomePresenter.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> implements UiMethods<Contact> {
  void showContactlst(List<Contact> items) {}
  void showError() {}

  @override
  void initState() {
    super.initState();
    (() async {
      var t = await mttq().mainMqtt();
    }());
  }

  HomePresenter? hp;

  _HomeState() {
    hp = new HomePresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MsaAppbar(),
      body: InfiniteListAnimate<Contact>(
        buildBody: (c, i, a, ad, index) {
          return HotelListView(
            contract: i,
            animation: ad,
            animationController: a,
          );
        },
        getdata: hp!.loadContacts,
        endlistColor: MsaColors.BaseColorLight,
      ),
    );
  }
}

class HotelListView extends StatefulWidget {
  const HotelListView(
      {Key? key,
      this.contract,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final Contact? contract;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  _HotelListViewState createState() => _HotelListViewState();
}

class _HotelListViewState extends State<HotelListView>
    with SingleTickerProviderStateMixin {
  CardItem? ci;
  setitem() {
    ci = new CardItem(
        onTap: (i) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Chat(
                      token: widget.contract!.Token,
                    )),
          );
        },
        leading: Column(
          children: [
            CircleAvatar(
              backgroundColor: MsaColors.BaseColorLight,
              child: TextButton(
                onPressed: () {},
                child: Text(widget.contract?.Name![0] ?? "",
                    style: TextStyle(
                      color: MsaColors.TextColordark,
                    )),
              ),
              foregroundColor: Colors.white,
            ),
          ],
        ),
        title: Text(widget.contract?.Name ?? ""),
        trailing: Text(""),
        subtitle: Text(""),
        color: MsaColors.TextColordark);
  }

  @override
  void initState() {
    super.initState();

    setitem();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool? loading = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - widget.animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {},
                child: CardView(ci!),
              ),
            ),
          ),
        );
      },
    );
  }
}
