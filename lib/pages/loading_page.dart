import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import '../assets/constants.dart';

///
/// Widget for displaying loading animation and doing background work at the same time.
///
class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  _LoadingPageState createState() => _LoadingPageState();
}
class _LoadingPageState extends State<LoadingPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Material(
      child : Row(
        children: [
        Center(
        child: LoadingBouncingGrid.square(
          backgroundColor: LOADING_ICON_COLOR,
          size: LOADING_ICON_SIZE,
        )
        ), Text(widget.id)
        ]
      )
    );
  }

}