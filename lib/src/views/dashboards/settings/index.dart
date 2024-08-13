import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:perfume/src/views/dashboards/settings/edit_profile.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          TextButton.icon(
            onPressed: (){
              Get.to(() => const EditProfile());
            },
            label: const Text("Edit", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            icon: const Icon(Iconsax.edit_2_outline, size: 20,))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(blurRadius: 15, color: Colors.black12, offset: Offset(0, 20)),
                ],
                color: Colors.white
              ),
              child: Column(
                children: [
                  CircleAvatar(radius: 50, backgroundImage: const AssetImage('assets/images/logo-splash.png'), onBackgroundImageError: (exception, stackTrace) => const Text("Error"),),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Saputra Budianto", style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Iconsax.call_outline, size: 15),
                      Text(" 0881036480285", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.normal)),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Iconsax.home_2_outline, size: 15),
                      Text(" Griya Bhayangkara blok i5/07", textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.normal)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Divider(),
            ListTile(
              onTap: (){},
              leading: const Icon(Iconsax.card_outline),
              title: const Text("Metode Pembayaran", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              trailing: const Icon(Iconsax.arrow_circle_right_outline),
            ),
            ListTile(
              onTap: (){},
              leading: const Icon(Iconsax.messages_2_outline),
              title: const Text("Chat Support", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              trailing: const Icon(Iconsax.arrow_circle_right_outline),
            ),
            ListTile(
              onTap: (){},
              leading: const Icon(Iconsax.profile_2user_outline),
              title: const Text("Gabung Jadi Mitra", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              trailing: const Icon(Iconsax.arrow_circle_right_outline),
            ),
            ListTile(
              onTap: (){},
              leading: const Icon(Iconsax.security_user_outline),
              title: const Text("Kebijakan Pengguna", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              trailing: const Icon(Iconsax.arrow_circle_right_outline),
            ),
            ListTile(
              onTap: (){},
              leading: const Icon(Iconsax.logout_1_outline, color: Colors.red),
              title: const Text("Keluar", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              trailing: const Icon(Iconsax.arrow_circle_right_outline),
            ),
          ],
        ),
      ),
    );
  }
}
