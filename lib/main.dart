import 'dart:developer' as developer;
import 'dart:html' as html;
import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:flutterfire_ui/i10n.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:uuid/uuid.dart';

import 'constants.dart';
import 'enums/environment.dart';
import 'enums/platform.dart';
import 'firebase_options.dart';
import 'models/product.dart';
import 'models/request.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterFireUIAuth.configureProviders([const GoogleProviderConfiguration(clientId: GOOGLE_SIGN_IN_WEB_CLIENT_ID), const EmailProviderConfiguration(), const PhoneProviderConfiguration()]);

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
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (!snapshot.hasData) {
            return SignInScreen(
              headerBuilder: (context, constraints, _) => Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset('logo.png'),
              ),
              sideBuilder: (context, constraints) => Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset('logo.png'),
              ),
              subtitleBuilder: (context, action) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(action == AuthAction.signIn ? 'Welcome to Insurance Cloud! Please sign in to continue' : 'Welcome to Insurance Cloud! Please create an account to continue'),
              ),
              footerBuilder: (context, action) => const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('By signing in, you agree to our terms and conditions.', style: TextStyle(color: Colors.grey)),
              ),
            );
          }

          return HomePage();
        },
      );
}

enum UserAccountMenu { settings, logout }

class HomePage extends StatefulWidget {
  final bool isAdmin = FirebaseAuth.instance.currentUser!.providerData[0].email!.split('@')[1] == html.window.location.hostname;
  final List<NavigationRailDestination> userMenu = <NavigationRailDestination>[
    const NavigationRailDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: Text("Home"),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.list_outlined),
      selectedIcon: Icon(Icons.list),
      label: Text("Billing"),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.message_outlined),
      selectedIcon: Icon(Icons.message),
      label: Text("Issues"),
    ),
  ];
  final List<NavigationRailDestination> adminMenu = <NavigationRailDestination>[
    const NavigationRailDestination(
      icon: Icon(Icons.app_registration_outlined),
      selectedIcon: Icon(Icons.app_registration),
      label: Text("Apps"),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.payments_outlined),
      selectedIcon: Icon(Icons.payments),
      label: Text("Payments"),
    ),
  ];

  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// TODO: Handle Navigation
// TODO: Set Client logo.png Asset In Build Pipeline
class _HomePageState extends State<HomePage> {
  int _selectedPageIndex = 0;
  bool _settingsDialogOpen = false;

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
            leading: const CircleAvatar(
              backgroundImage: AssetImage('logo.png'),
            ),
            onDestinationSelected: (int index) {
              setState(() {
                _selectedPageIndex = index;
              });
            },
            destinations: widget.isAdmin ? widget.adminMenu : widget.userMenu,
            trailing: PopupMenuButton<UserAccountMenu>(
              onSelected: (UserAccountMenu value) async {
                switch (value) {
                  case UserAccountMenu.settings:
                    setState(() {
                      _settingsDialogOpen = true;
                    });
                    break;
                  case UserAccountMenu.logout:
                    try {
                      await FirebaseAuth.instance.signOut();
                    } on FirebaseAuthException catch (e) {
                      // Handle Erros Using e.code And e.message
                    }
                    break;
                  default:
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuItem<UserAccountMenu>>[
                const PopupMenuItem<UserAccountMenu>(
                  value: UserAccountMenu.settings,
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Settings"),
                  ),
                ),
                const PopupMenuItem<UserAccountMenu>(
                  value: UserAccountMenu.logout,
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text("Logout"),
                  ),
                ),
              ],
              child: FirebaseAuth.instance.currentUser?.photoURL != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.lightBlue,
                      child: Text(
                        // Gets Full Name Initials
                        FirebaseAuth.instance.currentUser!.displayName!.splitMapJoin(
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

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  Environment environment = Environment.demo;
  List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextButton.icon(
          onPressed: () {
            setState(() {
              environment = environment == Environment.demo ? Environment.production : Environment.demo;
            });
          },
          icon: const Icon(Icons.swap_horiz),
          label: Text("Switch to ${environment == Environment.demo ? "production" : "dev"} environment"), // TODO: Pad To To Right
        ),
        GridView.extent(
          maxCrossAxisExtent: 250,
          children: List<Card>.generate(
            products.length,
            (productIndex) => Card(
              child: ExpansionTile(
                maintainState: true,
                leading: CircleAvatar(backgroundImage: NetworkImage(products[productIndex].logoUrl)),
                title: Text(products[productIndex].label),
                subtitle: Text(products[productIndex].caption),
                children: List<ListTile>.generate(
                  products[productIndex].platformVariants.length,
                  (platformProductIndex) => ListTile(
                    leading: Icon(
                      (() {
                        switch (products[productIndex].platformVariants[platformProductIndex].platform) {
                          case Platform.web:
                            return Icons.web;
                          case Platform.android:
                            return Icons.android;
                          case Platform.iOS:
                            return Icons.apple;
                          default:
                        }
                      })(),
                    ),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Expanded(
                          child: Text("..."),
                        ),
                        Builder(
                          builder: (BuildContext context) {
                            if (environment == Environment.production) {
                              return products[productIndex].platformVariants[platformProductIndex].isProductionAppDeployed
                                  ? const Icon(
                                      Icons.stop_rounded,
                                      color: Colors.red,
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        try {
                                          FirebaseFunctions.instance.httpsCallable("name").call();
                                        } on FirebaseFunctionsException catch (e) {
                                          developer.log(
                                            e.message!,
                                            stackTrace: e.stackTrace,
                                          ); // TODO: Reaffine
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.play_arrow_rounded,
                                        color: Colors.green,
                                      ),
                                    );
                            } else {
                              return products[productIndex].platformVariants[platformProductIndex].isDemoAppDeployed
                                  ? const Icon(
                                      Icons.stop_rounded,
                                      color: Colors.red,
                                    )
                                  : const Icon(
                                      Icons.play_arrow_rounded,
                                      color: Colors.green,
                                    );
                            }
                          },
                        ),
                      ],
                    ),
                    subtitle: const Text("..."),
                  ),
                ),
              ),
            ),
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
                builder: (context) => /*const CreateRequestDialog()*/ const Text(""),
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
          onRowsPerPageChanged: (rowsPerPage) => requestsSource.onRowsPerPageChanged(rowsPerPage),
          // TODO: Open Issue Saying "Implement onSortColumnIndexChanged" And Describe Use Case
        ),
      ],
    );
  }
}

