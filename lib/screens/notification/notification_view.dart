import 'package:flutter/material.dart';

import '../../widgets/custom_appbar.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar2(
        title: 'Notifications',
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
