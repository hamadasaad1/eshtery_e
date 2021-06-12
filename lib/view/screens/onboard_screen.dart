import 'package:elbya3/core/network/local/local_helper.dart';
import 'package:elbya3/model/onboard_model.dart';
import 'package:elbya3/size_config.dart';
import 'package:elbya3/view/component/component.dart';
import 'package:elbya3/view/component/custom_svg_.dart';
import 'package:elbya3/view/component/custom_text.dart';
import 'package:elbya3/view/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; 
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast = false;
  List<OnBoardModel> listItemBoard = [
    OnBoardModel(
        image: 'assets/icons/shop_one.svg',
        body: 'Welcome to the eshtery, you can buy anything easily',
        title: 'Eshtery'),
    OnBoardModel(
        image: 'assets/icons/shop_two.svg',
        body: 'Register now, it will not take you any time in the registration process',
        title: 'Eshtery'),
    OnBoardModel(
        image: 'assets/icons/shop_three.svg',
        body: 'The first shopping application in Upper Egypt',
        title: 'Eshtery'),
  ];

  var controllerPageView = PageController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                submitLastViewPage();
              },
              child: const Text(
                "Skip",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(getProportionateScreenHeight(20)),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: controllerPageView,
                  onPageChanged: (value) {
                    print(value.toString());
                    print(listItemBoard.length.toString());

                    if (value == (listItemBoard.length) - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = true;
                      });
                    }
                  },
                  itemBuilder: (context, index) =>
                      buildItemPageView(listItemBoard[index]),
                  itemCount: listItemBoard.length,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(35),
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: controllerPageView,
                    count: listItemBoard.length,
                    axisDirection: Axis.horizontal,
                    effect: const ExpandingDotsEffect(
                        spacing: 3.0,
                        radius: 4.0,
                        dotWidth: 10.0,
                        dotHeight: 10.0,
                        paintStyle: PaintingStyle.fill,
                        strokeWidth: 1.2,
                        dotColor: Colors.grey,
                        expansionFactor: 3.2),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submitLastViewPage();
                      } else {
                        controllerPageView.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios_outlined),
                  )
                ],
              )
            ],
          ),
        ));
  }

  buildItemPageView(OnBoardModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: CustomSvg(
            iconPath: '${model.image}',
            height: SizeConfig.screenHeight / 2.5,
            width: SizeConfig.screenWidth / 2.5,
          ),
        ),
        CustomText(
          text: '${model.title}',
          size: 20,
        ),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        Text(
          '${model.body}',
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(fontSize: 18, fontFamily: 'RobotoCondensed'),
        )
      ],
    );
  }

  void submitLastViewPage() {
    CacheHelper.setDataToSharedPref(key: "OnBoarding", value: true)
        .then((value) {
      changeNavigatorReplacement(context, ShopLoginScreen());
    });
  }
}
