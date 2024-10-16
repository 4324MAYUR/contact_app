import 'dart:io';
import 'package:contact_app/utils/routes.dart';
import 'package:contact_app/views/contact/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HidePage extends StatefulWidget {
  const HidePage({super.key});

  @override
  State<HidePage> createState() => _HidePageState();
}

class _HidePageState extends State<HidePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: const Text(
            "HIDE PAGE",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18,
            ),
          ),
      ),
      body: ListView.builder(
        itemCount: context.watch<HomeProvider>().hidContacts.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () {
              context.read<HomeProvider>().hdeleteContact(index);
            },
            onTap: () {
              context.read<HomeProvider>().index(index);
              Navigator.of(context).pushNamed(AllRoutes.hidedetail,
                  arguments:(context).read<HomeProvider>().hidContacts[index]);
            },
            child: ListTile(
              leading: CircleAvatar(
                foregroundImage: FileImage(
                  File(context.watch<HomeProvider>().hidContacts[index].image!),
                ),
              ),
              title:    Text(context.watch<HomeProvider>().hidContacts[index].name!),
              subtitle: Text(context.watch<HomeProvider>().hidContacts[index].phone!),
              trailing: IconButton(
                onPressed: () async{
                  await launchUrl("tel:${context.watch<HomeProvider>().hidContacts[index].phone}" as Uri);
                },
                icon: const Icon(Icons.call),
              ),
            ),
          );
        },
      ),
    );
  }
}
