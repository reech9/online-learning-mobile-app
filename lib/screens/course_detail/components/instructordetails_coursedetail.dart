import 'package:digi_school/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

class Instructorcoursedetail extends StatelessWidget {
  final instructor;
  const Instructorcoursedetail({Key? key, this.instructor}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Instructor",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          Container(
            height: 110,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child:Builder(
                    builder: (context) {
                      var nameInital = instructor["firstname"][0] +
                          " " +
                          instructor["lastname"][0];
                      return CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey,
                        child: Text(
                          nameInital,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      );
                    }
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(instructor["firstname"] +
                              " " +
                              instructor["lastname"]),
                          Text(instructor["email"]),
                          Builder(builder: (context) {
                            DateTime joined =
                                DateTime.parse(instructor["joinDate"]);
                            joined = joined
                                .add(const Duration(hours: 5, minutes: 45));
                            var formattedTime =
                                DateFormat('yMMMMd').format(joined);
                            return Text(formattedTime);
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          _instructordesc(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 50,
              child: TextButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      const BorderSide(width: 1, color: Colors.black),
                    ),
                  ),
                  child: const Text(
                    "View Profile",
                    style: TextStyle(color: kBlack,fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {}),
            ),
          )
        ],
      ),
    );
  }

  Widget _instructordesc(){
    return    const Padding(
      padding:  EdgeInsets.all(8.0),
      child: ReadMoreText(
        """I am submitting my resume for consideration for the summer application design internship program at ABC Company. Given the skills and experience outlined in my enclosed resume, I believe I will be a worthy asset to your team.

In my three years at XYZ College, I’ve completed a great deal of coursework on cutting-edge design trends and best practices, including Principles of User Experience Design and Mobile Application Design, where I learned and applied skills such as user journey mapping, application wireframing and designing software for a variety of mobile devices and operating systems.""",
        style: TextStyle(
          color: Colors.black,fontSize: 15
        ),
        trimLines: 3,
        // colorClickableText: Colors.blueAccent,
        trimMode: TrimMode.Line,
        trimCollapsedText: 'Show more',
        trimExpandedText: ' Less',
        textAlign: TextAlign.justify,
        moreStyle: const TextStyle(
            fontSize: 12, color: khyperlink, fontWeight: FontWeight.bold),
        lessStyle: const TextStyle(
            fontSize: 12, color: khyperlink, fontWeight: FontWeight.bold),
      ),
    );
  }
}
