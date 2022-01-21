import 'package:clothifys_app/Config/config.dart';
import 'package:clothifys_app/Counters/changeAddresss.dart';
import 'package:clothifys_app/Models/address.dart';
import 'package:clothifys_app/Orders/placeOrderPayment.dart';
import 'package:clothifys_app/Store/storehome.dart';
import 'package:clothifys_app/Widgets/loadingWidget.dart';
import 'package:clothifys_app/Widgets/wideButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'addAddress.dart';

class Address extends StatefulWidget
{
  final double totalAmount;
  const Address({Key key, this.totalAmount}) : super(key: key);

  @override
  _AddressState createState() => _AddressState();
}


class _AddressState extends State<Address>
{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(

            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) =>  StoreHome()));
            },
          ),
          flexibleSpace: Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [Colors.pink,
                  Colors.greenAccent],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            "DetailPage",
            style: TextStyle(
                fontSize: 55.0, color: Colors.white, fontFamily: "Signatra"),
          ),
          actions: <Widget>[

          ],

        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Select Address",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0,),
                ),
              ),
            ),
            Consumer<AddressChanger>(builder: (context, address, c){
              return Flexible(
                child: StreamBuilder<QuerySnapshot>(
                  stream: EcommerceApp.firestore
                      .collection(EcommerceApp.collectionUser)
                      .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
                      .collection(EcommerceApp.subCollectionAddress).snapshots(),
                  
                  builder: (context, snapshot)
                  {
                    return !snapshot.hasData 
                        ? Center(child: circularProgress(),) 
                        : snapshot.data.documents.length == 0 
                        ? noAddressCard() 
                        : ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index)
                            {
                              return AddressCard(
                                currentIndex: address.count,
                                value: index,
                                addressId: snapshot.data.documents[index].documentID,
                                totalAmount: widget.totalAmount,
                                model: AddressModel.fromJson(snapshot.data.documents[index].data),
                              );
                            },
                          );
                  },
                ),
              );
            }),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text("Add New Address"),
          backgroundColor: Colors.pink,
          icon: Icon(Icons.add_location),
          onPressed: ()
          {
            Route route = MaterialPageRoute(builder: (c) => AddAddress());
            Navigator.pushReplacement(context, route);
          },
        ),
      ),
    );
  }

  noAddressCard() {
    return Card(
      color: Colors.pink.withOpacity(0.5),
      child: Container(
        height: 100.0,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_location, color: Colors.white,),
            Text("No shipment address has been saved."),
            Text("Please add your shipment Address so that we can deliever product."),
          ],
        ),
      ),
    );
  }
}



class AddressCard extends StatefulWidget
{
  final AddressModel model;
  final String addressId;
  final double totalAmount;
  final int currentIndex;
  final int value;

  AddressCard({Key key, this.model, this.currentIndex, this.addressId, this.totalAmount, this.value}) : super(key: key);

  @override
  _AddressCardState createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: ()
      {
        Provider.of<AddressChanger>(context, listen: false).displayResult(widget.value);
      },
      child: Card(
        color: Colors.pinkAccent.withOpacity(0.4),
        child: Column(

          children: [
            Row(
              children: [
                Radio(
                  groupValue: widget.currentIndex,
                  value: widget.value,
                  activeColor: Colors.pink,
                  onChanged: (val)
                  {
                    Provider.of<AddressChanger>(context, listen: false).displayResult(val);
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: screenWidth * 0.8,
                      child: Table(
                        children: [

                          TableRow(
                            children: [
                              KeyText(msg: "Name",),
                              Text(widget.model.name),
                            ]
                          ),

                          TableRow(
                              children: [
                                KeyText(msg: "Phone Number",),
                                Text(widget.model.phoneNumber),
                              ]
                          ),

                          TableRow(
                              children: [
                                KeyText(msg: "Flat Number",),
                                Text(widget.model.flatNumber),
                              ]
                          ),

                          TableRow(
                              children: [
                                KeyText(msg: "City",),
                                Text(widget.model.city),
                              ]
                          ),

                          TableRow(
                              children: [
                                KeyText(msg: "State",),
                                Text(widget.model.state),
                              ]
                          ),

                          TableRow(
                              children: [
                                KeyText(msg: "Pin Code",),
                                Text(widget.model.pincode),
                              ]
                          ),

                          TableRow(
                              children: [
                                KeyText(msg: "CNIC No.",),
                                Text(widget.model.CNIC),
                              ]
                          ),

                          TableRow(
                              children: [
                                KeyText(msg: "Time you need this on Rent",),
                                Text(widget.model.NeededHours),
                              ]
                          ),
                          TableRow(
                              children: [
                                KeyText(msg: "Time and Date to return this product",),
                                Text(widget.model.ReturnDateAndTime),
                              ]
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            widget.value == Provider.of<AddressChanger>(context).count
                ? WideButton(
                    message: "Proceed",
                    onPressed: ()
                    {
                    Route route = MaterialPageRoute(builder: (c) => PaymentPage(
                        addressId: widget.addressId,
                        totalAmount: widget.totalAmount,
                      ));
                      Navigator.push(context, route);
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}





class KeyText extends StatelessWidget
{
  final String msg;

  KeyText({Key key, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      msg,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,),
    );
  }
}