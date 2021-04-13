import 'package:flutter/material.dart';
import '../const/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:custom_progress_dialog/custom_progress_dialog.dart';

class JobCard extends StatelessWidget {
  ProgressDialog _progressDialog = ProgressDialog();

  final BuildContext context;
  final String jobTitle;
  final String jobLocation;
  final String jobID;
  JobCard(
      {@required this.context,
      @required this.jobTitle,
      @required this.jobLocation,
      @required this.jobID});
  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
      ),
      child: InkWell(
        onTap: () {
          debugPrint(this.jobID);
          String listingURL =
              "https://serpapi.com/search.json?engine=google_jobs_listing&q=${this.jobID}&api_key=$apiKey";
          _progressDialog.showProgressDialog(context, dismissAfter: null);
          http.get(Uri.parse(listingURL)).then((response) {
            Map<String, dynamic> responseJSON = jsonDecode(response.body);
            _progressDialog.dismissProgressDialog(context);
            if (!responseJSON.containsKey("apply_options")) {
              debugPrint("cant find url");
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:
                      Text("This job is not open for applicaton right now.")));
            } else {
              String url = responseJSON["apply_options"][0]["link"].toString();
              debugPrint(url);
              try {
                launch(url);
              } catch (e) {
                debugPrint("err");
              }
            }
            //debugPrint(response.body.toString());
            // try {
            //   String url = responseJSON["apply_options"][0]["link"].toString();
            //   responseJSON.containsKey("apply_options")
            //   if (url.length > 0) {
            //     launch(url);
            //   } else {
            //     debugPrint("cant find url");
            //   }
            // } catch (e) {}
          });
        },
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
      ),
    );
  }
}
