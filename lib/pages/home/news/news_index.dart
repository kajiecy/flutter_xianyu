import 'package:flutter/material.dart';

class NewsIndex extends StatefulWidget {
  @override
  _NewsIndexState createState() => _NewsIndexState();

}

class _NewsIndexState extends State<NewsIndex> with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'LEFT'),
    Tab(text: 'RIGHT'),
    Tab(text: 'RIGHT'),
    Tab(text: 'LEFT'),
    Tab(text: 'RIGHT'),
    Tab(text: 'RIGHT'),
    Tab(text: 'LEFT'),
    Tab(text: 'RIGHT'),
    Tab(text: 'RIGHT'),
  ];

  @override
  void initState() {
    print('触发初始化事件');
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print('触发build事件');
    return FutureBuilder(
        future: initData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DefaultTabController(
              length: 9,
              child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    tooltip: 'Navigreation',
                    onPressed: () => debugPrint('Navigreation button is pressed'),
                  ),
                  title: Text('导航'),
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: <Widget>[
                      Tab(icon: Icon(Icons.local_florist)),
                      Tab(icon: Icon(Icons.change_history)),
                      Tab(icon: Icon(Icons.directions_bike)),
                      Tab(icon: Icon(Icons.local_florist)),
                      Tab(icon: Icon(Icons.change_history)),
                      Tab(icon: Icon(Icons.directions_bike)),
                      Tab(icon: Icon(Icons.local_florist)),
                      Tab(icon: Icon(Icons.change_history)),
                      Tab(icon: Icon(Icons.directions_bike)),
                    ],
                  ),
                ),
              ),
            );
          }else{
            return Center(
              child: Text('没有数据'),
            );
          }
        });

  }

  Future initData() async {
    setState((){});
    return 'ok';
  }
}
