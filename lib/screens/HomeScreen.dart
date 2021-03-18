import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggl/screens/timeDetails.dart';
import 'package:toggl/services/timeEntries.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var total = 0;
  @override
  Widget build(BuildContext context) {
    final items = Provider.of<TimeEntriesHandler>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: FutureBuilder(
        future: items.fatchAllTimeHostory(
            '2019-09-01T00:00:00Z', '2021-09-30T00:00:00Z'),
        builder: (context, snapshot) => ListView(
          children: [
            ListView.builder(
                padding: EdgeInsets.all(15),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                reverse: true,
                itemCount: items.data.length,
                itemBuilder: (context, i) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat.MMMEd().format(DateTime.parse(
                                    items.data.keys.toList()[i])),
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                DateFormat.ms().format(
                                    DateTime.fromMillisecondsSinceEpoch(total)),
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: items.data.values.toList()[i].length,
                          // ignore: missing_return
                          itemBuilder: (context, j) {
                            total +=
                                items.data.values.toList()[i][j]['duration'];
                            return GestureDetector(
                              onTap: () => Navigator.of(context).pushNamed(
                                  DetailseScreen.routeName,
                                  arguments: int.parse(items.data.values
                                      .toList()[i][j]['id']
                                      .toString())),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(items.data.values.toList()[i][j]
                                          ['description']),
                                      Text('Duration: ' +
                                          DateFormat.ms().format(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  items.data.values.toList()[i]
                                                      [j]['duration'])))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
