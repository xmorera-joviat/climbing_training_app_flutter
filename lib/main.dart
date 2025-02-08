import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime currentDate = DateTime.now(); // Inicialitzar amb la data actual
  String? selectedRocodrom;
  bool isDescansosChecked = false;
  String? selectedDescansos;
  List<String> grades = List.generate(20, (index) => "Grade $index");
  List<String> items = List.generate(10, (index) => "Item $index");
  String? selectedDifficulty; // Variable per a la dificultat

  void _incrementDate() {
    setState(() {
      currentDate = currentDate.add(Duration(days: 1));
    });
  }

  void _decrementDate() {
    setState(() {
      currentDate = currentDate.subtract(Duration(days: 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Date Navigation
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: _decrementDate,
                  ),
                  Text(
                    "${currentDate.day}/${currentDate.month}/${currentDate.year}",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.orange), // Mostrar en color taronja
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: _incrementDate,
                  ),
                  IconButton(
                    icon: Icon(Icons.today),
                    onPressed: () {
                      setState(() {
                        currentDate = DateTime.now(); // Reiniciar a la data actual
                      });
                    },
                  ),
                ],
              ),
            ),

            // Spinner (Dropdown)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButton<String>(
                value: selectedRocodrom,
                items: ["Rocodrom 1", "Rocodrom 2"].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRocodrom = value;
                  });
                },
                hint: Text("Select Rocodrom"),
              ),
            ),

            // Difficulty Buttons
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedDifficulty = "Fàcil";
                      });
                    },
                    child: Text("Fàcil"),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedDifficulty = "Mitjà";
                      });
                    },
                    child: Text("Mitjà"),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedDifficulty = "Difícil";
                      });
                    },
                    child: Text("Difícil"),
                  ),
                ],
              ),
            ),

            // GridLayout for Zones
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Card(
                  child: Center(child: Text("Zona $index")),
                );
              },
            ),

            // Input Section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: isDescansosChecked,
                        onChanged: (value) {
                          setState(() {
                            isDescansosChecked = value!;
                          });
                        },
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Text("Descansos (zona de corda):"),
                            SizedBox(width: 10),
                            DropdownButton<String>(
                              value: selectedDescansos,
                              items: ["1", "2", "3"].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedDescansos = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemCount: grades.length,
                    itemBuilder: (context, index) {
                      return ElevatedButton(
                        onPressed: () {},
                        child: Text(grades[index]),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Divider
            Divider(),

            // Score and Metrics
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text("Puntuació:", style: TextStyle(fontSize: 18)),
                      Text("---", style: TextStyle(fontSize: 36, color: Colors.green)),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Mitjana:", style: TextStyle(fontSize: 18)),
                      Text("---", style: TextStyle(fontSize: 36)),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text("Vies:", style: TextStyle(fontSize: 18)),
                      Text("---", style: TextStyle(fontSize: 36, color: Colors.blue)),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Metres:", style: TextStyle(fontSize: 18)),
                      Text("---", style: TextStyle(fontSize: 36, color: Colors.blue)),
                    ],
                  ),
                ],
              ),
            ),

            // Divider
            Divider(),

            // RecyclerView (ListView)
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}