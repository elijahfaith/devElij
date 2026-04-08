import 'package:link_go/utils/assets_manager.dart';

class OnboardingScreenModel {
  String image;
  String title;
  String content;

  OnboardingScreenModel({
    required this.image,
    required this.title,
    required this.content,
  });
}
List<OnboardingScreenModel> getScreens() {
  List<OnboardingScreenModel> screens = [];

  // screen 1
  OnboardingScreenModel screenOne = OnboardingScreenModel(
    image: Assets.onboardingOne,
    title: "Shop with Confidence",
    content:
    "Verified sellers, secure payments, and quality\nassurance for every purchase",
  );
  screens.add(screenOne);

  // screen 2
  OnboardingScreenModel screenTwo = OnboardingScreenModel(
    image: Assets.onboardingTwo,
    title: "Discover Amazing Deals",
    content:
    "Explore curated products and exclusive offers\nthat save you time and money",
  );
  screens.add(screenTwo);

  // screen 3
  OnboardingScreenModel screenThree = OnboardingScreenModel(
    image: Assets.onboardingThree,
    title: "Fast & Reliable Delivery",
    content:
    "Get your orders delivered swiftly and safely,\nright to your doorstep",
  );
  screens.add(screenThree);

  return screens;
}

