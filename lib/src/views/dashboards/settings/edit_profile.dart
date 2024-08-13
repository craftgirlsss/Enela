import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:perfume/src/components/input_anytext.dart';
import 'package:perfume/src/components/input_email.dart';
import 'package:perfume/src/components/input_phone.dart';
import 'package:perfume/src/views/dashboards/settings/edit_location.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    locationController.dispose();
    phoneController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Edit Profile"),
        actions: [
          TextButton(
            onPressed: (){},
            child: const Text("Simpan", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            InputTextAnyText(controller: nameController, hintText: "Nama Lengkap", icon: Iconsax.profile_circle_outline),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: InputTextEmail(controller: emailController, readOnly: true),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: InputTextPhoneWhatsapp(controller: phoneController),
            ),
            InputTextAnyText(controller: locationController, hintText: "Alamat Lengkap", icon: Icons.place_outlined, readOnly: true, onPressed: () => Get.to(() => const EditLocation()),),
          ],
        ),
      ),
    );
  }
}
