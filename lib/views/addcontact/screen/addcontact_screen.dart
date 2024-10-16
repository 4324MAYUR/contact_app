import 'dart:io';
import 'dart:math';
import 'package:contact_app/views/contact/modal/contact_modal.dart';
import 'package:contact_app/views/contact/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  File? image;
  int setIndex = 0;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          "CONTACT PAGE",
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
             setIndex > 0
                 ? setIndex--
                 : null;
             setState(() {});
           },
             steps:  [
               Step(
                 title: const Text("Step 1: Add Photo"),
                 content: Column(
                   children: [
                     Stack(
                       alignment: Alignment.bottomRight,
                       children: [
                         CircleAvatar(
                           radius: 80,
                           backgroundImage: const NetworkImage(
                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtFq93ATVDmO6zlMdXcTGzF81WfbiNbSH3-w&s",
                           ),
                           foregroundImage: image != null
                               ? FileImage(image!)
                               : null,
                         ),
                         FloatingActionButton.small(
                           onPressed: () async {
                             ImagePicker picker = ImagePicker();
                             XFile? file = await picker.pickImage(
                                 source: ImageSource.gallery);
                             if (file != null) {
                               image = File(file.path);
                               setState(() {});
                             }
                           },
                           child: const Icon(Icons.camera_alt),
                         ),
                       ],
                     ),
                     const SizedBox(height: 10),
                     const Text(
                       "Add a profile picture",
                       style: TextStyle(fontSize: 14, color: Colors.black),
                     ),
                   ],
                 ),
               ),
               Step(
                 title: const Text("Step 2: Contact Information"),
                 content: Form(
                   key: formkey,
                   child: Column(
                     children: [
                       const SizedBox(height: 20),
                       TextFormField(
                         controller: nameController,
                         decoration: const InputDecoration(
                           labelText: "Full Name",
                           hintText: "Enter Your Full Name",
                           prefixIcon: Icon(Icons.person),
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.all(Radius.circular(20)),
                           ),
                         ),
                       ),
                       const SizedBox(height: 20),
                       TextFormField(
                         controller: phoneController,
                         keyboardType: TextInputType.phone,
                         decoration: const InputDecoration(
                           labelText: "Phone Number",
                           hintText: "Enter Your Phone Number",
                           prefixIcon: Icon(Icons.phone),
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.all(Radius.circular(20)),
                           ),
                         ),
                       ),
                       const SizedBox(height: 20),
                       TextFormField(
                         controller: emailController,
                         keyboardType: TextInputType.emailAddress,
                         decoration: const InputDecoration(
                           labelText: "Email Address",
                           hintText: "Enter Your Email",
                           prefixIcon: Icon(Icons.email),
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.all(Radius.circular(20)),
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
               ),
               Step(
                 title: const Text("Save"),
                 content: ElevatedButton(
                   onPressed: () {
                     if (formkey.currentState?.validate() == true)
                     {
                       ContactModal model = ContactModal(
                         name: nameController.text,
                         email: emailController.text,
                         phone: phoneController.text,
                          image: image?.path ?? '',
                       );
                         context.read<HomeProvider>().addContact(model);
                         Navigator.pop(context);
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
