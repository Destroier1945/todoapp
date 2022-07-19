import 'package:flutter/material.dart';
import 'package:todoapp/models/item.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO APP',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  List<Item> items = <Item>[];

  HomePage({Key? key}) : super(key: key){

    items.add(Item(title: "Banana", done: false));
    items.add(Item(title: 'Abacate', done: true));
    items.add(Item(title: 'Item 3', done: false));
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var newTaskCtrl = TextEditingController();

  void add(){
    if(newTaskCtrl.text.isEmpty) return;
    setState((){
      widget.items.add(Item(
        title: newTaskCtrl.text,
        done: false,
      ),);
      newTaskCtrl.text = "";
    });
  }

  void remove(int index){
    setState((){
      widget.items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: newTaskCtrl,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
          decoration: InputDecoration(
            labelText: 'Nova tarefa',
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.deepPurple,
        ),
        itemCount: widget.items.length,
        itemBuilder: ( context ,index) => Padding(
            padding: EdgeInsets.all(8.0),
        child: Dismissible(
          child: CheckboxListTile(
            title: Text(widget.items[index].title.toString(),),
            value: widget.items[index].done,
            onChanged: (value){
              setState((){
                widget.items[index].done = value;
              }
              );
            },

          ),

          key: Key(widget.items[index].title.toString(),),
          background: Container(
            color: Colors.red.withOpacity(0.2),
          ),
          onDismissed: (direcion){
            remove(index);
          },
        ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: Icon(Icons.add),
      ),
    );
  }
}
