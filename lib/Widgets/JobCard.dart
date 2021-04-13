import 'package:flutter/material.dart';

class JobCard extends StatelessWidget {
  final String jobTitle;
  final String jobLocation;
  JobCard({@required this.jobTitle, @required this.jobLocation});
  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
      ),
      child: Card(
        child: Container(
          height: totalHeight * 0.12,
          width: totalWidth * 0.9,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: totalHeight * 0.015,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: totalWidth * 0.06,
                      ),
                      Text(
                        this.jobTitle,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: totalHeight * 0.027,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: totalHeight * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                    ),
                    child: Text(
                      this.jobLocation,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: totalHeight * 0.021,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromRGBO(65, 148, 131, 1),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
