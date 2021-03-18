import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toggl/models/project.dart';
import 'package:toggl/models/timeEntriesModule.dart';
import 'package:toggl/helper/http_ex.dart';
import 'package:toggl/helper/url_helper.dart' as http;

class TimeEntriesHandler extends ChangeNotifier {
  final String token;
  TimeEntriesHandler(this.token, this._items);
  List<TimeEntries> _items = [];
  Map<String, dynamic> _dataTime = {};
  ProjectDetails _projects = ProjectDetails();

  List<TimeEntries> get timeEntries {
    return [..._items];
  }

  Map<dynamic, dynamic> get data {
    return _dataTime;
  }

  ProjectDetails get project {
    return _projects;
  }

  TimeEntries findById(int id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fatchAllTimeHostory([String strat, String end]) async {
    try {
      Map<String, dynamic> sortedData = {};
      List<TimeEntries> _chachData = [];
      await http.UrlHelper.getRequest(
              http.UrlHelper.url(
                  'time_entries?start_date=$strat&end_date=$end'),
              http.UrlHelper.header(token))
          .then((value) {
        if (value == 401 || value == 403 || value == 404) {
          throw HttpException('Not found time Hostory');
        } else {
          var index = 0;
          var dar = '';
          for (var i = 0; i < value.length; i++) {
            _chachData.add(TimeEntries.fromMap(value[i]));
            dar = DateFormat('yyyy-MM-dd')
                .format(DateTime.parse(value[index]['at']));
            if (DateFormat('yyyy-MM-dd')
                    .format(DateTime.parse(value[i]['at'])) ==
                dar) {
              if (sortedData[dar] == null) {
                sortedData[dar] = [value[i]];
              } else {
                sortedData[dar].add(value[i]);
              }
            } else {
              index = i;
              i--;
            }
          }
        }
      });
      _dataTime = sortedData;
      _items = _chachData;
      notifyListeners();
      return sortedData;
    } catch (e) {
      print('err: $e');
      throw e;
    }
  }

  Future<void> getProject(int id) async {
    try {
      await http.UrlHelper.getRequest(
              http.UrlHelper.url('projects/$id'), http.UrlHelper.header(token))
          .then((value) {
        List<ProjectDetails> _loadedprojects = [];
        if (value == 401 || value == 403 || value == 404) {
          print(value);
          throw HttpException('Not found time Hostory');
        }
        _projects = ProjectDetails.fromMap(value['data']);
      });
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
