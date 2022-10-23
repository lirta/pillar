import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pillar_app/base/BaseView.dart';
import 'package:pillar_app/module/order/OrderForm.dart';
import 'package:pillar_app/module/order/pettern/OrderPresenter.dart';
import 'package:pillar_app/module/order/pettern/OrderView.dart';
import 'package:pillar_app/module/order/pettern/OrderWidget.dart';

class OrderMain extends StatefulWidget {
  const OrderMain({Key key}) : super(key: key);

  @override
  State<OrderMain> createState() => _OrderMainState();
}

class _OrderMainState extends State<OrderMain>
    with TickerProviderStateMixin
    implements OrderView {
  OrderPresener orderPresener;
  List dataList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    orderPresener = new OrderPresener();
    orderPresener.attachView(this);
    getData();
  }

  getData() async {
    await orderPresener.getOrdersList();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle appBarTextStyle = TextStyle(fontSize: 16.0, color: Colors.white);
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: new AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            InkWell(
              onTap: () async {
                final information = await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => OrderForm(type: "add"),
                        settings: RouteSettings(name: "Order add")));
                if (information != null) {
                  onRefresh();
                }
              },
              child: Icon(
                FontAwesomeIcons.plus,
                size: 20,
              ),
            ),
            SizedBox(width: 20),
          ],
          title: Text("Orders", style: appBarTextStyle),
        ),
        body: dataList != null && isLoading
            ? OrderWidget().displayOrderLis(context, dataList)
            : BaseView().displayLoadingScreen(context, color: Colors.black));
  }

  Future<Null> onRefresh() async {
    // orderPresener.getOrder(false);
    await orderPresener.getOrdersList();
  }

  @override
  onFailGetOrder(Map data) {
    // TODO: implement onFailGetOrder
    throw UnimplementedError();
  }

  @override
  onNetworkError() {
    // TODO: implement onNetworkError
    throw UnimplementedError();
  }

  @override
  onSuccessGetOrder(Map data) {
    // TODO: implement onSuccessGetOrder
    // throw UnimplementedError();
    if (this.mounted) {
      setState(() {
        dataList.addAll(data['message']);
        print(dataList.length);
        isLoading = true;
      });
    }
  }

  @override
  onFailetMenu(Map data) {
    // TODO: implement onFailetMenu
    throw UnimplementedError();
  }

  @override
  onSuccessGetMenu(Map data) {
    // TODO: implement onSuccessGetMenu
    throw UnimplementedError();
  }

  @override
  onFaildGetMenu(Map data) {
    // TODO: implement onFaildGetMenu
    throw UnimplementedError();
  }

  @override
  onFaildAddOrder(Map data) {
    // TODO: implement onFaildAddOrder
    throw UnimplementedError();
  }

  @override
  onSuccessAddOrder(Map data) {
    // TODO: implement onSuccessAddOrder
    throw UnimplementedError();
  }
}
