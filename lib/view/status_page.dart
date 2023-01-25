import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterrun/view/login_page.dart';

import '../application/user/user_notifier.dart';
import 'home_page.dart';


class StatusPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ref) {
    final userData = ref.watch(userNotifierProvider);
    return Scaffold(
      body:  userData.user.isEmpty ? LoginPage() : HomePage()
    );
  }
}
