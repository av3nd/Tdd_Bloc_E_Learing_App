
import 'package:flutter/material.dart';
import 'package:tdd_tutorial_flutter/core/res/media_res.dart';
import 'package:tdd_tutorial_flutter/core/widgets/gradient_background.dart';
import 'package:tdd_tutorial_flutter/src/profile/presentation/refactors/profile_body.dart';
import 'package:tdd_tutorial_flutter/src/profile/presentation/refactors/profile_header.dart';
import 'package:tdd_tutorial_flutter/src/profile/presentation/widgets/profile_app_bar.dart';
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: const ProfileAppBar(),
      body: GradientBackground(
        image: MediaRes.onBoardingBackground,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: const [
            ProfileHeader(),
            ProfileBody(),

          ],
        ),
      ),
    );
  }
}
