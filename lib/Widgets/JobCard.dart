import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../const/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';

class JobCard extends StatelessWidget {
  ProgressDialog _progressDialog = ProgressDialog();

  final BuildContext context;
  final String jobTitle;
  final String companyName;
  final String jobID;
  final String jobDesc;
  JobCard({
    @required this.context,
    @required this.jobTitle,
    @required this.companyName,
    @required this.jobID,
    @required this.jobDesc,
  });
  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
      ),
      child: InkWell(
        onTap: () {
          showMaterialModalBottomSheet(
            context: context,
            builder: (context) => Container(
              height: totalHeight * 0.6,
              width: totalWidth * 1,
              color: Colors.grey[200],
              child: Column(
                children: [
                  SizedBox(
                    height: totalHeight * 0.02,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: totalWidth * 0.07,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: Color.fromRGBO(65, 148, 131, 1),
                          size: 30.0,
                        ),
                      ),
                      SizedBox(
                        width: totalWidth * 0.55,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: InkWell(
                          onTap: () {
                            debugPrint(this.jobID);
                            String listingURL =
                                "https://serpapi.com/search.json?engine=google_jobs_listing&q=${this.jobID}&api_key=$apiKey";
                            _progressDialog.showProgressDialog(context,
                                dismissAfter: null);
                            http.get(Uri.parse(listingURL)).then((response) {
                              Map<String, dynamic> responseJSON =
                                  jsonDecode(response.body);
                              _progressDialog.dismissProgressDialog(context);
                              if (!responseJSON.containsKey("apply_options")) {
                                Navigator.pop(context);
                                debugPrint("cant find url");
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "This job is not open for applicaton right now.")));
                              } else {
                                String url = responseJSON["apply_options"][0]
                                        ["link"]
                                    .toString();
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
                          child: Container(
                            height: totalHeight * 0.037,
                            width: totalWidth * 0.2,
                            color: Color.fromRGBO(65, 148, 131, 1),
                            child: Center(
                              child: Text(
                                "Apply",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: totalWidth * 0.035,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: totalHeight * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                    ),
                    child: Container(
                      height: totalHeight * 0.5,
                      width: totalWidth * 1,
                      child: SingleChildScrollView(
                        child: AutoSizeText(
                          this.jobDesc,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                          // maxFontSize: 18.0,
                          minFontSize: 14.0,
                          // maxLines: 20,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
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
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 10.0,
                      ),
                      child: Container(
                        width: totalWidth * 0.83,
                        height: totalHeight * 0.035,
                        child: AutoSizeText(
                          this.jobTitle,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          maxFontSize: 20.0,
                          minFontSize: 10.0,
                          stepGranularity: 1,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: totalHeight * 0.01,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5.0),
                      width: totalWidth * 0.83,
                      height: totalHeight * 0.035,
                      child: AutoSizeText(
                        this.companyName,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        maxFontSize: 20.0,
                        minFontSize: 10.0,
                        stepGranularity: 1,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: InkWell(
                    // onTap: () {

                    // },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Color.fromRGBO(65, 148, 131, 1),
                    ),
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
