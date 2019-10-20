import 'package:flutter/material.dart';
import '../screens/add.dart';

class TodoList extends StatefulWidget {
  @override
  createState() => new _List();
}

class _List extends State<TodoList> {
  List<String> _items = [];

  void _addList() {
    setState(() {
     int index = _items.length;
     _items.add('Item ${index.toString()}');
    });
    print(context);
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Add()),
  );
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        if(index < _items.length) {
          return _buildList(_items[index]);
        }
      }
    );
  }

  Widget _buildList(String todoText) {
    return new ListTile(
      title: Text(todoText)
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Build _List Widget');
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Todo List')
      ),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _addList,
        tooltip: 'Add task',
        child: new Icon(Icons.add)
      ),
    );
  }
}