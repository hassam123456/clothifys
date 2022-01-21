


import 'package:clothifys_app/Admins/product.dart';
import 'package:clothifys_app/Store/cart.dart';
import 'package:clothifys_app/Widgets/myDrawer.dart';
import 'package:clothifys_app/provider/categoryProvider.dart';
import 'package:clothifys_app/provider/productProvider.dart';
import 'package:provider/provider.dart';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'List.dart';
import 'SearchCatgeory.dart';
import 'SingleProduct.dart';
import 'detailScreen.dart';
import 'notification_button.dart';
class HomePage extends StatefulWidget {
 // const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}



Product menData;
Product womenData;
Product builbdata;
Product smartPhoneData;
var featureSnapShot;
var newAchivesSnapShot;
var bridal;
var unstiched;
var stiched;
var kurti;
var saris;
CategoryProvider  provider;
ProductProvider productProvider;


class _HomePageState extends State<HomePage> {
  Widget _buildCategoryFeatured(String image){
    return CircleAvatar(
      maxRadius: 35,
      backgroundColor: Color(0xff33dcfd),
      child: Container(
         height: 25,
      ),
      backgroundImage: AssetImage("images/$image"),
    );
  }

Widget _buildNewArchives(BuildContext context){
  List<Product> newAchivesProduct = productProvider.getnewAchivesList;


    return Column(
      children: [
        Container(
          height:100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "DiscountProduct",
                    style:  TextStyle(
                      fontSize: 17,fontWeight: FontWeight.bold,
                    ),
                  ),
                   GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => ListProducts(
                        name: "DiscountProduct",

                      snapShot: newAchivesProduct,

                      )
                      )
                      );
                      },
                    child: Text(
                      "View more",
                      style:  TextStyle(
                        fontSize: 17,fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Row(
            children: productProvider.getHomeArrivalList.map((e) {
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (ctx) => DetailScreen(
                                          thumbnailUrl: e.thumbnailUrl,
                                          price: e.price,
                                          name: e.name,
                                          brand: e.brand,
                                        ),
                                      ),
                                    );
                                  },
                                  child: SingleProduct(
                                      thumbnailUrl: e.thumbnailUrl, price: e.price, name: e.name,brand: e.brand),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (ctx) => DetailScreen(
                                        thumbnailUrl: e.thumbnailUrl,
                                        price: e.price,
                                        name: e.name,
                                        brand: e.brand,

                                      ),
                                    ),
                                  );
                                },
                                child: SingleProduct(
                                    thumbnailUrl: e.thumbnailUrl, price: e.price, name: e.name, brand: e.brand),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }).toList()),
      ],
    );
}
Widget _buildFeature(BuildContext context){
  List<Product> featureProduct;
  featureProduct = productProvider.getfeatureList;

    return Column(
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "PopularProduct",
              style:  TextStyle(
                fontSize: 17,fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => ListProducts(name: "PopularProduct",
                  snapShot: featureProduct,) ));
              },
              child: Text(
                "View more",
                style:  TextStyle(
                  fontSize: 17,fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),



        Row(
          children: productProvider.getHomefeatureList.map((e) {
            return Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => DetailScreen(
                              thumbnailUrl: e.thumbnailUrl,
                              price: e.price,
                              name: e.name,
                              brand: e.brand,

                            ),
                          ),
                        );
                      },
                      child: SingleProduct(
                        thumbnailUrl: e.thumbnailUrl,
                        price: e.price,
                        name: e.name,
                        brand: e.brand,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => DetailScreen(
                              thumbnailUrl: e.thumbnailUrl,price: e.price, name: e.name,brand: e.brand,),
                        ),
                      );
                    },
                    child: SingleProduct(
                      thumbnailUrl: e.thumbnailUrl,
                      price: e.price,
                      name: e.name,
                      brand: e.brand,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
}

Widget _buildImageSlider(){
    return Container(
      height: 200.0,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage("images/1.jpg"),
          AssetImage("images/2.jpg"),
          AssetImage("images/3.jpg"),
          AssetImage("images/4.jpg"),
          AssetImage("images/1.jpg"),
        ],
        autoplay: false,
        // animationCurve: Curves.fastOutSlowIn,
        // animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
        dotBgColor: Colors.transparent,
      ),
    );
}

