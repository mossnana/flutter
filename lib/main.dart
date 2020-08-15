import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_get_x/controllers/page_controller.dart';
import 'package:test_get_x/enums/page_enum.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('rebuilt my app');
    return GetMaterialApp(
      initialRoute: '/root',
      title: 'GetX Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      getPages: [
        GetPage(name: '/root', page: () => RootPage()),
        GetPage(name: '/about', page: () => AboutPage()),
      ],
    );
  }
}

class RootPage extends StatefulWidget {
  @override
  State<RootPage> createState() {
    return RootPageStage();
  }
}

class RootPageStage extends State<RootPage> {
  AppPageController appPageController = AppPageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('rebuilt root page');
    return GetX<AppPageController>(
      init: appPageController,
      builder: (pageModel) {
        switch (pageModel.page.value.name) {
          case PageEnum.Home:
            return HomePage();
          default:
            return LoginPage();
        }
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('rebuilt home page');
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Home Screen'),
                  SizedBox(
                    height: 10,
                  ),
                  FlatButton(
                    color: Colors.blue,
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Get.find<AppPageController>().updatePage(PageEnum.Login);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  TextEditingController usernameCtl = TextEditingController();
  TextEditingController passwordCtl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print('rebuilt login page');
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: usernameCtl,
                  ),
                  TextField(
                    controller: passwordCtl,
                  ),
                  FlatButton(
                    color: Colors.blue,
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      print('Username ${usernameCtl.text}');
                      print('Password ${passwordCtl.text}');
                      Get.find<AppPageController>().updatePage(PageEnum.Home);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Center(
              child: Text('Hello'),
            ),
          );
        },
      ),
    );
  }
}
