import 'package:appgestion/model/Product.dart';

class ProductProvider{

  List<Product> _oilBank=[ Product("زيت الصافي", "images/oil/oil.png",17,5.0),
    Product("زيت السنبلة", "images/oil/oil.png",25,16.0),
    Product("زيت عباد الشمس", "images/oil/oil.png",35,17.0),
    Product("زيت الشابة", "images/oil/oil.png",10,10.0),];
  List<Product> _tomateBank=[ Product("حكة طماطم سيكام", "images/tomate/tomate.png",17,5.0),
    Product("حكة طماطم الكاف", "images/tomate/tomate.png",25,16.0),
    Product("حكة طماطم صاحب الجبل", "images/tomate/tomate.png",35,17.0),
    Product("حكة طماطم سليانة", "images/tomate/tomate.png",10,10.0),];
  List<Product> _conserveBank=[ Product("حكة معجون سفرجل", "images/conserve/jam.png",17,5.0),
    Product("حكة معجون تفاح", "images/conserve/jam.png",25,16.0),
    Product("حكة معجون", "images/conserve/jam.png",35,17.0),
    Product("حكة معجو", "images/conserve/jam.png",10,10.0),];

  List<Product> _jusBank=[ Product("باكو عصير برتقال", "images/jus/juice.png",17,5.0),
    Product("باكو عصير سفرجل", "images/jus/juice.png",25,16.0),
    Product("باكو عصير برتقال", "images/jus/juice.png",35,17.0),
    Product("باكو عصير برتقال", "images/jus/juice.png",10,10.0),];

  List<Product> get oilBank => _oilBank;

  set oilBank(List<Product> value) {
    _oilBank = value;
  }

  List<Product> _chocolatBank=[ Product("باكو شكلاطة سعيد", "images/chocolat/chocolate.png",17,5.0),
    Product("باكو شكلاطة سعيد", "images/chocolat/chocolate.png",25,16.0),
    Product("باكو شكلاطة سعيد", "images/chocolat/chocolate.png",35,17.0),
    Product("باكو شكلاطة سعي", "images/chocolat/chocolate.png",10,10.0),];

  List<Product> _cafeBank=[ Product("قهوة بن يدر", "images/cafe/cafe.png",17,5.0),
    Product("قهوة بن يدر", "images/cafe/cafe.png",25,16.0),
    Product("قهوة بن يدر", "images/cafe/cafe.png",35,17.0),
    Product("قهوة بن يدر", "images/cafe/cafe.png",10,10.0),];




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