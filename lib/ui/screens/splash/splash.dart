import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_app/logic/core/app_router.dart';
import 'package:task_manager_app/ui/helpers/cache_helper.dart';
import 'package:task_manager_app/ui/helpers/size_config.dart';
import 'package:task_manager_app/ui/helpers/space_widgets.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashBody(),
    );
  }
}

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      _navigateToNextView();
    });

    super.initState();
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticIn,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlutterLogo(
                size: SizeConfig.defaultSize * 18,
              ),
              const VerticalSpace(2),
              Text(
                "TASK MANAGER APP",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.defaultSize * 2,
                  letterSpacing: 2,
                  wordSpacing: 1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToNextView() async {
    var isLogin = CacheHelper.getData(key: "userId");
    if (isLogin != null) {
      context.pushReplacement(AppRouter.kHomePage);
    } else {
      context.pushReplacement(AppRouter.kLogInPage);
    }
  }
}
