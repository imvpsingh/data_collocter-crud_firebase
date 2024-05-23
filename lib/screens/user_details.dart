import 'package:data_collocter/services/database.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import '../widgets/appBar_title.dart';
import '../widgets/custom_text.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  String massage = "";
  Color massageColor = Colors.red;
  Color fieldBorderColor = Colors.black54;
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color(0xffedf4f2),
        title: appBarTitle("USER", "DETAILS",22,22),
        actions: const [
          SizedBox(
            width: 85,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25,
            ),
            isLoading ? const Center(
              child: CircularProgressIndicator(color: Colors.green,)
        
              ):const SizedBox(),
            Center(
              child: CustomText(
                text: massage,
                fontSize: 20,
                shadow: const [],
                color: massageColor,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: CustomText(
                text: 'Name',
                fontSize: 20,
                color: Color(0xff375e97),
                shadow: [],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: fieldBorderColor,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Enter Name"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: CustomText(
                text: 'Age',
                fontSize: 20,
                color: Color(0xff375e97),
                shadow: [],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: fieldBorderColor),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: TextFormField(
                controller: ageController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Age",
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: CustomText(
                text: 'Location',
                fontSize: 20,
                color: Color(0xff375e97),
                shadow: [],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: fieldBorderColor),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: TextFormField(
                controller: locationController,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Enter Location"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                padding: const EdgeInsets.all(10),
                child: TextButton(
                  onPressed: () async {
                    if (nameController.text != "" &&
                        ageController.text != "" &&
                        locationController.text != "") {
                     setState(() {
                       massage ="";
                       isLoading = true;
                       fieldBorderColor = Colors.black54;
                       // fetchUserData();
                     });
                      String id = randomAlphaNumeric(10);
                      Map<String, dynamic> userInfoMap = {
                        "name": nameController.text,
                        "age": ageController.text,
                        "id": id,
                        "location": locationController.text,
                      };
                      await DatabaseMethods()
                          .addUserDetails(userInfoMap, id)
                          .then((value) {
                        setState(() {
                          isLoading = false;
                          massageColor = Colors.green;
                          massage = "Data Save Successfully";
                          nameController.text = "";
                          ageController.text = "";
                          locationController.text = "";
                        });
                      });
                    } else {
                      setState(() {
                        massageColor = Colors.redAccent;
                        massage = "fill all field";
                        fieldBorderColor = Colors.red;
                      });
                    }
                  },
                  child: const CustomText(
                    text: "Add",
                    fontSize: 18,
                    shadow: [],
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
