import 'package:flutter/material.dart';
import 'package:flutter_matchaholic_project_uts/main.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditProfileState();
}

class _EditProfileState extends State<Editprofile> {
  String _programCategory = "IMES";

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editprofile')),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Card(
            color: Colors.grey[200],
            margin: const EdgeInsets.all(20),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage("https://i.pravatar.cc/150"),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Isinya nama lengkap user yg login",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 5,
                          offset: const Offset(2, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Program / Lab',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButton(
                          items: const [
                            DropdownMenuItem(
                              value: "IMES",
                              child: Text("IMES"),
                            ),
                            DropdownMenuItem(
                              value: "DSAI",
                              child: Text("DSAI"),
                            ),
                            DropdownMenuItem(value: "DMT", child: Text("DMT")),
                            DropdownMenuItem(
                              value: "ITDD",
                              child: Text("ITDD"),
                            ),
                            DropdownMenuItem(value: "GD", child: Text("GD")),
                            DropdownMenuItem(value: "NCS", child: Text("NCS")),
                          ],
                          value: _programCategory,
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 5,
                          offset: const Offset(2, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Biografi',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text("Isinya bio dari user yg lg login"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
