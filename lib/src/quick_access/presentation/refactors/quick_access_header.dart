
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdd_tutorial_flutter/core/res/media_res.dart';
import 'package:tdd_tutorial_flutter/src/quick_access/presentation/providers/quick_access_tab_controller.dart';

class QuickAccessHeader extends StatelessWidget {
  const QuickAccessHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuickAccessTabController>(
      builder: (_, controller, __) {
        return Center(
          child: Image.asset(
            controller.currentIndex == 0
                ? MediaRes.blue_pot_plant
                : controller.currentIndex == 1
                    ? MediaRes.turquoise_pot_plant
                    : MediaRes.steam_cup,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
