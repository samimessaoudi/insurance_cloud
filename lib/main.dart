import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Isurance Cloud Console',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // TODO: Switch Toggle
        //useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

enum AccountMenu { settings, logout }

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPageIndex = 0;
  bool _settingsDialogOpen = false;

  // TODO: Got From Firebase Data Instead
  String _productLogoUrl = "";
  String _userAvatarUrl = "";
  String _userFullName = "Sami Messaoudi";

  void _logout() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          NavigationRail(
            useIndicator: false,
            groupAlignment: 0.0,
            labelType: NavigationRailLabelType.selected,
            selectedIndex: _selectedPageIndex,
            leading: CircleAvatar(
              backgroundImage: NetworkImage(_productLogoUrl),
            ),
            onDestinationSelected: (int index) {
              setState(() {
                _selectedPageIndex = index;
              });
            },
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: Text("Home"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.list_outlined),
                selectedIcon: Icon(Icons.list),
                label: Text("Billing"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.message_outlined),
                selectedIcon: Icon(Icons.message),
                label: Text("Issues"),
              ),
            ],
            trailing: PopupMenuButton<AccountMenu>(
              onSelected: (AccountMenu value) {
                switch (value) {
                  case AccountMenu.settings:
                    setState(() {
                      _settingsDialogOpen = true;
                    });
                    break;
                  case AccountMenu.logout:
                    _logout();
                    break;
                  default:
                }
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuItem<AccountMenu>>[
                const PopupMenuItem<AccountMenu>(
                  value: AccountMenu.settings,
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Settings"),
                  ),
                ),
                const PopupMenuItem<AccountMenu>(
                  value: AccountMenu.logout,
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text("Logout"),
                  ),
                ),
              ],
              child: _userAvatarUrl.isNotEmpty
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(_userAvatarUrl),
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.lightBlue,
                      child: Text(
                        // Gets Full Name Initials
                        _userFullName.splitMapJoin(
                          " ",
                          onMatch: (matches) => "",
                          onNonMatch: (nonMatches) => nonMatches[0],
                        ),
                      ),
                    ),
            ),
          ),
          const VerticalDivider(
            thickness: 1,
            width: 1,
          ),
          Expanded(
            child: Center(child: ProductsPage()),
          )
          /*
          Expanded(
            child: Center(child: const Requests()),
          )
          */
        ],
      ),
    );
  }
}

enum Platform { web, android, iOS }

enum DeploymentStatus { idk }

enum GooglePlayStoreCredential {
  idk
} // Not, Only Available in Database And Usable By Functions; No They Are Send From Form In Here

class ReleaseNotes {
  // Per Platform
  final String version;
  final DateTime date;
  final String notes;
  ReleaseNotes(this.version, this.date, this.notes);
}

class PlatformProduct {
  final Platform platform;
  final bool isDemoAppDeployed;
  final bool isProductionAppDeployed;

  final List<ReleaseNotes> releasesNotes;

  PlatformProduct(this.platform, this.isDemoAppDeployed,
      this.isProductionAppDeployed, this.releasesNotes);
}

class Product {
  // Demo Eligibility Thing
  final String logoUrl;
  final bool isPurchased;
  final String label;
  final String caption;
  final List<PlatformProduct> platformVariants;
  Product(this.isPurchased, this.label, this.caption, this.platformVariants,
      this.logoUrl);
}

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

enum Environment { production, demo }

class _ProductsPageState extends State<ProductsPage> {
  Environment environment = Environment.demo;
  List<Product> products = [
    Product(true, "sdfsf", "sdfsd", [], "..."),
    Product(true, "sdfsf", "sdfsd", [], "...")
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextButton.icon(
          onPressed: () {
            setState(() {
              environment = environment == Environment.demo
                  ? Environment.production
                  : Environment.demo;
            });
          },
          icon: const Icon(Icons.swap_horiz),
          label: Text(
              "Switch to ${environment == Environment.demo ? "production" : "dev"} environment"), // TODO: Pad To To Right
        ),
        GridView.extent(
          maxCrossAxisExtent: 250,
          children: List<Card>.generate(
            products.length,
            (index) {
              return Card(
                child: ExpansionTile(
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(products[index].logoUrl)),
                  title: Text(products[index].label),
                  subtitle: Text(products[index].caption),
                  children: List<ListTile>.generate(
                    products[index].platformVariants.length,
                    (index) => ListTile(
                      title: Text("..."),
                      subtitle: Text("..."),
                      leading: Text("IconNotText"),
                      trailing: Text("IconNotText"),
                    ),
                  ),
                  maintainState: true,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class RequestsPage extends StatelessWidget {
  final RequestsSource requestsSource = RequestsSource();

  RequestsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                fullscreenDialog: true,
                builder:
                    (context) => /*const CreateRequestDialog()*/ const Text(""),
              ),
            );
          },
          icon: const Icon(Icons.add),
          label: const Text("Create request"),
        ),
        PaginatedDataTable(
          showCheckboxColumn: false,
          showFirstLastButtons: true,
          // TODO: Develop
          columns: <DataColumn>[],
          source: requestsSource,
          onPageChanged: (page) => requestsSource.onPageChanged(page),
          onRowsPerPageChanged: (rowsPerPage) =>
              requestsSource.onRowsPerPageChanged(rowsPerPage),
          // TODO: Open Issue Saying "Implement onSortColumnIndexChanged" And Describe Use Case
        ),
      ],
    );
  }
}

class Request {
  Request();
}

class RequestsSource extends DataTableSource {
  static const String requestsCollection = '...';
  static const String requestsCustomerField = '...';
  final Query _query = FirebaseFirestore.instance
      .collection(requestsCollection)
      .where(
          "$requestsCustomerField = ${FirebaseAuth.instance.currentUser!.uid}");
  int _page = 1;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _rowCount = 0;
  List<DataRow> _currentPageRows = [];

  RequestsSource() {
    // TODO: Open Issue Saying "Implement Query.select() (Projection)" And Describe Use Case
    _query.snapshots().listen(
      (event) {
        if (_rowCount != event.size) {
          _rowCount = event.size;
          updateDataRows();
        }
        _rowCount = event.size;
      },
      onError: (e) {},
      onDone: () {}, // To Be Used When Implementing Loading Indicator
      cancelOnError: true,
    );
    updateDataRows(initialCall: true);
  }

  @override
  DataRow? getRow(int index) => _currentPageRows[index % _rowsPerPage];

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _rowCount;

  @override
  int get selectedRowCount => 0;

  // TODO: Implement StartAt/After
  // TODO: Implement Query Result With Converter
  void updateDataRows({bool initialCall = false}) {
    _query.limit(_rowsPerPage).snapshots().listen(
          (event) {},
          onError: (e) {},
          onDone: () {}, // To Be Used When Implementing Loading Indicator
          cancelOnError: true,
        );
    if (!initialCall) {
      notifyListeners();
    }
  }

  void onPageChanged(int page) {
    _page = page;
    updateDataRows();
  }

  void onRowsPerPageChanged(int? rowsPerPage) {
    if (rowsPerPage != null) {
      _rowsPerPage = rowsPerPage;
      updateDataRows();
    }
  }
}

// TODO: Develop
/*
class CreateRequestDialog extends StatelessWidget {
  const CreateRequestDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          child: ,
        ),
      ),
    );
  }
}
*/

// TODO: Home would contain Text("Welcome To Your Isurance Cloud Console")
