import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  File? image;
  int setIndex = 0;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text("ADD CONTACT PAGE",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
         padding: const EdgeInsets.all(18),
         child: Stepper(
           currentStep: setIndex,onStepContinue: () {
           setIndex < 2
               ? setIndex++
               : null;
           setState(() {});
         },
           onStepCancel: () {
             setIndex > 0 ? setIndex-- : null;
             setState(() {});
           },

             steps:  [
               Step(
                 title: const Text("Add Photo"),
                 content: Stack(
                   alignment: Alignment.bottomRight,
                   children: [
                     CircleAvatar(
                       radius: 80,
                       backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtFq93ATVDmO6zlMdXcTGzF81WfbiNbSH3-w&s"),
                       foregroundImage: image != null
                           ?FileImage(image!)
                           :null,
                     ),
                     FloatingActionButton.small(
                       onPressed: () async {
                         ImagePicker picker = ImagePicker();
                         XFile? file=
                             await picker.pickImage(source: ImageSource.gallery);
                         if(file != null)
                           {
                             // log?('Image Add');
                             image = File(file.path);
                             setState(() {});
                           }
                         else
                           {
                              log("Image not received" as num);
                           }
                     },
                       child: const Icon(Icons.camera_alt),
                     ),
                   ],
                 ),
               ),
               Step(
                   title: const Text("Contact Information"),
                   content: Column(
                     children: [
                       const SizedBox(height: 20),
                       TextField(
                         controller: nameController,
                         decoration: const InputDecoration(
                           labelText: "Enter Name",
                           hintText: "Enter Your Name",
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.all(Radius.circular(20),
                             ),
                           ),
                         ),
                       ),
                       const SizedBox(height: 20),
                       TextField(
                         controller: phoneController,
                         decoration: const InputDecoration(
                           labelText: "Enter Number",
                           hintText: "Enter Your Phone Number",
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.all(Radius.circular(20),
                             ),
                           ),
                         ),
                       ),
                       const SizedBox(height: 20),
                       TextField(
                         controller: emailController,
                         decoration: const InputDecoration(
                           labelText: "Enter E-mail",
                           hintText: "Enter Your E-mail",
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.all(Radius.circular(20),
                             ),
                           ),
                         ),
                       ),
                     ],
                   ),
               ),
            Step(
              title: const Text("SAVE"),
              content: ElevatedButton(
               onPressed: () {
            if (nameController != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Contact Info Saved")));
            }
          },
          child: const Text("SAVE"),
           ),

         ),
        ],
      ),
      ),
    );
  }
}
