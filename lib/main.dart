import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learn_english/tab1.dart';
import 'package:learn_english/tab2.dart';
import 'package:learn_english/tab3.dart';
import 'package:learn_english/tab4.dart';
import 'package:learn_english/tab5.dart';

import 'Product.dart';
import 'placeholder_widget.dart';

void main() => runApp(new App());

//App
class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    new Tab1(),
    new Tab2(),
    new Tab3(),
    MyHomePage(products: fetchProducts(),),
    PlaceholderWidget(Colors.black)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Flutter App'),
      ),
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        // new
        currentIndex: _currentIndex,
        // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            title: Text('Messages'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Setting'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.book),
            title: Text('Book'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile'))
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

List<Product> parseProducts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Product>((json) => Product.fromMap(json)).toList();
}

Future<List<Product>> fetchProducts() async {
  final response = await http.get('http://192.168.100.19:8000/products.json');
  if (response.statusCode == 200) {
    return parseProducts(response.body);
  } else {
    throw Exception('Unable to fetch products from the REST API');
  }
}

class MyHomePage extends StatelessWidget {
 final String title;
 final Future<List<Product>> products;

 MyHomePage({Key key, this.title, this.products}) : super(key: key);

 // final items = Product.getProducts();
 @override
 Widget build(BuildContext context) {
   return Scaffold(
       appBar: AppBar(title: Text("Product Navigation")),
       body: Center(
         child: FutureBuilder<List<Product>>(
           future: products,
           builder: (context, snapshot) {
             if (snapshot.hasError) print(snapshot.error);
             return snapshot.hasData
                 ? ProductBoxList(items: snapshot.data)
                 :

                 // return the ListView widget :
                 Center(child: CircularProgressIndicator());
           },
         ),
       ));
 }
}

class ProductBoxList extends StatelessWidget {
 final List<Product> items;

 ProductBoxList({Key key, this.items});

 @override
 Widget build(BuildContext context) {
   return ListView.builder(
     itemCount: items.length,
     itemBuilder: (context, index) {
       return GestureDetector(
         child: ProductBox(item: items[index]),
         onTap: () {
           Navigator.push(
             context,
             MaterialPageRoute(
               builder: (context) => ProductPage(item: items[index]),
             ),
           );
         },
       );
     },
   );
 }
}

class ProductPage extends StatelessWidget {
 ProductPage({Key key, this.item}) : super(key: key);
 final Product item;

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text(this.item.name),
     ),
     body: Center(
       child: Container(
         padding: EdgeInsets.all(0),
         child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
//                Image.asset("assets/appimages/" + this.item.image),
               Expanded(
                   child: Container(
                       padding: EdgeInsets.all(5),
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: <Widget>[
                           Text(this.item.name,
                               style: TextStyle(fontWeight: FontWeight.bold)),
                           Text(this.item.description),
                           Text("Price: " + this.item.price.toString()),
                           RatingBox(),
                         ],
                       )))
             ]),
       ),
     ),
   );
 }
}

class RatingBox extends StatefulWidget {
 @override
 _RatingBoxState createState() => _RatingBoxState();
}

class _RatingBoxState extends State<RatingBox> {
 int _rating = 0;

 void _setRatingAsOne() {
   setState(() {
     _rating = 1;
   });
 }

 void _setRatingAsTwo() {
   setState(() {
     _rating = 2;
   });
 }

 void _setRatingAsThree() {
   setState(() {
     _rating = 3;
   });
 }

 Widget build(BuildContext context) {
   double _size = 20;
   print(_rating);
   return Row(
     mainAxisAlignment: MainAxisAlignment.end,
     crossAxisAlignment: CrossAxisAlignment.end,
     mainAxisSize: MainAxisSize.max,
     children: <Widget>[
       Container(
         padding: EdgeInsets.all(0),
         child: IconButton(
           icon: (_rating >= 1
               ? Icon(
                   Icons.star,
                   size: _size,
                 )
               : Icon(
                   Icons.star_border,
                   size: _size,
                 )),
           color: Colors.red[500],
           onPressed: _setRatingAsOne,
           iconSize: _size,
         ),
       ),
       Container(
         padding: EdgeInsets.all(0),
         child: IconButton(
           icon: (_rating >= 2
               ? Icon(
                   Icons.star,
                   size: _size,
                 )
               : Icon(
                   Icons.star_border,
                   size: _size,
                 )),
           color: Colors.red[500],
           onPressed: _setRatingAsTwo,
           iconSize: _size,
         ),
       ),
       Container(
         padding: EdgeInsets.all(0),
         child: IconButton(
           icon: (_rating >= 3
               ? Icon(
                   Icons.star,
                   size: _size,
                 )
               : Icon(
                   Icons.star_border,
                   size: _size,
                 )),
           color: Colors.red[500],
           onPressed: _setRatingAsThree,
           iconSize: _size,
         ),
       ),
     ],
   );
 }
}

class ProductBox extends StatelessWidget {
 ProductBox({Key key, this.item}) : super(key: key);
 final Product item;

 Widget build(BuildContext context) {
   return Container(
       padding: EdgeInsets.all(2),
       height: 140,
       child: Card(
         child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: <Widget>[
//                Image.asset("assets/appimages/" + this.item.image),
               Expanded(
                   child: Container(
                       padding: EdgeInsets.all(5),
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: <Widget>[
                           Text(this.item.name,
                               style: TextStyle(fontWeight: FontWeight.bold)),
                           Text(this.item.description),
                           Text("Price: " + this.item.price.toString()),
                           RatingBox(),
                         ],
                       )))
             ]),
       ));
 }
}
