
import 'package:clothifys_app/provider/productProvider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../GooglemAP.dart';
import 'HomePage.dart';
import 'cartSingleProduct.dart';
import 'checkOut.dart';
import 'notification_button.dart';

class CartScreen extends StatefulWidget {
bool isCount;
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70,
        width: 100,
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.only(
            bottom: 10
        ),
        child: RaisedButton(
            color: Colors.greenAccent,
            child: Text(
              "PlaceOrder",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white
              ),
            ),
            onPressed: () {

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => Ghome(),
                )
              );
            }
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) => HomePage()));
          },
        ),
        flexibleSpace: Container(
          color: Colors.greenAccent,
        ),

        centerTitle: true,
        title: Text(
          "CartPage",
          style: TextStyle(
              fontSize: 55.0, color: Colors.white, fontFamily: "Signatra"),
        ),
        actions: <Widget>[


        ],
      ),
      body: ListView.builder(
        itemCount: productProvider.getCartModelListLenth,
        itemBuilder: (ctx, index) =>
            CartSingleProduct(
              isCount: false,
               index: index,
               thumbnailUrl: productProvider.getCartModelList[index].thumbnailUrl,
              name:  productProvider.getCartModelList[index].name,
              price:  productProvider.getCartModelList[index].price,
              quantity:  productProvider.getCartModelList[index].quantity,
              brand: productProvider.getCartModelList[index].brand,
            ),
      ),
    );
  }
}
