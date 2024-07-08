import 'dart:async';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:perfume/src/components/global_variable.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController scrollController = ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  PageController pageController = PageController(initialPage: 0);
  List imageName = ['background.jpg','logo-splash.png','signup-image.jpg',];
  int activePage = 0;
  Timer? timer;

  void startTimer(){
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if(pageController.page == imageName.length - 1){
        pageController.animateToPage(0, duration: const Duration(seconds: 1), curve: Curves.easeInOut);
      }else{
        pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.easeInOut);
      }
    },);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  imageOffer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 10,  left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("What's New", style: TextStyle(fontFamily: "SF-Pro-Bold", fontSize: 18, fontWeight: FontWeight.bold),),
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(50, 30),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.centerLeft),
                          iconAlignment: IconAlignment.end,
                          icon: const Icon(Icons.arrow_forward_ios_rounded, size: 15,),
                          onPressed: (){}, 
                          label: const Text("View all")
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: (1 / 1.2),
                      physics: const ScrollPhysics(),
                      mainAxisSpacing: 8.0, // spacing between rows
                      crossAxisSpacing: 8.0, // spacing between columns
                      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 100), // padding around the grid // total number of items
                      children: List.generate(5, (index) {
                        return Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white, // color of grid items
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 0),
                                blurRadius: 10
                              ),
                            ]
                          ),
                          child: Center(
                            child: Text(
                              "Index $index",
                              style: TextStyle(fontSize: 18.0, color: Colors.black),
                            ),
                          ),
                        ); 
                      },)
                    )
                  )
                ],
              ),
            ),
            searchBar()
          ],
        )
      ),
    );
  }

  Widget searchBar(){
    return Positioned(
      top: 45,
      right: 15,
      left: 15,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black26,
              offset: Offset(0, 0)
            )
          ]
        ),
        child: Row(
          children: <Widget>[
            IconButton(
              splashColor: Colors.grey,
              icon: const Icon(Iconsax.search_normal_1_outline),
              onPressed: () {},
            ),
            const Expanded(
              child: TextField(
                cursorColor: Colors.black,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                decoration: InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 15), hintText: "Search..."),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageOffer(){
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height/2.2,
          child: PageView.builder(
            controller: pageController,
            physics: const ScrollPhysics(),
            onPageChanged: (value) => setState(() => activePage = value),
            itemCount: imageName.length,
            pageSnapping: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => imageStack(imageName[index])
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(imageName.length, (index) {
                return InkWell(
                  onTap: (){
                    pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                  },
                  child: Container(
                    width: 40,
                    height: 3,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: activePage == index ? GlobalVariables.buttonColorGreen : Colors.black12
                    ),
                  ),
                );
              },),
            ),
          ),
        )
      ],
    );
  }

  Widget imageStack(String imageNameFile){
    return Stack(
      children: [
        ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black, Colors.transparent
              ],
            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
          },
          blendMode: BlendMode.dstIn,
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 2.2,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/$imageNameFile',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                const Text("Best Perfume in Indonesia", textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontFamily: "SF-Pro-Bold", fontWeight: FontWeight.normal, fontSize: 20)), 
                const Text("Welcome to Enela", textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontFamily: "SF-Pro-Bold", fontWeight: FontWeight.bold, fontSize: 30)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalVariables.buttonColorGreen
                    ),
                    onPressed: (){

                    }, 
                  child: const Text("Shop Now", style: TextStyle(color: GlobalVariables.textColorWhite))),
                ),

              ],
            ),
          ),
        )
      ],
    );
  }
}