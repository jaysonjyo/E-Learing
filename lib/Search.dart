import 'package:flutter/material.dart';
import 'package:learning/shoping_cart.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        backgroundColor: Colors.grey,
        title: Container(decoration:ShapeDecoration(color: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
          child: TextField(style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  hintText: "Search....",suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none)),),
        ),actions: [Padding(
          padding: const EdgeInsets.only(right: 5),
          child:  IconButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ShopingCart()));},
            icon:  Icon(Icons.shopping_cart_outlined,size: 29,),
          ),
        )],
      ),
      body: Column(children: [


    ])
    );
  }
}
