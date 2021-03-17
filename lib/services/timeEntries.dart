import 'package:flutter/material.dart';
import 'package:toggl/models/project.dart';
import 'package:toggl/models/timeEntriesModule.dart';
import 'package:toggl/helper/http_ex.dart';
import 'package:toggl/helper/url_helper.dart' as http;

class TimeEntriesHandler extends ChangeNotifier {
  final String token;
  TimeEntriesHandler({this.token});
  List<TimeEntries> _items = [];
  ProjectDetails _projects = ProjectDetails();

  List<TimeEntries> get timeEntries {
    return [..._items];
  }

  ProjectDetails get project {
    return _projects;
  }

  TimeEntries findById(int id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fatchAllTimeHostory([String strat, String end]) async {
    try {
      await http.UrlHelper.getRequest(
              http.UrlHelper.url(
                  'time_entries?start_date=$strat&end_date=$end'),
              http.UrlHelper.header(token))
          .then((value) {
        List<TimeEntries> _currentValue = [];
        if (value == 401 || value == 403 || value == 404) {
          throw HttpException('Not found time Hostory');
        } else {
          for (var i = 0; i < value.length; i++) {
            _currentValue.add(TimeEntries.fromMap(value[i]));
          }
        }
        _items = _currentValue;
      });
      notifyListeners();
    } catch (e) {
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
