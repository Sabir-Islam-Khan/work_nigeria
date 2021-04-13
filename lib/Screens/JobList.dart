import 'package:flutter/material.dart';
import 'package:work_nigeria/Widgets/JobCard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../const/api.dart';

bool isLoaded = false;
Map<String, dynamic> jobList;

class JobList extends StatefulWidget {
  final String searchedJob;
  final String seachedLocation;

  JobList({@required this.searchedJob, @required this.seachedLocation});
  @override
  _JobListState createState() => _JobListState(searchedJob, seachedLocation);
}

class _JobListState extends State<JobList> {
  String _searchedJob, _searchedLocation;
  _JobListState(sJ, sL) {
    _searchedJob = sJ;
    _searchedLocation = sL;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoaded = false;
    });
    String jobAPI =
        "https://serpapi.com/search.json?engine=google_jobs&q=$_searchedJob&location=$_searchedLocation&hl=en&api_key=$apiKey";
    http.get(Uri.parse(jobAPI)).then((response) {
      jobList = jsonDecode(response.body);
      debugPrint(jobList["jobs_results"][0].toString());
      setState(() {
        isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            leading: Padding(
              padding: EdgeInsets.only(
                top: 15.0,
                left: 20.0,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  size: totalHeight * 0.04,
                  color: Colors.white,
                ),
              ),
            ),
            backgroundColor: Color.fromRGBO(65, 148, 131, 1),
            title: Row(
              children: [
                SizedBox(
                  width: totalWidth * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                  ),
                  child: Text(
                    "Job Result",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: totalHeight * 0.03,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: isLoaded
            ? ListView.builder(
                itemCount: jobList["jobs_results"].length,
                itemBuilder: (BuildContext context, int i) {
                  if (i == 0) {
                    return Padding(
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: Row(
                        children: [
                          Text(
                            "Results for ${widget.searchedJob}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: totalHeight * 0.025,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return JobCard(
                    context: context,
                    jobTitle: jobList["jobs_results"][i]["title"].toString(),
                    companyName:
                        jobList["jobs_results"][i]["company_name"].toString(),
                    jobID: jobList["jobs_results"][i]["job_id"],
                    jobDesc:
                        jobList["jobs_results"][i]["description"].toString(),
                  );
                },
              )
            : Center(child: CircularProgressIndicator()));
  }
}
