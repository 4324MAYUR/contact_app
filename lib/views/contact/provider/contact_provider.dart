 import 'package:contact_app/views/contact/modal/contact_modal.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider with ChangeNotifier {
  List<ContactModal> allContacts = [];
  List<ContactModal> hidContacts = [];
  int selectedIndex = 0;

    void addContact(ContactModal contact) {
    allContacts.add(contact);
    notifyListeners();
  }

   void deleteContact(int index) {
    allContacts.removeAt(index);
    notifyListeners();
  }

   void hdeleteContact(int index) {
    hidContacts.removeAt(index);
    notifyListeners();
  }

  void update(ContactModal model) {
     allContacts[selectedIndex] = model;
     notifyListeners();
  }
  void hideupdate(ContactModal model) {
    hidContacts[selectedIndex] = model;
     notifyListeners();
  }

  void index(int index)
  {
    selectedIndex = index;
  }

  void hideContact(ContactModal contact) {
    hidContacts.add(contact);
    allContacts.remove(contact);
    notifyListeners();
  }
  void unhideContact(ContactModal contact) {
    allContacts.add(contact);
    hidContacts.remove(contact);
    notifyListeners();
  }
}

