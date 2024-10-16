import 'dart:io';
import 'package:contact_app/views/contact/modal/contact_modal.dart';
import 'package:contact_app/views/contact/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    ContactModal model =
    ModalRoute.of(context)!.settings.arguments as ContactModal;

    nameController.text = model.name!;
    phoneController.text = model.phone!;
    emailController.text = model.email!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          "DETAIL PAGE",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        actions: [
           IconButton(
            onPressed: () {
              context.read<HomeProvider>().hideContact(model);
              Navigator.pop(context);
             },
              icon: const Icon(Icons.lock,
              color: Colors.white,
              ),
          ),
          IconButton(
            onPressed: () {
            showDialog(
                context: context,
                builder: (context) =>   AlertDialog(
                  title: const Text("Edit contact"),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: "Name",
                        ),
                      ),
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                        ),
                      ),
                      TextField(
                        controller: phoneController,
                        decoration: const InputDecoration(labelText: "Number"),
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                      ContactModal cmodal = ContactModal(
                        name: nameController.text,
                        phone: phoneController.text,
                        email: emailController.text,
                        image: model.image,
                      );
                      context.read<HomeProvider>().update(cmodal);
                      Navigator.pop(context);
                    },
                        child: const Icon(Icons.save_alt),
                    ),
                  ],
                ),
            );
          },
              icon: const Icon(Icons.edit,
              color: Colors.white,
              ),
          ),
        ],
       ),
      body: Padding(
        padding: const EdgeInsets.all(18),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              foregroundImage:  FileImage(File(model.image ?? '')),
              child: Center(
                child: Text(model.name!.substring(0, 1).toUpperCase(),
                style: const TextStyle(
                  fontSize: 50,
                ),),
              ),
            ),
            const SizedBox(height: 40),
            ListTile(
              leading: const Text(
                "Full Name : ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              title: Text(model.name!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              ),
              trailing: IconButton(
                onPressed: () async {
                await launchUrl(Uri.parse("sms:${model.phone}"),
                );
              }, icon: const Icon(Icons.sms_outlined),),
            ),
            ListTile(
              leading: const Text(
                "Phone Number : ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              title: Text(model.phone!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: IconButton(
                onPressed: () async {
                  await launchUrl(
                      "tel:${model.phone}"
                      as Uri);
                },
                icon: const Icon(Icons.call),
              ),
            ),
            ListTile(
              leading: const Text(
                "E-mail: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              title: Text(model.email!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: IconButton(
                onPressed: () async{
                await launchUrl(Uri.parse("mailto:${model.email}"),);
              },
                  icon: const Icon(Icons.email),
              ),
            )
          ],
        ),
      ),
      ),
     );
  }
}
