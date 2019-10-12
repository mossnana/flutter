import 'package:flutter/material.dart';

import '../models/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Netforce V3',
      description: 'Netforce Version 3',
      price: 999.00,
      imageUrl: 'https://is1-ssl.mzstatic.com/image/thumb/Purple127/v4/3d/d2/e7/3dd2e73e-1390-4dd5-ffa9-9c71c4d36fae/mzl.qungexev.png/246x0w.jpg'
    ),
    Product(
      id: 'p2',
      title: 'Netforce V10',
      description: 'Netforce Version 10',
      price: 999.00,
      imageUrl: 'https://netforce.com/static/theme/img/nf_logo_80.png'
    ),
    Product(
      id: 'p3',
      title: 'Odoo',
      description: 'Odoo Version 11',
      price: 999.00,
      imageUrl: 'https://www.almacom.co.th/logo.png'
    ),
    Product(
      id: 'p4',
      title: 'OpenERP',
      description: 'OpenERP Version 6',
      price: 999.00,
      imageUrl: 'https://blog.rootshell.be/wp-content/uploads/2013/11/logo_openerp.png'
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  void addProduct() {
    // _items.add(value);
    notifyListeners();
  }
}