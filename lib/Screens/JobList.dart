import 'package:flutter/material.dart';
import 'package:work_nigeria/Widgets/JobCard.dart';

class JobList extends StatefulWidget {
  final String searchedJob;
  final String seachedLocation;

  JobList({@required this.searchedJob, @required this.seachedLocation});
  @override
  _JobListState createState() => _JobListState();
}

class _JobListState extends State<JobList> {
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
            child: Icon(
              Icons.arrow_back,
              size: totalHeight * 0.04,
              color: Colors.white,
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
      body: Column(
        children: [
          SizedBox(
            height: totalHeight * 0.02,
          ),
          Row(
            children: [
              SizedBox(
                width: totalWidth * 0.05,
              ),
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
          SizedBox(
            height: totalHeight * 0.01,
          ),
          JobCard(
            jobTitle: "Software Engineer intern",
            jobLocation: "We need an intern at our company",
          ),
          JobCard(jobTitle: "Manager", jobLocation: "need a man experienced"),
          JobCard(
              jobTitle: "Project Manager",
              jobLocation: "only apply if you have")
        ],
      ),
    );
  }
}
