import 'package:appgestion/model/category.dart';
import 'package:flutter/material.dart';
import 'package:appgestion/pages/products_screen.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController editingController = TextEditingController();
  List<Category> originalcategories = [
    Category("Huile", "images/sample0.jpg"),
    Category("Tomate", "images/sample1.jpg"),
    Category("Conserve", "images/sample2.jpg"),
    Category("Jus", "images/sample3.jpg"),
    Category("Chocolat", "images/sample4.jpg"),
    Category("Coffee", "images/sample5.jpg")
  ];

  List<Category> searchResults = [];

  @override
  void initState() {
    super.initState();
    searchResults.addAll(originalcategories);
  }

  void filterSearchResults(String query) {
    List<Category> dummySearchList = [];
    dummySearchList.addAll(originalcategories);
    if (query.isNotEmpty) {
      List<Category> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.name.contains(query)) {
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
        searchResults.addAll(originalcategories);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('كتالوغ'),
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
                            MaterialPageRoute(builder: (context) => ProductsScreen(searchResults[index].name)),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image.asset(searchResults[index].ImgSrc,
                              height: 180.0, width: 180.0, fit: BoxFit.fill),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProductsScreen(searchResults[index].name)),
                          );
                        },
                        child: Center(
                            child: Text(
                          searchResults[index].name,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ]),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
               image: DecorationImage(fit: BoxFit.fill,
                 image: AssetImage("images/wallpaper.jpg")
               ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                      backgroundImage: AssetImage("images/person.jpeg")
                  ),
                  Text('Mohamed est connecté !'),
                ],
              ),
            ),
            ListTile(
              trailing: Icon(Icons.login_outlined),
              title: Text('خروج'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
