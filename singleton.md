# Singleton Pattern
## Singleton
รูปแบบการสร้าง Class ให้มีวัตถุจาก Class นี้ได้แค่ชิ้นเดียวในแอป
ตัวอย่าง
- ในระบบ Windows ที่มี Printer หลายตัวควรจะมี Printer Spooler (บริการที่ทำหน้าที่จัดเรียงงานพิมพ์และจัดการกับเครื่องพิมพ์) แค่วัตถุเดียว ควรจะมี File System และ Windows Manager แค่ตัวเดียว

## การใช้งาน
### ExampleStateBase
```dart
abstract class ExampleStateBase {
	@protected
	String initialText;
	@protected
	String stateText;
	String get currentText => stateText;

	void setStateText(String text) {
	stateText = text;
	}

	void reset() {
	stateText = initialText;
	}
}
```
### ExampleStateByDefinition
```dart
class ExampleStateByDefinition extends ExampleStateBase {
	// _instance จะเป็นวัตถุ ExampleStateByDefinition ที่เข้าถึงได้จากทุกที่เพราะเป็นตัวแปร static
	static ExampleStateByDefinition _instance;
	// _internal() ใช้ในลักษณะของการประกาศ Factory Constructor
	ExampleStateByDefinition._internal() {
		initialText = "A new 'ExampleStateByDefinition' instance has been created.";
		stateText = initialText;
		print(stateText);
	}
	// การเข้าถึงวัถตุนั้น
	static ExampleStateByDefinition getState() {
		// ถ้ายังไม่มีการสร้างวัตถุให้สร้างมันสะ
		if (_instance == null) {
			_instance = ExampleStateByDefinition._internal();
		}
		// ถ้ามีอยู่แล้วให้ return ตัวปัจจุบันไป
		return _instance;
	}
}
```

ตัวอย่างแบบเต็ม
```dart
class SingletonExample extends StatefulWidget {
	@override
	_SingletonExampleState createState() => _SingletonExampleState();
}

class _SingletonExampleState extends State<SingletonExample> {
	final List<ExampleStateBase> stateList = [
		// วัตถุที่ 1
		ExampleState(),
		// วัตถุที่ 2
		ExampleStateByDefinition.getState(),
		// วัตถุที่ 3
		ExampleStateWithoutSingleton()
		
		// วัตถุที่ 1 กับ 2 จะเป็นวัตถุเดียวกัน
	];

	void _setTextValues([String text = 'Singleton']) {
		for (var state in stateList) {
			state.setStateText(text);
		}
		setState(() {});
	}

	void _reset() {
		for (var state in stateList) {
			state.reset();
		}
		setState(() {});
	}

	@override
	Widget build(BuildContext context) {
		return ScrollConfiguration(
			behavior: ScrollBehavior(),
			child: SingleChildScrollView(
				padding: const EdgeInsets.symmetric(horizontal: paddingL),
				child: Column(
					children: <Widget>[
						for (var state in stateList)
							Padding(
								padding: const EdgeInsets.only(bottom: paddingL),
								child: SingletonExampleCard(
									text: state.currentText,
								),
							),
						const SizedBox(height: spaceL),
						PlatformButton(
							child: Text("Change states\' text to 'Singleton'"),
							materialColor: Colors.black,
							materialTextColor: Colors.white,
							onPressed: _setTextValues,
						),
						PlatformButton(
							child: Text("Reset"),
							materialColor: Colors.black,
							materialTextColor: Colors.white,
							onPressed: _reset,
						),
						const SizedBox(height: spaceXL),
						Text(
							'Note: change states\' text and navigate the application (e.g. go to the tab "description" or main menu, then go back to this example) to see how the Singleton state behaves!',
							textAlign: TextAlign.justify,
						),
					],
				),
			),
		);
	}
}
```