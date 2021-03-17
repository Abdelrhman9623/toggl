import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggl/models/timeEntriesModule.dart';
import 'package:toggl/services/auth.dart';
import 'package:toggl/services/timeEntries.dart';
import 'package:intl/intl.dart';
import 'package:grouped_list/grouped_list.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _showDetails(int id) {
    var pItems = Provider.of<TimeEntriesHandler>(context, listen: false);
    var timeId =
        Provider.of<TimeEntriesHandler>(context, listen: false).findById(id);

    if (timeId.pid != null) {
      pItems.getProject(timeId.pid);
      return showDialog(
          context: context,
          builder: (context) {
            return FutureBuilder(
              future: pItems.getProject(timeId.pid),
              builder: (context, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? AlertDialog(
                          content: Container(
                            height: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(timeId.description),
                                Row(
                                  children: [
                                    Text('Start: '),
                                    Text(DateFormat.yMd().format(timeId.start)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(DateFormat.jms().format(timeId.start)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Stop: '),
                                    Text(DateFormat.yMd().format(timeId.stop)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(DateFormat.jms().format(timeId.stop)),
                                  ],
                                ),
                                Text('Duration: ${timeId.duration}'),
                                Text('Project name: ')
                              ],
                            ),
                          ),
                        )
                      : AlertDialog(
                          content: Container(
                            height: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(timeId.description),
                                Row(
                                  children: [
                                    Text('Start: '),
                                    Text(DateFormat.yMd().format(timeId.start)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(DateFormat.jms().format(timeId.start)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Stop: '),
                                    Text(DateFormat.yMd().format(timeId.stop)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(DateFormat.jms().format(timeId.stop)),
                                  ],
                                ),
                                Text('Duration: ${timeId.duration}'),
                                Text('Project name: ${pItems.project.name}'),
                              ],
                            ),
                          ),
                        ),
            );
          });
    } else {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(timeId.description),
                    Row(
                      children: [
                        Text('Start: '),
                        Text(DateFormat.yMd().format(timeId.start)),
                        SizedBox(
                          width: 10,
                        ),
                        Text(DateFormat.jms().format(timeId.start)),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Stop: '),
                        Text(DateFormat.yMd().format(timeId.stop)),
                        SizedBox(
                          width: 10,
                        ),
                        Text(DateFormat.jms().format(timeId.stop)),
                      ],
                    ),
                    Text('Duration: ${timeId.duration}'),
                  ],
                ),
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<TimeEntriesHandler>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
        future: items.fatchAllTimeHostory(
            '2019-09-01T00:00:00Z', '2021-09-30T00:00:00Z'),
        builder: (context, snapshot) => ListView(
          children: [
            // HERE I NEED TO DISPLAY FOR EACH DAY WHAT I DID
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: items.timeEntries.length,
                // ignore: missing_return
                itemBuilder: (context, i) {
                  var duration = DateFormat.ms().format(items.timeEntries[i].at
                      .subtract(
                          Duration(seconds: items.timeEntries[i].duration)));
                  return GestureDetector(
                    onTap: () => _showDetails(items.timeEntries[i].id),
                    child: Column(
                      children: [
                        Card(
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(items.timeEntries[i].description
                                    .toString()),
                                subtitle: Text('Duration: ${duration} s'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

// '2019-09-01T00:00:00Z', '2021-09-30T00:00:00Z')
