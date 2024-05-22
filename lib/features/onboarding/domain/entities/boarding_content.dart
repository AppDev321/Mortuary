import '../../../../core/constants/app_assets.dart';

class OnboardingContents {
  final String title;
  final String image;
  final String desc;
  final String buttonLabel;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
    required this.buttonLabel
  });
}
List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Welcome to Freshly!",
    image: AppAssets.boarding1,
    desc: "Experience hassle-free laundry services right at your fingertips. Let Freshly take care of your laundry needs efficiently",
    buttonLabel: "Next"
  ),
  OnboardingContents(
      title: "Showcase your expertise",
      image: AppAssets.boarding2,
      desc: "Highlight your laundry expertise. Display your services and attract customers with your unique offerings.",
      buttonLabel: "Next"
  ),
  OnboardingContents(
      title: "Receive request in real-time",
      image: AppAssets.boarding3,
      desc: "Get notified instantly with real-time service requests. Seamlessly manage incoming laundry orders to optimize your workflow.",
      buttonLabel: "Next"
  ),

  OnboardingContents(
      title: "Let’s Grow Together",
      image: AppAssets.boarding4,
      desc: "Ready to elevate your laundry business? Let's grow together with Freshly! Your success, our commitment.",
      buttonLabel: "Next"
  ),
];