Widget   _buildCategory(){
List<Product> stiched = provider.getShirtList;
List<Product> unstiched = provider.getunstichedList;
List<Product> kurti = provider.getkurtiList;
List<Product> bridal = provider.getbridalList;
List<Product> saris = provider.getsarisList;
    return Container(
      // width: 40.0,

      child: Column(
mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Categories",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            height: 60,

            child: Row(
              children: [
                GestureDetector(
                    onTap:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) =>  ListProducts(
                        name: "stiched",
                        snapShot: stiched,

                      )));
                      } ,

                    child: _buildCategoryFeatured("8A.jpg")

                ),

                GestureDetector(
                    onTap:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) =>  ListProducts(
                        name: "unstiched",
                        snapShot: unstiched,

                      )));
                      } ,
                    child: _buildCategoryFeatured("3A.jpg",

                    )
                ),

                GestureDetector(
                    onTap:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) =>  ListProducts(

                        name: "kurti",
                        snapShot: kurti,

                      )));

                    } ,
                    child: _buildCategoryFeatured("9A.jpg")
                ),

                GestureDetector(
                    onTap:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) =>  ListProducts(
                        name: "bridal",
                        snapShot: bridal,
                      )));
                    } ,
                    child: _buildCategoryFeatured("2A.jpg")
                ),
                GestureDetector(
                    onTap:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) =>  ListProducts(
                        name: "saris",
                        snapShot: saris,
                      )));
                      } ,
                    child: _buildCategoryFeatured("3A.jpg")
                ),
              ],
            ),
          ),
        ],
      ),
    );
}
final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  double width;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<CategoryProvider>(context);
    provider.getShirtData();
    provider.getbridalData();
    provider.getkrtiData();
    provider.getsarisData();
    provider.getunstichedData();
    productProvider = Provider.of<ProductProvider>(context);
       productProvider.gethomefeatureData();
       productProvider.gethomeArrivalData();
    productProvider.getnewAchivesData();
    productProvider.getfeatureData();
    width = MediaQuery.of(context).size.width;
    return Scaffold(
key: _key,

          appBar: AppBar(
            flexibleSpace: Container(
  color: Colors.greenAccent,

              // decoration: new BoxDecoration(

              //   gradient: new LinearGradient(
              //     colors: [Colors.pink,
              //       Colors.greenAccent],
              //     begin: const FractionalOffset(0.0, 0.0),
              //     end: const FractionalOffset(1.0, 0.0),
              //     stops: [0.0, 1.0],
              //     tileMode: TileMode.clamp,
              //   ),
              // ),
            ),
            title: Text(
              "ClothiFy",
              style: TextStyle(fontSize: 55.0, color: Colors.white, fontFamily: "Signatra"),
            ),
    centerTitle: true,
    elevation: 0.0,
    //backgroundColor: Colors.grey[100],
    leading: IconButton(
    icon: Icon(
    Icons.menu,
    color: Colors.black,
    ),
    onPressed: () {

      Route route = MaterialPageRoute(builder: (c) => MyDrawer());
      Navigator.pushReplacement(context, route);

   // _key.currentState.openDrawer();
    }),

    actions: <Widget>[
      IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          onPressed: () {
    showSearch(
    context: context, delegate: SearchCategory());
            // _key.currentState.openDrawer();
          }
          ),
      IconButton(
        icon: Icon(Icons.shopping_cart, color: Colors.pink,),
        onPressed: ()
        {
          Route route = MaterialPageRoute(builder: (c) => CartPage());
          Navigator.pushReplacement(context, route);
        },
      ),
      //NotificationButton(),
    ],

    ),
        drawer: MyDrawer(),
      body: Container(

                    height: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: ListView(
                      children: [
                        Container(
                          width: double.infinity,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                      _buildImageSlider(),
                      _buildCategory(),

                       SizedBox(
                       height: 20.0,

                       ),
                              _buildFeature(context),
                            _buildNewArchives(context),
                             ]
                                      ),),
                          ],
                        ),
                        )
                     );
              }

          }



  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;


