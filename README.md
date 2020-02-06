# BLoC Pattern
ตัวอย่างการใช้งาน BLoC Pattern โดยใช้ Library ชื่อ flutter_bloc

โครงสร้างแอปโดยสมมุติ
- **App** -> (context ของ App ถูกส่งไปที่ HomeScreen โดยที่มี BLoC ส่งไปด้วย)
  - **HomeScreen** -> (context ของ App และ HomeScreen ถูกส่งไปที่ ContainerX โดยที่มี BLoC ส่งไปด้วย)
    - **ContainerX**

---
ไฟล์ **app.dart**
```dart
void main() {
  // ให้ userRepository เป็นจุดเริ่มต้นทุกอย่างใน App อาจจะเป็น Object ที่ใช้ในการเชื่อมต่อฐานข้อมูล หรือเรียก APIs ก็ได้
  // ในกรณี Firestore ก็อาจจะเป็น Firestore.instance
  final userRepository = ...;
  runApp(
    // ครอบ BLoC ชั้นแรกด้วย AuthenticationBloc
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        // สร้าง AuthenticationBloc() ขึ้นมาใหม่ตัวนึงส่งค่า userRepository เข้าไปเช็ค Business Logic และ  ....
        // ทำการส่ง Event ไปให้ BLoC เพื่อเริ่มการทำงานของ BLoC โดย BLoC ทำงานเป็น Stream มันจะทำงานเช็ค Event เรื่อยๆ เพื่อให้ได้ state กลับมาเรื่อยๆ
        // และเราจะใช้ state นั้นในการกำหนดว่า App เราควรแสดงผลอะไร (Declarative style)
        return AuthenticationBloc(userRepository: userRepository)
          ..add(AppStarted());
      },
      // context ที่ส่งไปใน App() จะถูกแนบไปด้วย AuthenticationBloc ทีอยู่ในสถานะ AppStarted()
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatelessWidget {
  final OdooClient userRepository;
  App({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUninitialized) {
            return SplashPage();
          }
          if (state is AuthenticationAuthenticated) {
            return HomeScreen(userRepository: userRepository);
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginScreen(userRepository: userRepository);
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
          return SplashPage();
        },
      ),
    );
  }
}
```
---
ไฟล์ **HomeScreen.dart**
```dart
class HomeScreen extends StatefulWidget {
  final OdooClient _userRepository;

  HomeScreen({
    @required Key key,
    @required userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  OdooClient get _userRepository => widget._userRepository;
  OdooUser get _odooUser => widget._userRepository.odooUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // นอกจาก BlocProvider ที่ใช้ฝัง BLoC เข้าไปใน context แล้วเรายังใข้ MultiBlocProvider ในการฝัง BLoC หลายๆชนิด เข้าไปใน context ได้อีก
    // ซึ่ง BLoC [FetchUserBloc, FetchWorkOrderBloc] จะเอาไว้ใช้ใน WorkOrderScreen() อีกที
    return MultiBlocProvider(
        providers: [
          BlocProvider<FetchUserBloc>(
            create: (BuildContext context) =>
            FetchUserBloc(odooUser: _odooUser)..add(FetchUserStarted()),
          ),
          BlocProvider<FetchWorkOrderBloc>(
            create: (BuildContext context) =>
                FetchWorkOrderBloc(odooClient: _userRepository)..add(FetchWorkOrderStarted()),
          ),
        ],
        child: ContainerX()
    );
  }
}
```
---

ไฟล์ **container_x.dart**
```dart
class ContainerX extends StatefulWidget {
  @override
  State<ContainerX> createState() => _ContainerX();
}

class _ContainerX extends State<ContainerX> {

  @override
  Widget build(BuildContext context) {
    // ประกาศวิตเจตเก็บไว้ชื่อ _Container
    // วิตเจตนี้ใช้ BlocBuilder ในการสร้างวิตเจตอีกที
    Widget _Container = BlocBuilder<FetchUserBloc, FetchDataState>(
      // BlocBuilder นี้รับ BLoC ประเภท FetchUserBloc ที่อยู่ใน context วิตเจตต้นทาง
      bloc: BlocProvider.of<FetchUserBloc>(context),
      // ตัวสร้าง Widget โดยส่ง state มาให้
      builder: (context, state) {
        // อยู่ในขั้นตอนการเช็ก state ของ BLoC นี้เพื่อดูว่าควรจะ return วิตเจตไหนออกไปดี
        if(state is FetchUserSuccess) {
          return Container(
              child: StreamBuilder(
                stream: state.info(),
                builder: (context, snapshot) {
                  if(snapshot.hasError) {
                    return Text('SnapShot Error');
                  } else if(snapshot.hasData) {
                    print(snapshot.data);
                    return Text(snapshot.data['name']);
                  } else {
                    return Text("Loading ... in Stream Builder");
                  }
                },
              )
          );
        } else if(state is FetchUserFailed) {
          return Container(
              child: Text('Failed')
          );
        } else {
          return Container(
              child: Text('Loading ...')
          );
        }
      },
    );

    return _Container;
  }
}
```
