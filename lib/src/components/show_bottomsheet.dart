import 'package:flutter/material.dart';
import 'package:perfume/src/components/global_variable.dart';

showBottomSheetCustom(context, {String? title, String? content}){
  return showModalBottomSheet<void>(
    context: context,
    elevation: 0,
    backgroundColor: Colors.transparent,
    sheetAnimationStyle: AnimationStyle(curve: Curves.bounceIn),
    builder: (BuildContext context) {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 20
            )
          ],
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: Container(
                alignment: Alignment.center,
                width: 70,
                height: 5,
                decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(10))
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 350,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(title ?? "This title", style: TextStyle(color: Colors.black87, fontSize: 23, fontFamily: "SF-Pro-Bold", fontWeight: FontWeight.bold),),
                    Text(content ?? """
              
              Selamat datang di platform nyewa.id, mitra terpercaya untuk kemajuan usaha kecil dan menengah (UMKM). Kami adalah penyedia layanan jasa serbaguna yang berkomitmen untuk meningkatkan kesejahteraan dan pertumbuhan bisnis UMKM di seluruh Indonesia.
              
              Kami memahami betapa pentingnya dukungan yang tepat dalam menghadapi tantangan bisnis sehari-hari. Itulah mengapa kami hadir untuk menyediakan solusi lengkap yang membantu UMKM meraih potensi maksimal mereka. Layanan kami mencakup berbagai aspek penting dari operasional bisnis, termasuk namun tidak terbatas pada:
              
1. Konsultasi Jasa Peralatan Pesta
              
2. Konsultasi Jasa Pembuatan Software dan Website
              
3. Service AC atau Elektronik
              
4. Instalasi Kelistrikan Industri maupun Rumah
              
5. Jasa pembuatan dekorasi rumah
              
6. Jasa pembuatan peralatan sparepart mesin dan masih banyak lagi
              
              Visi kami adalah menjadi platform penghubung antar UMKM dengan Client agar demi kesejahteraan bersama.
              
              Mari bergabung dengan nyewa.id dan temukan bagaimana kami dapat membantu memecahkan masalah anda.
              """, style: TextStyle(color: Colors.black87, fontSize: 15, fontFamily: "SF-Bold", fontWeight: FontWeight.bold),),
                    ElevatedButton(
                      child: const Text('Tutup', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: GlobalVariables.buttonColorGreen,
                        elevation: 0
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            )

          ],
        ),
      );
    },
  );
}