import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

typedef BuildBodyAnimate = Function(BuildContext b, dynamic i,
    AnimationController a, Animation<double> ad, int index);

class InfiniteListAnimate<T> extends StatefulWidget {
  InfiniteListAnimate(
      {Key? key,
      this.itemBuilder,
      this.buildBody,
      this.lstcount,
      this.controller,
      this.refreshController,
      this.onEndList,
      this.onRefresh,
      this.endListSpinner = false,
      this.TopListSpinner = false,
      this.endlistColor,
      this.getdata,
      this.listinit})
      : super(key: key);
  final ScrollController? controller;
  final RefreshController? refreshController;
  final IndexedWidgetBuilder? itemBuilder;
  final BuildBodyAnimate? buildBody;
  final int? lstcount;
  final bool endListSpinner;
  final bool TopListSpinner;
  final Color? endlistColor;
  final VoidCallback? onEndList;
  final VoidCallback? onRefresh;
  final Future<List<T>> Function()? getdata;
  final List<T> Function(dynamic data)? listinit;

  @override
  _InfiniteListAnimateState<T> createState() => _InfiniteListAnimateState<T>();
}

class _InfiniteListAnimateState<T> extends State<InfiniteListAnimate>
    with TickerProviderStateMixin {
  int page = 1;

  bool endListSpinner = false;
  bool TopListSpinner = false;
  List<dynamic> lstModel = [];
  bool forceRefresh = true;
  AnimationController? animationController;
  Animation<double>? animation;
  List<dynamic> respons = [];
  ScrollController _controller = ScrollController();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    if (widget.getdata == null) {
      widget.controller!.addListener(() {
        if (widget.controller!.position.atEdge) {
          if (widget.controller!.position.pixels ==
                  widget.controller!.position.maxScrollExtent &&
              widget.lstcount != 0) {
            if (widget.onEndList != null) widget.onEndList!();
          }
          // you are at top position
          else {}
          // you are at bottom position
        }
      });
    } else {
      _controller.addListener(() {
        if (_controller.position.atEdge) {
          if (_controller.position.pixels ==
                  _controller.position.maxScrollExtent &&
              lstModel != 0) {
            onEndList();
          }
          // you are at top position
          else {}
          // you are at bottom position
        }
      });
    }
    setState(() {
      TopListSpinner = true;
    });
    getdata();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  void getdata() async {
    respons = await widget.getdata!();

    if (respons.length > 0) {
      lstModel.addAll(respons);
    }
    setState(() {
      endListSpinner = false;
      TopListSpinner = false;
    });
  }

  void refresh() {
    setState(() {
      page = 1;
      TopListSpinner = true;
      lstModel = [];
    });
    getdata();
  }

  void onEndList() async {
    // if (mounted) {
    //   setState(() {
    //     page = page + 1;
    //     endListSpinner = true;
    //   });
    // }
    // getdata();
  }

  void pullRefresh() async {
    animationController?.reverse();
    // if failed,use refreshFailed()
    _controller.animateTo(
      0.0,
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 300),
    );
    refreshController.refreshCompleted();
    if (mounted)
      setState(() {
        TopListSpinner = true;
        forceRefresh = true;
        page = 1;
        lstModel = [];
      });
    getdata();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));

    if (mounted) setState(() {});
    widget.getdata == null
        ? widget.refreshController!.loadComplete()
        : refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        Visibility(
          visible:
              widget.getdata == null ? widget.TopListSpinner : TopListSpinner,
          child: SpinKitThreeBounce(
            color: widget.endlistColor,
            size: 20,
          ),
        ),
        Expanded(
          child: SizedBox(
            child: SmartRefresher(
              controller: widget.getdata == null
                  ? widget.refreshController!
                  : refreshController,
              onRefresh:
                  widget.getdata == null ? widget.onRefresh : pullRefresh,
              onLoading: _onLoading,
              child: new ListView.builder(
                controller:
                    widget.getdata == null ? widget.controller : _controller,
                // scrollDirection: Axis.horizontal,
                itemCount:
                    widget.getdata == null ? widget.lstcount : lstModel.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  final int count = widget.getdata == null
                      ? widget.lstcount!
                      : lstModel.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController?.forward();
                  return widget.getdata == null
                      ? widget.buildBody!(context, index, animationController!,
                          animation, index)
                      : widget.buildBody!(context, lstModel[index],
                          animationController!, animation, index);
                },
              ),
            ),
          ),
        ),
        Visibility(
          visible:
              widget.getdata == null ? widget.endListSpinner : endListSpinner,
          child: SpinKitThreeBounce(
            color: widget.endlistColor,
            size: 20,
          ),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
