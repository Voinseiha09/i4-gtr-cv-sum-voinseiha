import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MIMI_003',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Course and Learning Subject'),
      
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  List<String> items = []; 
  TextEditingController controller = TextEditingController();
  int? editingIndex; // null = create, not null = update

  String? selectedMethod;
  double volume = 0.0; 

  void saveItem() {
    String text = controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      if (editingIndex == null) {   
        items.add(text);
      } else {
        items[editingIndex!] = text;
        editingIndex = null;
      }
    });
    controller.clear();
  }
  void deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }
  void startEdit(int index) {
    controller.text = items[index];
    setState(() {
      editingIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: editingIndex == null
                          ? "Enter subject"
                          : "Edit subject!",
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: saveItem,
                  child: Text(editingIndex == null ? "Add" : "Update"),
                ),
              ],
            ),

            SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                    title: Text(items[index]),
                      // UPDATE
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Add more information!!"),
                                    actions: [
                                      TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Lecturer Name',
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Student Name',
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Student ID',
                                        ),
                                      ),


                                      Row(
                                        children: [
                                          Spacer(),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(
                                                context,
                                              ); // Close dialog
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("OK"),
                                          ),
                                       ],
                                      ),

                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text("More Requirement."),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => startEdit(index),
                          ),
                          // DELETE
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => deleteItem(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            Row(
              children: [
                SizedBox(
                  width: 40,
                  child: RadioListTile(
                    value: "off",
                    groupValue: selectedMethod,
                    onChanged: (value) {
                      setState(() {
                        selectedMethod = value;
                      });
                    },
                  ),
                ),
                Text("Off"),
                SizedBox(
                  width: 40,
                  child: RadioListTile(
                    value: "On",
                    groupValue: selectedMethod,
                    onChanged: (value) {
                      setState(() {
                        selectedMethod = value;
                      });
                    },
                  ),
                ),
                Text("On"),
                Spacer(),
              ],
            ),

            Row(children: [Spacer(), Text("Rate the difficulty  of the subject"), Spacer(),]),
            Slider(
              value: volume,
              min: 0,
              max: 100,
              divisions: 100,
              label: volume.toInt().toString(),
              onChanged: (value) {
                setState(() {
                  volume = value;
                });
              },
            ),
            
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: const Color.fromARGB(255, 153, 236, 236),
                      title: const Text("Register Now!!"),
                      content: const Text("Register to login Account!"),
                      actions: [
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter student name',
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter student ID',
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Email',
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Phone Number',
                          ),
                        ),
                       
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close dialog
                          },
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("Register account!"),
            ),
          ],
        ),
      ),
    );
  }
}
