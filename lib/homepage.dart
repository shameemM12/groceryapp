import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/Services/database.dart';
import 'package:groceryapp/details.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int currentSlide = 0;

  bool Fruits = false, Vegetables = false, Snacks = false, Dairy = false;
  Stream? foodItemStream;

  ontheload() async {
    foodItemStream = await DatabaseMethods().getFoodItem("Fruits");
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  Widget allItemsVertically() {
    return StreamBuilder(
      stream: foodItemStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Details(
                                  image: ds["Image"],
                                  name: ds["Name"],
                                  detail: ds["Detail"],
                                  price: ds["Price"])));
                    },
                    child: Container(
                      margin: EdgeInsets.all(4),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.all(14),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(ds["Image"],
                                  height: 150, width: 150, fit: BoxFit.cover),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                children: [
                                  Container(
                                    child: Center(
                                      child: Text(ds["Name"],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: 150,
                                    child: Center(
                                      child: Text(
                                        "\$" + ds["Price"],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : CircularProgressIndicator();
      },
    );
  }

  Widget allItems() {
    return StreamBuilder(
      stream: foodItemStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Details(
                                image: ds["Image"],
                                name: ds["Name"],
                                detail: ds["Detail"],
                                price: ds["Price"]),
                          ));
                    },
                    child: Container(
                      margin: EdgeInsets.all(4),
                      child: Material(
                        elevation: 9,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(ds["Image"],
                                  height: 150, width: 150, fit: BoxFit.cover),
                              Text(ds["Name"],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                ds["Price"],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.only(top: 20),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Welcome Back,",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.brown),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      child: PageView.builder(
                        onPageChanged: (value) {
                          setState(() {
                            currentSlide = value;
                          });
                        },
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "images/360_F_265289587_7oUPFd9yaSrD6op2GsfnTZLfR9EgwcDu.jpg"),
                                      fit: BoxFit.fill)),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned.fill(
                      bottom: 10,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                              4,
                              (index) => AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    width: currentSlide == index ? 15 : 8,
                                    height: 8,
                                    margin: EdgeInsets.only(right: 3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: currentSlide == index
                                            ? Colors.black
                                            : Colors.transparent,
                                        border:
                                            Border.all(color: Colors.black)),
                                  )),
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: showItem(),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(height: 270, child: allItems()),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: allItemsVertically(),
              )
            ],
          ),
        ),
      )),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            Fruits = true;
            Vegetables = false;
            Snacks = false;
            Dairy = false;
            foodItemStream = await DatabaseMethods().getFoodItem("Fruits");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: Fruits ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
              child: Image.asset(
                  "images/fruits-juice-your-daily-diet-with-juice-works-everyday-food-8.png",
                  height: 50,
                  width: 50,
                  fit: BoxFit.fill),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            Fruits = false;
            Vegetables = true;
            Snacks = false;
            Dairy = false;
            foodItemStream = await DatabaseMethods().getFoodItem("Vegetables");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: Vegetables ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
              child: Image.asset(
                  "images/vegetables-vegitable-basket-png-clipart-image-gallery-yopriceville-25.png",
                  height: 50,
                  width: 50,
                  fit: BoxFit.fill),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            Fruits = false;
            Vegetables = false;
            Snacks = true;
            Dairy = false;
            foodItemStream = await DatabaseMethods().getFoodItem("Snacks");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: Snacks ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
              child: Image.asset(
                  "images/3558116-fast-food-french-fries-snacks_107838.png",
                  height: 50,
                  width: 50,
                  fit: BoxFit.fill),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            Fruits = false;
            Vegetables = false;
            Snacks = false;
            Dairy = true;
            foodItemStream = await DatabaseMethods().getFoodItem("Dairy");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: Dairy ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
              child: Image.asset("images/7295435.png",
                  height: 50, width: 50, fit: BoxFit.fill),
            ),
          ),
        ),
      ],
    );
  }
}
