import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instrument_store_mobile/presentation/pages/profile/profile_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    Get.put(ProfileController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return const SizedBox.shrink();
      },
    );
  }
}