class RequestsSource extends DataTableSource {
  static const String requestsCollection = '...';
  static const String requestsCustomerField = '...';
  final Query _query = FirebaseFirestore.instance.collection(requestsCollection).where("$requestsCustomerField = ${FirebaseAuth.instance.currentUser!.uid}");
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

enum FormMode { creating, viewing, editing }

class RequestForm extends StatefulWidget {
  final FormMode formMode;
  late Request request;
  late DocumentReference requestFirestoreRef;
  late Reference requestAttachementsStorageRef;

  RequestForm({Key? key, required this.formMode, Request? request}) : super(key: key) {
    request = request ?? Request();
    requestFirestoreRef = FirebaseFirestore.instance.doc('requests/${request.id}');
    requestAttachementsStorageRef = FirebaseStorage.instance.ref().child('requests/${request.id}/attachments');
  }

  @override
  State<RequestForm> createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  final _formKey = GlobalKey<FormState>();
  late Request request;
  List<dynamic> attachments = [];

  @override
  void initState() {
    super.initState();

    request = widget.request;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: FutureBuilder(
                  future: widget.requestAttachementsStorageRef.listAll(),
                  builder: (BuildContext context, AsyncSnapshot<ListResult> snapshot) {
                    if (snapshot.hasData) {
                      attachments = snapshot.data!.items;
                      return GridView.extent(
                        maxCrossAxisExtent: 250,
                        children: <Widget>[
                          if (widget.formMode != FormMode.creating)
                            ...List<Widget>.generate(attachments.length, (index) {
                              if (attachments[index] is File) {
                                return StatefulBuilder(builder: (context, setState) {
                                  double? uploadProgress;
                                  String originalFileName = p.basename(attachments[index].path);
                                  Reference newFileRef = widget.requestAttachementsStorageRef.child(const Uuid().v1()); // TODO: Use Uuid().v5

                                  try {
                                    widget.requestAttachementsStorageRef.putFile(File(attachments[index])).snapshotEvents.listen((taskSnapshot) {
                                      switch (taskSnapshot.state) {
                                        case TaskState.running:
                                          setState(() {
                                            uploadProgress = taskSnapshot.bytesTransferred / taskSnapshot.totalBytes;
                                          });
                                          break;
                                        case TaskState.paused:
                                          break;
                                        case TaskState.success:
                                          newFileRef.updateMetadata(SettableMetadata(customMetadata: {
                                            'originalFileName': originalFileName,
                                          }));
                                          setState(() {
                                            attachments[index] = newFileRef;
                                          });
                                          break;
                                        case TaskState.canceled:
                                          setState(() {
                                            attachments.removeAt(index);
                                          });
                                          break;
                                        case TaskState.error:
                                          // TODO: Show Error Indicator And Add Retry Capability
                                          setState(() {
                                            uploadProgress = null;
                                          });
                                          break;
                                      }
                                    });
                                  } on FirebaseException catch (e) {
                                    // TODO: Handle This
                                  }
                                  return Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[
                                        Text(p.basename(attachments[index].path)),
                                        if (uploadProgress != null)
                                          CircularProgressIndicator(
                                            value: uploadProgress,
                                          ),
                                      ],
                                    ),
                                  );
                                });
                              }
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  double? downloadingProgress;
                                  return FutureBuilder(
                                    future: attachments[index]!.getMetadata(),
                                    builder: (BuildContext context, AsyncSnapshot<FullMetadata> customMetadataSnapshot) {
                                      if (widget.formMode == FormMode.viewing) {
                                        Container(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    IconButton(
                                                      onPressed: downloadingProgress != null
                                                          ? null
                                                          : () async {
                                                              String? savePath = await getSavePath(suggestedName: customMetadataSnapshot.data!.customMetadata!['originalFileName']!, confirmButtonText: 'Save');
                                                              if (savePath == null) {
                                                                return;
                                                              }
                                                              try {
                                                                attachments[index]!.writeToFile(File(savePath)).snapshotEvents.listen((taskSnapshot) {
                                                                  switch (taskSnapshot.state) {
                                                                    case TaskState.running:
                                                                      setState(() {
                                                                        downloadingProgress = taskSnapshot.bytesTransferred / taskSnapshot.totalBytes;
                                                                      });
                                                                      break;
                                                                    case TaskState.paused:
                                                                      break;
                                                                    case TaskState.success:
                                                                      // TODO: Show Success Indicator
                                                                      setState(() {
                                                                        downloadingProgress = null;
                                                                      });
                                                                      break;
                                                                    case TaskState.canceled:
                                                                      setState(() {
                                                                        downloadingProgress = null;
                                                                      });
                                                                      break;
                                                                    case TaskState.error:
                                                                      // TODO: Show Error Indicator
                                                                      setState(() {
                                                                        downloadingProgress = null;
                                                                      });
                                                                      break;
                                                                  }
                                                                });
                                                              } on FirebaseException catch (e) {
                                                                // TODO: Handle Errors
                                                              }
                                                            },
                                                      icon: const Icon(Icons.cloud_download),
                                                    ),
                                                    if (downloadingProgress != null)
                                                      CircularProgressIndicator(
                                                        value: downloadingProgress,
                                                      ),
                                                  ],
                                                ),
                                                if (customMetadataSnapshot.hasData)
                                                  Text(
                                                    p.basename(customMetadataSnapshot.data!.customMetadata!['originalFileName']!),
                                                  ),
                                              ],
                                            ));
                                      }
                                      if (widget.formMode == FormMode.viewing) {
                                        Container(
                                          padding: const EdgeInsets.all(8.0),
                                          // TODO: Position Remove Button On The Container Top Right
                                          child: Column(
                                            children: [
                                              IconButton(
                                                onPressed: () async {
                                                  try {
                                                    await widget.requestAttachementsStorageRef.delete();
                                                    setState(() {
                                                      attachments.removeAt(index);
                                                    });
                                                  } on FirebaseException catch (e) {
                                                    // Handle Exception
                                                  }
                                                },
                                                icon: const Icon(Icons.delete),
                                              ),
                                              Text(p.basename(customMetadataSnapshot.data!.customMetadata!['originalFileName']!)),
                                            ],
                                          ),
                                        );
                                      }
                                      return const Text('Nothing here!');
                                    },
                                  );
                                },
                              );
                            }),
                          if ((widget.formMode == FormMode.creating) || (widget.formMode == FormMode.editing))
                            // TODO: Use 'flutter_dropzone' To Implement Dropzone
                            Container(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                    child: const Text('Add attachment'),
                                    onPressed: () async {
                                      XFile? attachment = await openFile(confirmButtonText: "Add");
                                      if (attachment == null) {
                                        return;
                                      }
                                      setState(() {
                                        attachments.add(File(attachment.path));
                                      });
                                    })),
                        ],
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await widget.requestFirestoreRef.set(widget.request);
                },
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// TODO: Home would contain Text("Welcome To Your Isurance Cloud Console")
