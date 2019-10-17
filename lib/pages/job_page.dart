import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_boss/model/job.dart';
import 'package:flutter_boss/config/config.dart';
import 'package:flutter_boss/widgets/job_item.dart';

class JobPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _JobPageState();
  }

}

class _JobPageState extends State<JobPage> with AutomaticKeepAliveClientMixin {

  // Future是什么意思
  Future<List<Job>> _fetchJobList() async {
    final response = await http.get('${Config.BASE_URL}/jobs/list/1');
    List<Job> jobList = List<Job>();
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      for (dynamic data in result['data']['jobs']) {
        Job jobData = Job.fromJson(data);
        jobList.add(jobData);
      }
    }
    return jobList;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text('职位', style:  TextStyle(color: Colors.white, fontSize: 20.0),),
      ),
      body: Center(
        child: FutureBuilder(
          future: _fetchJobList(),
          builder: (context, AsyncSnapshot snapshot) {
            print(snapshot.connectionState);
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return new CircularProgressIndicator();
              default:
                if (snapshot.hasError) {
                  return new Text('Error: ${snapshot.error}');
                } else {
                  return _createListView(context, snapshot);
                }
            }
          },
        ),
      )
    );
  }

}

Widget _createListView(BuildContext context, AsyncSnapshot snapshot) {
  List<Job> jobList = snapshot.data;
  return ListView.builder(
    key: new PageStorageKey('job-list'),
    itemCount: jobList.length,
    itemBuilder: (BuildContext context, int index) {
      return new JobItem(onPressed: () {}, job: jobList[index]);
    },
  );
}