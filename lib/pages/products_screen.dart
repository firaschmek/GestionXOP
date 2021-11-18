
import 'package:appgestion/model/product.dart';
import 'package:appgestion/pages/product_detail.dart';
import 'package:appgestion/providers/product_provider.dart';
import 'package:flutter/material.dart';


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
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(searchResults.length, (index) {
                return Container(
                  padding: EdgeInsets.all(30),
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProductDetail(searchResults[index])),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image.asset(searchResults[index].ImgSrc,
                              height: 180.0, width: 180.0, fit: BoxFit.fill),
                        ),
                      ),
                      Center(
                          child: Text(
                            searchResults[index].name,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )),
                    ],
                  ),
                );
              }),
            ),
          ),
        ]),
      ),

    );
  }
}
