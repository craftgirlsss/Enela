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
  List imageName = ['1.jpg','2.jpg','3.jpg', '4.jpg'];
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
    // startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    // timer?.cancel();
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
                      children: List.generate(imageName.length, (index) {
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
                            ],
                            image: DecorationImage(image: AssetImage('assets/images/${imageName[index]}'), fit: BoxFit.cover)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 25,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomLeft: Radius.circular(5))
                                    ),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Iconsax.star_bold, size: 17, color: Colors.orangeAccent),
                                        Text("Populer"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))
                                ),
                                child: const Text("Hello World")
                              )
                            ],
                          ),
                        ); 
                      },)
                    )
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20),
              child: SearchBar(
                onTap: (){},
                elevation: const WidgetStatePropertyAll(20),
                backgroundColor: const WidgetStatePropertyAll(Colors.white),
                padding: const WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(horizontal: 16.0)),
                leading: const Icon(Iconsax.search_normal_1_outline),
                hintText: "Cari layanan jasa terdekat",
                trailing: const [Icon(Icons.place_outlined)],
              ),
            )
            // searchBar()
          ],
        )
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
        const Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                const Text("Banyak layanan jasa yang tersedia", textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontFamily: "SF-Pro-Bold", fontWeight: FontWeight.normal, fontSize: 20)),
                const Text("Mudah untuk menyewa", textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontFamily: "SF-Pro-Bold", fontWeight: FontWeight.bold, fontSize: 30)),
              ],
            ),
          ),
        )
      ],
    );
  }
}