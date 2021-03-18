import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggl/services/timeEntries.dart';

class DetailseScreen extends StatefulWidget {
  static const routeName = '/details';
  const DetailseScreen({Key key}) : super(key: key);

  @override
  _DetailseScreenState createState() => _DetailseScreenState();
}

class _DetailseScreenState extends State<DetailseScreen> {
  @override
  Widget build(BuildContext context) {
    final tId = ModalRoute.of(context).settings.arguments as int;
    final getProject = Provider.of<TimeEntriesHandler>(context, listen: false);
    final timeDetails =
        Provider.of<TimeEntriesHandler>(context, listen: false).findById(tId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                'Description ${timeDetails.description}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                'Start: ${timeDetails.start}',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                'Stop: ${timeDetails.stop}',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                'Duration: ${timeDetails.duration}',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ),
            timeDetails.pid == null
                ? Container()
                : FutureBuilder(
                    future: getProject.getProject(timeDetails.pid),
                    builder: (context, snapshot) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(snapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? ''
                                  : 'Project Name ${getProject.project.name}'),
                            ),
                            Container(
                              child: Text(snapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? ''
                                  : 'status: ${getProject.project.active ? "active" : "inActive"} '),
                            ),
                          ],
                        )),
          ],
        ),
      ),
    );
  }
}
