import 'package:flutter/material.dart';
import 'package:flutter_matchaholic_project_uts/class/mahasiswa.dart';
import 'package:flutter_matchaholic_project_uts/main.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditProfileState();
}

class _EditProfileState extends State<Editprofile> {
  final List<String> allPrograms = ["IMES", "DSAI", "DMT", "ITDD", "GD", "NCS"];
  String _userProgram = "IMES";
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = loggedInUser?.name ?? "Username";
    _bioController.text = loggedInUser?.biografi ?? "Biografi";
    _userProgram = loggedInUser?.program ?? "IMES";
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
                    backgroundImage: NetworkImage(loggedInUser?.photo ?? ""),
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
                          "Nama:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(controller: _nameController),
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
                          'Program / Lab:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButton<String>(
                          value: _userProgram,
                          //.map_is_a_method_for_iterate_a_list
                          items: allPrograms.map((program) {
                            return DropdownMenuItem(
                              child: Text(program),
                              value: program,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _userProgram = value ?? allPrograms[0];
                            });
                          },
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
                          "Biografi:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _bioController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          minLines: 3,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          elevation: WidgetStateProperty.all(5),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, 'editprofile');
                        },
                        child: const Text('BATAL'),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          elevation: WidgetStateProperty.all(5),
                        ),
                        onPressed: () async {
                          //mengupdate_value_user_yg_lg_login_setelah_diedit
                          if (loggedInUser != null) {
                            // loggedInUser = Mahasiswa(
                            //   id: loggedInUser!.id,
                            //   name: _nameController.text,
                            //   email: loggedInUser!.email,
                            //   password: loggedInUser!.password,
                            //   photo: loggedInUser!.photo,
                            //   program: _userProgram,
                            //   nrp: loggedInUser!.nrp,
                            //   biografi: _bioController.text,
                            // );
                          }
                          //untuk_update_data_user_yg_diedit_di_dlm_array_mahasiswas(Penting!!!)
                          // int index = mahasiswas.indexWhere(
                          //   (m) => m.id == loggedInUser!.id,
                          // );
                          // if (index != -1) {
                          //   mahasiswas[index] = loggedInUser!;
                          // }
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text('Edit Profil'),
                              content: Text('Edit profil berhasil!'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Close dialog
                                    Navigator.pushNamed(context, 'editprofile');
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Text('SUBMIT'),
                      ),
                    ],
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
