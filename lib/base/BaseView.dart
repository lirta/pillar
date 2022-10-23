import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:loadmore/loadmore.dart';
import 'package:url_launcher/url_launcher.dart';

class BaseView {
  void displaySnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
      duration: Duration(seconds: 3),
    ));
  }

  void displayToast(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white,
        fontSize: 14.0);
  }

  void displayToastLong(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white,
        fontSize: 14.0);
  }

  String convertToDate(int data, String formatDate) {
    initializeDateFormatting();
    final String result = DateFormat(formatDate, "id")
        .format(DateTime.fromMillisecondsSinceEpoch(data * 1000));
    return result;
  }

  String convertToTime(int data) {
    const String dateFormat = "HH:mm";
    final String result = DateFormat(dateFormat)
        .format(DateTime.fromMillisecondsSinceEpoch(data * 1000));
    return result;
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
//      print(url);
      await launch(url);
    } else {
      throw 'Could not launch $url';
//      return;
    }
  }

  phoneCall(String number) async {
    // Android
    var uri = 'tel:$number';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      var uri = 'tel:$number';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

  sendWhatsApp(String phone, String message) async {
    String whatsAppPhone;
    String countryCode = "62";
    if (phone.substring(0, 2) != countryCode) {
      whatsAppPhone = countryCode + phone.substring(1, phone.length);
    } else {
      whatsAppPhone = phone;
    }
    print(whatsAppPhone);
    String urlScheme() {
      return "whatsapp://send?phone=$whatsAppPhone&text=${Uri.parse(message)}";
    }

    String url() {
      return "https://wa.me/$whatsAppPhone?text=${Uri.parse(message)}";
    }

    if (await canLaunch(urlScheme())) {
      await launch(urlScheme());
    } else {
      if (await canLaunch(url())) {
        await launch(url());
      }
    }
  }

  void launchMapsUrl(String dlat, String dlong) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$dlat,$dlong';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }

    String removeAllHtmlTags(String htmlText) {
      RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
      return htmlText.replaceAll(exp, '');
    }
  }

  String formatHHMMSS(int seconds) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return "$minutesStr:$secondsStr";
    }

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  //check if data is numeric or not
  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  String currentDate(String format) {
    var now = new DateTime.now();
    var formatter = DateFormat.yMMMd("ID");
    if (format == "1") {
      formatter = new DateFormat('dd MMMM yyyy', 'ID');
    } else if (format == "2") {
      formatter = new DateFormat('yyyy-MMMM-dd ', 'ID');
    }
    String formattedDate = formatter.format(now);
    return formattedDate; // 2016-01-25
  }

  String getSystemTime() {
    var now = new DateTime.now();
    return new DateFormat("HH:mm:ss").format(now);
  }

  String indonesianText(LoadMoreStatus status) {
    String text;
    switch (status) {
      case LoadMoreStatus.fail:
        text = "Loading Gagal, Silahkan coba lagi.";
        break;
      case LoadMoreStatus.idle:
        text = "Loading";
        break;
      case LoadMoreStatus.loading:
        text = "Loading, wait a moment";
        break;
      case LoadMoreStatus.nomore:
        text = "";
        break;
      default:
        text = "";
    }
    return text;
  }

  String partNumSelection(String sentence) {
    String str = sentence;
    const start = "[";
    const end = "]";

    final startIndex = str.indexOf(start);
    final endIndex = str.indexOf(end, startIndex + start.length);

    String data = str.substring(startIndex + start.length, endIndex);
    return data;
  }

  // Widget displayNotFound(
  //     BuildContext context, String errorMessage, Function onRefresh) {
  //   return RefreshIndicator(
  //     onRefresh: onRefresh,
  //     child: SingleChildScrollView(
  //       physics: AlwaysScrollableScrollPhysics(),
  //       child: Column(
  //         children: [
  //           SizedBox(height: MediaQuery.of(context).size.height / 3),
  //           Center(
  //               child: Icon(
  //             Icons.find_in_page_outlined,
  //             size: 40.0,
  //             color: Colors.black.withOpacity(0.6),
  //           )),
  //           SizedBox(height: 6),
  //           Center(
  //             child: Text(
  //               errorMessage,
  //               style: TextStyle(
  //                   fontSize: 13.0,
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.black87),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget displayLoadingScreen(BuildContext context,
      {Color color = Colors.black}) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}
