import 'package:data_collocter/screens/user_details.dart';
import 'package:data_collocter/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/database.dart';
import '../widgets/appBar_title.dart';

class HomeScreen extends StatefulWidget {
  final String uid;

  const HomeScreen({super.key, required this.uid});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> userData = [];
  bool isLoading = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle("DATA", "FLUX", 22, 22),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            // print(DatabaseMethods().fireStore);
            FirebaseAuth.instance.signOut();
          }, icon: const Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: DatabaseMethods().fetchUserData(widget.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: CustomText(
              text: 'No user data found',
              fontSize: 18,
              color: Colors.black45,
              shadow: [],
            ));
          }

          List<Map<String, dynamic>> userData = snapshot.data!;

          return ListView.builder(
            itemCount: userData.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomText(
                              text: 'Name: ${userData[index]['name']}',
                              fontSize: 18,
                              shadow: [],
                              color: const Color(0xff375e97),
                            ),
                            const Spacer(),
                            InkWell(
                                onTap: () {
                                  nameController.text = userData[index]["name"];
                                  ageController.text = userData[index]["age"];
                                  locationController.text =
                                      userData[index]["location"];
                                  editEmployeeDetails(userData[index]["id"]);
                                },
                                child: const Icon(
                                  Icons.edit,
                                  size: 18,
                                  color: Color(0xff375e97),
                                )),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                                onTap: () async {
                                  await DatabaseMethods().deleteEmployeeDetails(
                                      userData[index]['id'], widget.uid);
                                },
                                child: InkWell(
                                    onTap: () {
                                      DatabaseMethods().deleteEmployeeDetails(
                                          widget.uid, userData[index]['id']);
                                    },
                                    child: const Icon(
                                      Icons.delete_forever,
                                      size: 20,
                                      color: Color(0xfffb6542),
                                    )))
                          ],
                        ),
                        CustomText(
                          text: 'Age: ${userData[index]['age']}',
                          fontSize: 18,
                          shadow: const [],
                          color: const Color(0xfffb6542),
                        ),
                        CustomText(
                          text: 'Location: ${userData[index]['location']}',
                          fontSize: 18,
                          shadow: const [],
                          color: const Color(0xff375e97),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xffff2f00),
        tooltip: 'Add User',
        label: const CustomText(
          text: 'Add',
          fontSize: 16,
          color: Colors.white,
          shadow: [],
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UserDetails(
                    uid: widget.uid,
                      )));
        },
        icon: const Icon(
          Icons.add,
          color: Color(0xffffffff),
          weight: 5,
          size: 25,
        ),
      ),
    );
  }

  Future editEmployeeDetails(String id) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: SizedBox(
              width: MediaQuery.of(context).size.width / 2.5,
              height: MediaQuery.of(context).size.height / 1.5,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 30,
                            )),
                        const SizedBox(
                          width: 35,
                        ),
                        appBarTitle('Edit', 'Details', 19, 18)
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 3),
                      child: CustomText(
                        text: 'Name',
                        fontSize: 17,
                        color: Color(0xff375e97),
                        shadow: [],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 3, right: 3),
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black54,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 3),
                      child: CustomText(
                        text: 'Age',
                        fontSize: 17,
                        color: Color(0xff375e97),
                        shadow: [],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 3, right: 3),
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black54,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        controller: ageController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 3),
                      child: CustomText(
                        text: 'Location',
                        fontSize: 17,
                        color: Color(0xff375e97),
                        shadow: [],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 3, right: 3),
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black54,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        controller: locationController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            padding: const EdgeInsets.all(5),
                            child: TextButton(
                                child: const CustomText(
                                  text: "Update",
                                  fontSize: 18,
                                  color: Colors.white,
                                  shadow: [],
                                ),
                                onPressed: () async {
                                  Map<String, dynamic> userInfoMap = {
                                    "name": nameController.text,
                                    "age": ageController.text,
                                    "id": id,
                                    "location": locationController.text,
                                  };
                                  await DatabaseMethods()
                                      .updateEmployeeDetails(
                                          id, widget.uid, userInfoMap)
                                      .then((onValue) {
                                    Navigator.pop(context);
                                  });
                                }))),
                  ],
                ),
              ),
            ),
          ));
}
