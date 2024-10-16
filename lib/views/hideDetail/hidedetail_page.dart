import 'dart:io';
import 'package:contact_app/utils/routes.dart';
import 'package:contact_app/views/contact/modal/contact_modal.dart';
import 'package:contact_app/views/contact/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HideDetailPage extends StatefulWidget {
  const HideDetailPage({super.key});

  @override
  State<HideDetailPage> createState() => _HideDetailPageState();
}

class _HideDetailPageState extends State<HideDetailPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    ContactModal hmodel =
    ModalRoute.of(context)!.settings.arguments as ContactModal;

    nameController.text = hmodel.name!;
    phoneController.text = hmodel.phone!;
    emailController.text = hmodel.email!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          "HIDE DETAIL PAGE",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                LocalAuthentication auth = LocalAuthentication();

                bool isAuthenticated = await auth.authenticate(
                  localizedReason: "Open to access hidden contacts !!",
                );

                if (isAuthenticated) {
                  Navigator.of(context).pushNamed(AllRoutes.hide);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Authentication Failed"),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.lock)
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
                        ContactModal  hmodal = ContactModal(
                          name: nameController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                          image: hmodel.image,
                        );
                        context.read<HomeProvider>().hideupdate(hmodal);
                        Navigator.pop(context);
                      },
                      child: const Center(
                          child:  Icon(Icons.save_alt)),
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
                foregroundImage:  FileImage(File(hmodel.image ?? '')),
                child: Center(
                  child: Text(hmodel.name!.substring(0, 1).toUpperCase(),
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
                title: Text(hmodel.name!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () async {
                    await launchUrl(Uri.parse("sms:${hmodel.phone}"),
                    );
                  }, icon: const Icon(Icons.sms_outlined),
                ),
              ),
              ListTile(
                leading: const Text(
                  "Phone Number : ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                title: Text(hmodel.phone!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () async {
                    await launchUrl(
                        "tel:${hmodel.phone}"
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
                title: Text(hmodel.email!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () async{
                    await launchUrl(Uri.parse("mailto:${hmodel.email}"),);
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
