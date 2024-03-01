import 'dart:async';

import 'package:faker_package/MoviesListView.dart';
import 'package:faker_package/data.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController1 = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  final ScrollController _scrollController3 = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      double minScrollExtent1 = _scrollController1.position.minScrollExtent;
      double maxScrollExtent1 = _scrollController1.position.maxScrollExtent;
      double minScrollExtent2 = _scrollController2.position.minScrollExtent;
      double maxScrollExtent2 = _scrollController2.position.maxScrollExtent;
      double minScrollExtent3 = _scrollController3.position.minScrollExtent;
      double maxScrollExtent3 = _scrollController3.position.maxScrollExtent;

      // Set the initial positions for controllers
      _scrollController1.jumpTo(maxScrollExtent1);
      _scrollController2.jumpTo(maxScrollExtent2);
      _scrollController3.jumpTo(minScrollExtent3);

      // Scroll controllers in the desired directions
      animateToMaxMin(
        minScrollExtent1,
        maxScrollExtent1,
        minScrollExtent1,
        15,
        _scrollController1,
      );
      animateToMaxMin(
        minScrollExtent2,
        maxScrollExtent2,
        minScrollExtent2,
        15,
        _scrollController2,
      );
      animateToMinMax(
        maxScrollExtent3,
        minScrollExtent3,
        maxScrollExtent3,
        15,
        _scrollController3,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController1.dispose();
    _scrollController2.dispose();
    _scrollController3.dispose();
  }

  animateToMaxMin(double max, double min, double direction, int seconds, ScrollController scrollController) {
    scrollController.animateTo(direction, duration: Duration(seconds: seconds), curve: Curves.linear).then((value) {
      direction = direction == max ? min : max;
      animateToMaxMin(max, min, direction, seconds, scrollController);
    });
  }

  animateToMinMax(double max, double min, double direction, int seconds, ScrollController scrollController) {
    scrollController.animateTo(direction, duration: Duration(seconds: seconds), curve: Curves.linear).then((value) {
      direction = direction == min ? max : min;
      animateToMinMax(max, min, direction, seconds, scrollController);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                MoviesListView(
                  scrollController: _scrollController1,
                  images: movies1,
                ),
                MoviesListView(
                  scrollController: _scrollController2,
                  images: movies2,
                ),
                MoviesListView(
                  scrollController: _scrollController3,
                  images: movies1,
                ),
              ],
            ),
            const Text(
              '30 days for free',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            Material(
              elevation: 0,
              color: const Color(0xfff2c94c),
              borderRadius: BorderRadius.circular(20),
              child: MaterialButton(
                onPressed: () {},
                minWidth: 340,
                height: 60,
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
