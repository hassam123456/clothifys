import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Models/RentalModel.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Store/product_page.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:e_shop/Config/config.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/myDrawer.dart';
import '../Widgets/searchBox.dart';

double width;

class StoreHomes extends StatefulWidget {
  @override
  _StoreHomeState createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHomes> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            color: Colors.greenAccent,

          ),
          title: Text("ClothiFy",style: TextStyle(color: Colors.white,fontSize: 55.0,fontFamily: "Signatra"),
          ),
          centerTitle: true,
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart, color: Colors.pink),
                  onPressed: (){
                    Route route = MaterialPageRoute(builder: (c) => CartPage());
                    Navigator.pushReplacement(context, route);
                  },

                ),
                Positioned(
                  child: Stack(
                    children: [
                      Icon(
                        Icons.brightness_1,
                        size: 20.0,
                        color: Colors.green,
                      ),
                      Positioned(
                        top: 3.0,
                        bottom: 4.0,
                        child: Consumer<CartItemCounter>(
                          builder: (context, counter, _){
                            return Text(
                              counter.count.toString(),
                              style: TextStyle(color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
        drawer: MyDrawer(),
        body:   CustomScrollView(
          slivers: [
            SliverPersistentHeader(pinned: true, delegate: SearchBoxDelegate()),
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection("rentalUser").snapshots(),
              builder: (context, dataSnapshot) {
                return !dataSnapshot.hasData
                    ? SliverToBoxAdapter(child: Center(child: circularProgress()),)
                    : SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 1,
                  staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                  itemBuilder: (context, index){
                    RentalModel model = RentalModel.fromJson(dataSnapshot.data.documents[index].data);
                    return sourceInfo(model, context);
                  },
                  itemCount: dataSnapshot.data.documents.length,

                );

              },

            )
          ],
        ),
      ),
    );
  }
}



Widget sourceInfo(RentalModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell(
    splashColor: Colors.pink,
    child: Padding(
      padding:  EdgeInsets.all(6.0),
      child: Container(
        height: 190.0,
        width: width,
        child: Row(
          children: [

            SizedBox(
              width: 4.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(
                      height: 15.0
                  ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          child: Text("Name="),
                        ),
                        SizedBox(height: 3.0),

                        Expanded(
                            child: Text(
                              model.name, style: TextStyle(color: Colors.black, fontSize: 14.0),
                            )
                        )                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          child: Text("Phone="),
                        ),
                        SizedBox(height: 3.0),

                        Expanded(
                            child: Text(
                              model.phone, style: TextStyle(color: Colors.black, fontSize: 14.0),
                            )
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          child: Text("NIC="),
                        ),
                        SizedBox(height: 3.0),

                        Expanded(
                            child: Text(

                              model.nic, style: TextStyle(color: Colors.black, fontSize: 14.0),
                            )
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          child: Text("shippingAddress="),
                        ),
                        SizedBox(height: 3.0),

                        Expanded(
                          child: Text(
                            model.shippingAddress, style: TextStyle(color: Colors.black,
                            fontSize: 14.0,
                          ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          child: Text(" returnDateAndTime="),
                        ),
                        SizedBox(height: 3.0),
                        Expanded(

                            child: Text(
                              model.returnDateAndTime, style: TextStyle(color: Colors.black,
                              fontSize: 14.0,
                            ),
                            )
                        )
                      ],
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}



Widget card({Color primaryColor = Colors.redAccent, String imgPath}) {
  return Container();
}



void checkItemInCart(String productID, BuildContext context)
{
}