
import 'package:appgestion/details/details_screen.dart';
import 'package:appgestion/model/Product.dart';
import 'package:appgestion/constant/constants.dart';
import 'package:appgestion/providers/product_provider.dart';
import 'package:flutter/material.dart';

import 'item_card.dart';


class ProductsScreen extends StatefulWidget {
  String category;
  ProductsScreen(this.category);

  @override
  _ProductsScreenState createState() { return _ProductsScreenState(this.category);}


}

class _ProductsScreenState extends State<ProductsScreen> {
  String category;
  TextEditingController editingController = TextEditingController();

  ProductProvider productProvider=new ProductProvider();

  List<Product> originalProducts=[] ;

  List<Product> searchResults=[];


  _ProductsScreenState(this.category);

  @override
  void initState() {
    super.initState();
originalProducts.addAll(selectProduct(category));
    searchResults.addAll(originalProducts);
  }

List<Product> selectProduct(String name)
{
  if(name=="Huile")
    return productProvider.oilBank;
  else if (name=="Tomate")
    return productProvider.tomateBank;
  else if (name=="Conserve")
    return productProvider.conserveBank;
  else if (name=="Jus")
    return productProvider.jusBank;
  else if (name=="Chocolat")
    return productProvider.chocolatBank;
  else if (name=="Coffee")
    return productProvider.cafeBank;



}
  void filterSearchResults(String query) {
    List<Product> dummySearchList = [];
    dummySearchList.addAll(originalProducts);
    if(query.isNotEmpty) {
      List<Product> dummyListData = [];
      dummySearchList.forEach((item) {
        if(item.name.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        searchResults.clear();
        searchResults.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        searchResults.clear();
        searchResults.addAll(originalProducts);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('المنتوجات'),
      ),
      body: Container(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterSearchResults(value);
              },
              controller: editingController,
              decoration: InputDecoration(
                  labelText: "البحث",
                  hintText: "البحث",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: GridView.builder(
                  itemCount: searchResults.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: kDefaultPaddin,
                    crossAxisSpacing: kDefaultPaddin,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) => ItemCard(
                    product: searchResults[index],
                    press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            product: searchResults[index],
                          ),
                        )),
                  )),
            ),
          ),
        ]),
      ),

    );
  }
}
