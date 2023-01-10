import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';

import 'package:digi_school/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class CategoryFilter extends StatefulWidget {
  const CategoryFilter({Key? key}) : super(key: key);

  @override
  _CategoryFilterState createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  String dropdownValue = 'Default';
  bool _showFilter = false;

  bool _value = false;
  int val = -1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                scafoldHeader("Category Filter"),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Sort by",
                  style: TextStyle(
                      color: kBlack, fontSize: p1, fontWeight: FontWeight.w600),
                ),
                StatefulBuilder(builder: (context, setState) {
                  return DropdownButton<String>(
                    isExpanded: true,
                    value: dropdownValue,
                    elevation: 16,
                    style: const TextStyle(color: gray_900),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                      // sort here
                    },
                    items: <String>[
                      'Default',
                      'Price High to Low',
                      'Price Low to High',
                      'Rating High to Low',
                      'Rating Low to High'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  );
                }),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Pricing",
                  style: TextStyle(
                      color: kBlack, fontSize: p1, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                StatefulBuilder(builder: (context, setState) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Builder(builder: (context) {
                          int radioValue = 1;
                          return InkWell(
                            onTap: () {
                              setState(() {
                                val = radioValue;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Radio(
                                      value: radioValue,
                                      groupValue: val,
                                      onChanged: (value) {
                                        setState(() {
                                          val = radioValue;
                                        });
                                      },
                                      activeColor: kPrimaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Paid")
                                ],
                              ),
                            ),
                          );
                        }),
                        Builder(builder: (context) {
                          int radioValue = 2;
                          return InkWell(
                            onTap: () {
                              setState(() {
                                val = radioValue;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Radio(
                                      value: radioValue,
                                      groupValue: val,
                                      onChanged: (value) {
                                        setState(() {
                                          val = radioValue;
                                        });
                                      },
                                      activeColor: kPrimaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Free")
                                ],
                              ),
                            ),
                          );
                        }),
                      ]);
                }),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Rating",
                  style: TextStyle(
                      color: kBlack, fontSize: p1, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                StatefulBuilder(builder: (context, setState) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Builder(builder: (context) {
                          int radioValue = 5;
                          return InkWell(
                            onTap: () {
                              setState(() {
                                val = radioValue;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Radio(
                                      value: radioValue,
                                      groupValue: val,
                                      onChanged: (value) {
                                        setState(() {
                                          val = radioValue;
                                        });
                                      },
                                      activeColor: kPrimaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SmoothStarRating(
                                    allowHalfRating: false,
                                    rating: radioValue.toDouble(),
                                    isReadOnly: true,
                                    size: 20,
                                    starCount: 5,
                                    color: Colors.yellow.shade700,
                                    borderColor: Colors.yellow.shade700,
                                    spacing: 0.0,
                                    // color: ,
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                        Builder(builder: (context) {
                          int radioValue = 4;
                          return InkWell(
                            onTap: () {
                              setState(() {
                                val = radioValue;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Radio(
                                      value: radioValue,
                                      groupValue: val,
                                      onChanged: (value) {
                                        setState(() {
                                          val = radioValue;
                                        });
                                      },
                                      activeColor: kPrimaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SmoothStarRating(
                                    allowHalfRating: false,
                                    rating: radioValue.toDouble(),
                                    isReadOnly: true,
                                    size: 20,
                                    starCount: 5,
                                    color: Colors.yellow.shade700,
                                    borderColor: Colors.yellow.shade700,
                                    spacing: 0.0,
                                    // color: ,
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                        Builder(builder: (context) {
                          int radioValue = 3;
                          return InkWell(
                            onTap: () {
                              setState(() {
                                val = radioValue;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Radio(
                                      value: radioValue,
                                      groupValue: val,
                                      onChanged: (value) {
                                        setState(() {
                                          val = radioValue;
                                        });
                                      },
                                      activeColor: kPrimaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SmoothStarRating(
                                    allowHalfRating: false,
                                    rating: radioValue.toDouble(),
                                    isReadOnly: true,
                                    size: 20,
                                    starCount: 5,
                                    color: Colors.yellow.shade700,
                                    borderColor: Colors.yellow.shade700,
                                    spacing: 0.0,
                                    // color: ,
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                        Builder(builder: (context) {
                          int radioValue = 2;
                          return InkWell(
                            onTap: () {
                              setState(() {
                                val = radioValue;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Radio(
                                      value: radioValue,
                                      groupValue: val,
                                      onChanged: (value) {
                                        setState(() {
                                          val = radioValue;
                                        });
                                      },
                                      activeColor: kPrimaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SmoothStarRating(
                                    allowHalfRating: false,
                                    rating: radioValue.toDouble(),
                                    isReadOnly: true,
                                    size: 20,
                                    starCount: 5,
                                    color: Colors.yellow.shade700,
                                    borderColor: Colors.yellow.shade700,
                                    spacing: 0.0,
                                    // color: ,
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                        Builder(builder: (context) {
                          int radioValue = 1;
                          return InkWell(
                            onTap: () {
                              setState(() {
                                val = radioValue;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Radio(
                                      value: radioValue,
                                      groupValue: val,
                                      onChanged: (value) {
                                        setState(() {
                                          val = radioValue;
                                        });
                                      },
                                      activeColor: kPrimaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SmoothStarRating(
                                    allowHalfRating: false,
                                    rating: radioValue.toDouble(),
                                    isReadOnly: true,
                                    size: 20,
                                    starCount: 5,
                                    color: Colors.yellow.shade700,
                                    borderColor: Colors.yellow.shade700,
                                    spacing: 0.0,
                                    // color: ,
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                      ]);
                }),
              ],
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            style: ButtonStyle(
                              side: MaterialStateProperty.all<BorderSide>(
                                BorderSide(color: kPrimaryColor, width: 1),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Reset",
                              style: TextStyle(color: kBlack),
                            ))),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  kPrimaryColor),
                            ),
                            onPressed: () {},
                            child: Text("Apply")))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
