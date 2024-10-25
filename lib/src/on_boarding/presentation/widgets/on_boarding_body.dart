import 'package:flutter/material.dart';
import 'package:air_guard/core/extensions/context_extensions.dart';
import 'package:air_guard/src/on_boarding/domain/entities/page_content.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({required this.pageContent, super.key});

  final PageContent pageContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
                height: 300,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(pageContent.image),
                    fit: BoxFit.cover,
                  ),
                ))),
        SizedBox(height: context.height * .03),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.07),
          child: Text(
            pageContent.title,
            textAlign: TextAlign.center,
            style: context.theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.theme.colorScheme.onBackground,
            ),
          ),
        ),
      ],
    );
  }
}
