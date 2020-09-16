import 'package:bit_recorder/pages/beats/beats.dart';
import 'package:bit_recorder/pages/draweritems/drawer_items.dart';
import 'package:bit_recorder/pages/instrument/instrument.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>with SingleTickerProviderStateMixin {
  TabController _controller ;
 
 @override
  void initState() {
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Automated Music \nGeneration system'),
        centerTitle: true,
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: _controller,
          tabs: [
          Tab(text: 'BEATS',),
          Tab(text:'INSTRUMENTS')
        ]),
      ),
     
      body: TabBarView(
        controller: _controller,
        children: [
          Beats(),
          Instrument()
        ],
        ),
         drawer: DrawerItems(),
    );
  }
}