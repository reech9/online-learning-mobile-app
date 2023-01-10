import 'package:digi_school/constants/demo.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:digi_school/screens/cart_screen/components/cart_card.dart';
import 'package:digi_school/screens/cart_screen/payments/khalti_payment.dart' as Khalti;
import 'package:digi_school/screens/cart_screen/payments/esewa_payment.dart' as ESewa;
import 'package:digi_school/widgets/utils.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);
  static const String routeName = "/cart";
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> demo = [];
  List<String> demoCategories = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    demo = dummyProduct.toList();
    demoCategories = dummyCategories.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: kWhite,
          child: SafeArea(
              child: ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        toolbarHeight: 50,
                        backgroundColor: kWhite,
                        pinned: true,
                        automaticallyImplyLeading: true,
                        leading: backButton(context),
                        titleSpacing: 0,
                        title: Container(
                          margin: EdgeInsets.only(right: 10),
                          alignment: Alignment.centerRight,
                          height: 50,
                          decoration: BoxDecoration(
                              // color: Colors.red
                              ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Cart",
                                style: TextStyle(
                                    color: kBlack,
                                    fontWeight: FontWeight.w500,
                                    fontSize: h5),
                              )
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  demo.length.toString() + " item(s)",
                                  style: TextStyle(
                                      color: kBlack,
                                      fontWeight: FontWeight.w500,
                                      fontSize: h5),
                                ),
                              ),
                              ...List.generate(demo.length, (index) => CartCard(
                                image: demo[index]["image"],
                                title: demo[index]["title"],
                                discount: demo[index]["discount"],
                                price: demo[index]["price"],
                                subTitle: demo[index]["user"],
                                onRemove: (){
                                  print("REMOVE HERE");
                                },
                              )),
                              SizedBox(
                                height: 60,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )))),
      bottomNavigationBar: Container(
        child: Container(
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(
                    -2, 0), // changes position of shadow
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: EdgeInsets.zero,
          child: Row(
            children: [
              Expanded(
                  child: Container(
                      child:
                          ElevatedButton(
                            style: ButtonStyle(
                              side: MaterialStateProperty.all<BorderSide>(
                                BorderSide(color: kPrimaryColor, width: 1),

                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                              onPressed: () {
                                Navigator.pop(context);
                              }, child: Text("Back", style: TextStyle(
                            color: kBlack
                          ),)))),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Container(
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                kPrimaryColor),
                          ),
                          onPressed: () {
                            paymentGateway();
                          }, child: Text("Continue")))),
            ],
          ),
        ),
      ),
    );
  }

  void paymentGateway(){
    showModalBottomSheet<void>(
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        ),
        builder: (BuildContext context) {
          return Container(
            margin: EdgeInsets.only(bottom: 10),
            child:
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 30,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),

                        child: Text("Payment Selector", style: TextStyle(
                            color: kBlack, fontSize: p1, fontWeight: FontWeight.w600
                        ),)),
                    SizedBox(height: 10,),

                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                                color: gray_600,
                                width: 1
                            )
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4),
                          onTap: (){
                            Navigator.of(context).pop();
                              Khalti.pay(context);
                          },
                          child: Container(

                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            child: Row(
                              children: [
                                Image.asset("assets/images/khalti.png", height: 40, width: 100, fit: BoxFit.cover,),
                                SizedBox(width: 10,),
                                Text("Pay with khalti", style: TextStyle(
                                    color: kBlack, fontSize: p1, fontWeight: FontWeight.w500
                                ),),
                              ],
                            ),
                          ),
                        )),
                    SizedBox(height: 10,),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: gray_600,
                          width: 1
                        )
                      ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4),
                          onTap: (){
                            Navigator.of(context).pop();
                            // ESewa.pay(context);
                          },
                          child: Container(

                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            child: Row(
                              children: [
                                Image.asset("assets/images/esewa.png", height: 40, width: 100, fit: BoxFit.cover,),
                                SizedBox(width: 10,),
                                Text("Pay with E-sewa", style: TextStyle(
                                  color: kBlack, fontSize: p1, fontWeight: FontWeight.w500
                                ),),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: gray_500
                  ),
                  height: 6,
                  width: 200,
                )
              ],
            ),
          );
        });
  }

}
