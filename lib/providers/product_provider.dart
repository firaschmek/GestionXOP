import 'package:appgestion/model/product.dart';

class ProductProvider{

  List<Product> _oilBank=[ Product("Huile1", "images/oil/0.png",17,5.0),
    Product("Huile2", "images/oil/1.png",25,16.0),
    Product("Huile3", "images/oil/2.png",35,17.0),
    Product("Huile4", "images/oil/3.png",10,10.0),];
  List<Product> _tomateBank=[ Product("tomate1", "images/tomate/0.png",17,5.0),
    Product("tomate2", "images/tomate/1.png",25,16.0),
    Product("tomate3", "images/tomate/2.png",35,17.0),
    Product("tomate4", "images/tomate/3.png",10,10.0),];
  List<Product> _conserveBank=[ Product("conserve1", "images/conserve/0.png",17,5.0),
    Product("conserve2", "images/conserve/1.png",25,16.0),
    Product("conserve3", "images/conserve/2.png",35,17.0),
    Product("conserve4", "images/conserve/3.png",10,10.0),];

  List<Product> _jusBank=[ Product("jus1", "images/jus/0.png",17,5.0),
    Product("jus2", "images/jus/1.png",25,16.0),
    Product("jus3", "images/jus/2.png",35,17.0),
    Product("jus4", "images/jus/3.png",10,10.0),];

  List<Product> get oilBank => _oilBank;

  set oilBank(List<Product> value) {
    _oilBank = value;
  }

  List<Product> _chocolatBank=[ Product("chocolat1", "images/chocolat/0.png",17,5.0),
    Product("chocolat2", "images/chocolat/1.png",25,16.0),
    Product("chocolat3", "images/chocolat/2.png",35,17.0),
    Product("chocolat4", "images/chocolat/3.png",10,10.0),];

  List<Product> _cafeBank=[ Product("cafe1", "images/cafe/0.png",17,5.0),
    Product("cafe2", "images/cafe/1.png",25,16.0),
    Product("cafe3", "images/cafe/2.png",35,17.0),
    Product("cafe4", "images/cafe/3.png",10,10.0),];




  List<Product> get tomateBank => _tomateBank;

  set tomateBank(List<Product> value) {
    _tomateBank = value;
  }

  List<Product> get conserveBank => _conserveBank;

  set conserveBank(List<Product> value) {
    _conserveBank = value;
  }

  List<Product> get jusBank => _jusBank;

  set jusBank(List<Product> value) {
    _jusBank = value;
  }

  List<Product> get chocolatBank => _chocolatBank;

  set chocolatBank(List<Product> value) {
    _chocolatBank = value;
  }

  List<Product> get cafeBank => _cafeBank;

  set cafeBank(List<Product> value) {
    _cafeBank = value;
  }
}