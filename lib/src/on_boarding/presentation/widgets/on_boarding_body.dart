import 'package:flutter/material.dart';
import 'package:tdd_tutorial_flutter/core/extensions/context_extension.dart';
import 'package:tdd_tutorial_flutter/core/res/colors.dart';
import 'package:tdd_tutorial_flutter/core/res/fonts.dart';
import 'package:tdd_tutorial_flutter/src/on_boarding/domain/page_content.dart';

class OnBoardingBody extends StatelessWidget{
  const OnBoardingBody({required this.pageContent,super.key});
  final PageContent pageContent;

  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(pageContent.image,height: context.height * .4,),
        SizedBox(height: context.height * .03,),
        Padding(padding: const EdgeInsets.all(20).copyWith(bottom: 0),
        child: Column(
          children: [
            Text(
              pageContent.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: Fonts.aeonik,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: context.height * .02,),
            Text(
              pageContent.description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
            SizedBox(height: context.height * .05,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 17
                ),
              backgroundColor: Colours.primaryColour,
              foregroundColor: Colors.white
              ),

              onPressed: ()async{
                
              }, 
            child: const Text(
              'Get Started', style: TextStyle(
                fontFamily: Fonts.aeonik,
                fontWeight: FontWeight.bold,
              )
            ))

          ],
        ),
        ),

      ],
    );
  }
}