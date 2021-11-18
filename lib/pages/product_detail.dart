import 'package:appgestion/model/product.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  Product product;

  ProductDetail(this.product);

  @override
  _ProductDetailState createState() => _ProductDetailState(this.product);
}

class _ProductDetailState extends State<ProductDetail> {
  Product product;

  _ProductDetailState(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(product.name)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: ExactAssetImage(product.ImgSrc),
                  ),
                ),
              ),
              SizedBox(
                height: 400,
                child: Card(

                  child: Column(

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            product.price.toString(),
                            style: TextStyle(
                                height: 1.5,
                                color: Color(0xFF6F8398),
                                fontSize: 30),
                          ),
                          Text(
                            " DT",
                            style: TextStyle(
                                height: 1.5,
                                color: Color(0xFF6F8398),
                                fontSize: 30),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton(
                              elevation: 2,
                              child: Image.asset(
                                "images/plus.png",
                                width: 15,
                                height: 15,
                              ),
                              backgroundColor: Colors.white,
                              onPressed: () {}),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 50,
                            child: TextFormField(
                              initialValue: product.quantity.toString(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  height: 1.5,
                                  color: Color(0xFF6F8398),
                                  fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          FloatingActionButton(
                              elevation: 1,
                              child: Image.asset(
                                "images/minus.png",
                                width: 15,
                                height: 15,
                              ),
                              backgroundColor: Colors.white,
                              onPressed: () {})
                        ],
                      ),
                       SizedBox(height: 50),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Row(

                          children: [
                            Expanded(

                              child: ElevatedButton(

                                onPressed: () {},
                                child: const Text('تسجيل'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
