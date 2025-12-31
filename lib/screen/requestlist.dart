import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_matchaholic_project_uts/class/mahasiswa.dart';
import 'package:flutter_matchaholic_project_uts/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Requestlist extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RequestListState();
  }
}

class _RequestListState extends State<Requestlist> {
  Mahasiswa? _mhs;
  bool isLoading = true;

  Future<List> daftarRequest() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString("user_id") ?? '0';

    final response = await http.post(
      Uri.parse("https://ubaya.cloud/flutter/160422127/friendrequestlist.php"),
      body: {'receiverid': userId},
    );

    if (response.statusCode == 200) {
      print(response.body);
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      setState(() {
        Mhs.clear();
        if (json['result'] == 'success') {
          for (var item in json['data']) {
            Mhs.add(Mahasiswa.fromJson(item));
          }
        }
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
    throw Exception('Failed to read API');
  }

  @override
  void initState() {
    super.initState();
    daftarRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Permintaan Koneksi')),
      drawer: const MyDrawer(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Mhs.isEmpty
          ? const Center(child: Text('Tidak ada permintaan koneksi'))
          : SingleChildScrollView(
              child: Column(
                children: Mhs.map((m) {
                  return Container(
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromRGBO(128, 128, 128, 0.5),
                          spreadRadius: -6,
                          blurRadius: 8,
                          offset: const Offset(8, 7),
                        ),
                      ],
                    ),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(m.photo),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        m.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'NRP: ${m.nrp}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        m.program,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                      Colors.black,
                                    ),
                                    elevation: WidgetStateProperty.all(5),
                                  ),
                                  onPressed: () {
                                    // TODO: Implement accept request
                                  },
                                  child: const Text(
                                    'Terima',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                      Colors.grey[300],
                                    ),
                                    elevation: WidgetStateProperty.all(5),
                                  ),
                                  onPressed: () {
                                    // TODO: Implement reject request
                                  },
                                  child: const Text(
                                    'Tolak',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }
}
