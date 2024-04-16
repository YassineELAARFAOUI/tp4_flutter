import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello World App',
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Hello WM'),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(text: 'Images'),
                Tab(text: 'Information'),
                Tab(text: 'Form'),
                Tab(text: 'List'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: 10, // Nombre d'images dans la grille
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Image.asset(
                        'assets/img1.jpeg',
                        fit: BoxFit.cover,
                      ),
                      width: 100.0,
                      height: 100.0,
                    );
                  },
                ),
              ),
              // Exemple d'un ExpansionTile
              Center(
                child: MyExpansionTile(
                  title: Text('See more'),
                  children: [
                    ListTile(
                      title: Text('Interface with 4 menus:\nThe first menu contains a list gallery of images.\nThe second menu contains Expansion Tile Cards.\nThe third menu opens a page with a form.\nThe fourth menu triggers closure via a dialog through a bottom sheet.'),
                    ),
                  ],
                ),
              ),
              Center(
                child: SubscriptionForm(),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Form Content',
                      style: TextStyle(fontSize: 24.0),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        // Ajoutez ici le code pour déclencher le dialogue via un bottom sheet
                      },
                      child: Text('Open Bottom Sheet Dialog'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget personnalisé pour ExpansionTile
class MyExpansionTile extends StatefulWidget {
  final Widget title;
  final List<Widget> children;

  MyExpansionTile({required this.title, required this.children});

  @override
  _MyExpansionTileState createState() => _MyExpansionTileState();
}

class _MyExpansionTileState extends State<MyExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: widget.title,
          onTap: () {
            if (mounted) { // Vérifier si le widget est monté avant de mettre à jour l'état
              setState(() {
                _isExpanded = !_isExpanded;
              });
            }
          },
        ),
        if (_isExpanded) ...widget.children,
      ],
    );
  }
}

class SubscriptionForm extends StatefulWidget {
  @override
  _SubscriptionFormState createState() => _SubscriptionFormState();
}

class _SubscriptionFormState extends State<SubscriptionForm> {
  // Global key to uniquely identify the form
  final _formKey = GlobalKey<FormState>();

  // Variables to hold the entered name and email
  String _name = '';
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscription Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Assigning the global key to the form
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Text form field for entering name
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value?.isEmpty ?? true) { // Vérifie si value est null ou vide
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _name = value ?? ''; // Si value est null, assigne une chaîne vide
                  });
                },
              ),
              // Text form field for entering email
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value?.isEmpty ?? true) { // Vérifie si value est null ou vide
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _email = value ?? ''; // Si value est null, assigne une chaîne vide
                  });
                },
              ),
              // Button to submit the form
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate form before submission
                    if (_formKey.currentState!.validate()) {
                      // Save form data and submit
                      _formKey.currentState!.save();
                      _submitForm();
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
              // Displaying entered name and email below the form
              Text('Name: $_name'),
              Text('Email: $_email'),
            ],
          ),
        ),
      ),
    );
  }

  // Function to handle form submission
  void _submitForm() {
    // Simulate submitting the form by printing the entered data
    print('Form submitted:');
    print('Name: $_name');
    print('Email: $_email');
  }
}
