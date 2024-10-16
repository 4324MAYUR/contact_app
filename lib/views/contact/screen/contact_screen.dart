import 'dart:io';
import 'package:contact_app/utils/routes.dart';
import 'package:contact_app/views/contact/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AllRoutes.hide);
             },
            icon: const Icon(
              Icons.lock,
              color: Colors.white,
            ),
          ),
          PopupMenuButton(
              itemBuilder: (context) =>
          [
            PopupMenuItem(
              child: Text("value 1"),
            ),
            PopupMenuItem(
              child: Text("value 2"),
            ),
          ]
          ),
        ],
      ),

      body: ListView.builder(
        itemCount: context.watch<HomeProvider>().allContacts.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () {
              context.read<HomeProvider>().deleteContact(index);
             },
            onTap: () {
              context.read<HomeProvider>().index(index);
              Navigator.of(context).pushNamed(AllRoutes.detail,
                  arguments:(context).read<HomeProvider>().allContacts[index]);
            },
            child: ListTile(
              leading: CircleAvatar(
                foregroundImage: FileImage(
                  File(context.watch<HomeProvider>().allContacts[index].image!),
                ),
              ),
              title:    Text(context.watch<HomeProvider>().allContacts[index].name!),
              subtitle: Text(context.watch<HomeProvider>().allContacts[index].phone!),
              trailing: IconButton(
                onPressed: () async {
                  await launchUrl(
                      "tel:${context.watch<HomeProvider>().allContacts[index].phone}"
                      as Uri);
                },
                icon: const Icon(Icons.call),
              ),
            ),
          );
        },
      ),
       floatingActionButton: FloatingActionButton(
         onPressed: () {
          Navigator.of(context).pushNamed(AllRoutes.addcontact);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
