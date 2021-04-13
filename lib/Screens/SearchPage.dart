import 'package:flutter/material.dart';
import 'package:work_nigeria/Screens/JobList.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController jobController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  void clearCache() {
    print("clearing ! ");
    jobController.clear();
    locationController.clear();
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
          backgroundColor: Color.fromRGBO(65, 148, 131, 1),
          title: Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 20.0),
            child: Text(
              "Work Nigeria",
              style: TextStyle(
                fontSize: totalHeight * 0.03,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: totalHeight * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text(
              "Search thousands of job in Nigeria !",
              style: TextStyle(
                fontSize: totalHeight * 0.027,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: totalHeight * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: Colors.white,
                child: Container(
                  height: totalHeight * 0.1,
                  width: totalWidth * 0.85,
                  child: TextField(
                    controller: jobController,
                    decoration: InputDecoration(
                      hintText: "Search Job",
                      hintStyle: TextStyle(
                        color: Colors.grey[900],
                        fontSize: totalHeight * 0.025,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                        top: 30.0,
                        left: 35.0,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: Colors.white,
                child: Container(
                  height: totalHeight * 0.1,
                  width: totalWidth * 0.85,
                  child: TextField(
                    controller: locationController,
                    decoration: InputDecoration(
                      hintText: "Location",
                      hintStyle: TextStyle(
                        color: Colors.grey[900],
                        fontSize: totalHeight * 0.025,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                        top: 30.0,
                        left: 35.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: totalHeight * 0.08,
          ),
          Container(
            height: totalHeight * 0.07,
            width: totalWidth * 0.85,
            decoration: BoxDecoration(
              color: Color.fromRGBO(65, 148, 131, 1),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  print(jobController.value.text);
                  print(locationController.value.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JobList(
                          searchedJob: jobController.value.text,
                          seachedLocation: locationController.value.text),
                    ),
                  );

                  // jobController.clear();
                  // locationController.clear();
                },
                child: Text(
                  "SEARCH",
                  style: TextStyle(
                    fontSize: totalHeight * 0.025,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
