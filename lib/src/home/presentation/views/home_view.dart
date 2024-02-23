
import 'package:flutter/material.dart';
import 'package:tdd_tutorial_flutter/core/res/media_res.dart';
import 'package:tdd_tutorial_flutter/core/widgets/gradient_background.dart';
import 'package:tdd_tutorial_flutter/src/home/presentation/refactors/home_body.dart';
import 'package:tdd_tutorial_flutter/src/home/presentation/widgets/home_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: HomeAppBar(),
      body: GradientBackground(
        image: MediaRes.onBoardingBackground,
        child: HomeBody(),
      ),
    );
  }
}
