import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/homepage.dart';
import 'package:groceryapp/profile.dart';
import 'package:groceryapp/wishlist.dart';
import 'Order.dart';

class bottomnavbar extends StatefulWidget {
  const bottomnavbar({super.key});

  @override
  State<bottomnavbar> createState() => _bottomnavbarState();
}

class _bottomnavbarState extends State<bottomnavbar> {
  int currentTabIndex = 0;
  late List<Widget> pages;
  late Widget currentPage;
  late home homepage;
  late Wishlist wishlist;
  late Order order;
  late Profile profile;

  @override
  void initState() {
    homepage = home();
    wishlist = Wishlist();
    order = Order();
    profile = Profile();
    pages = [homepage, order, wishlist, profile];
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.green.shade200,
        color: Colors.green.shade900,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: [
          Icon(
            Icons.home_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_bag_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.favorite,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
          ),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
