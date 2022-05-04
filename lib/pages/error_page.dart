import 'package:flutter/material.dart';
import '../assets/constants.dart';

///
/// Widget for displaying error page.
///
class ErrorPage extends StatefulWidget {
  const ErrorPage({Key? key}) : super(key: key);
  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
        color: ERROR_TEXT_COLOR,
        child : Center(
            child: Text("Sorry, an error has been encountered...", textAlign: TextAlign.center)
        )
    );
  }

}