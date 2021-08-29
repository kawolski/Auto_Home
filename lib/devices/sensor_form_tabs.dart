import 'package:auto_home/devices/forms/Smoke.dart';
import 'package:auto_home/devices/forms/T&H.dart';
import 'package:flutter/material.dart';
class SensorFormTabs extends StatefulWidget {
  @override
  _SensorFormState createState() => _SensorFormState();
}

class _SensorFormState extends State<SensorFormTabs> {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Icon(Icons.account_tree),
          title: Text('Dashboard'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.white.withOpacity(0.3),
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  child: Text('T&H'),
                ),
                Tab(
                  child: Text('Smoke'),
                ),
                Tab(
                  child: Text('Tab 3'),
                ),
                Tab(
                  child: Text('Tab 4'),
                ),
              ],
            ),
          ),
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.only(right:16.0),
          //     child: Icon(Icons.add_alert),
          //   )
          // ],
        ),
        body: TabBarView(
          children: [
            Container(
              child: Center(
                child: TAndH()
              ),
            ),
            Container(
              child: Center(
                  child: Smoke()
              ),
            ),
            Container(
              child: Center(
                  child: Text('Tab 3')
              ),
            ),
            Container(
              child: Center(
                  child: Text('Tab 4')
              ),
            ),
          ],
        ),
      ),
    );
  }
}
