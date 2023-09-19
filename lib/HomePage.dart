import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';
import 'TechClubs.dart';




class HomePage extends StatefulWidget {
  const HomePage({super.key});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<HomePage> createState() => _HomePageState();


//static void navigateToBookmarked(BuildContext context) {
//Navigator.push(context, MaterialPageRoute(builder: (context) => Bookmarked()));
//}

}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior = NavigationDestinationLabelBehavior.alwaysShow;
  TextEditingController firstnamecntrl = TextEditingController();
  TextEditingController lastnamecntrl  = TextEditingController();
  TextEditingController  emailcntrl  = TextEditingController();
  TextEditingController  passcntrl  = TextEditingController();
  TextEditingController  repasscntrl  = TextEditingController();
  List<dynamic> list =[];
  List<String> firstnamelist = [];
  List<String> dropdownItems = [];
  String firstValue = '',newdate = '', selectedValue = '';
  int months = 0;
  String sidebar_email = '';
  late SharedPreferences prefs;




  Future<void> _confirmLogout() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout Confirmation'),
          content: const Text('Are you sure you want to logout?'),
          actions: [

            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()),);
              },
              child: const Text('Yes'),
            ),

            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the AlertDialog
              },
              child: const Text('No'),
            ),

          ],
        );
      },
    );
  }

  Future<void> getpref() async
  {
    prefs = await SharedPreferences.getInstance();

    sidebar_email = prefs.getString("email")!;

    if(sidebar_email != null)
    {
      print(sidebar_email);
    }
  }

  @override

  void initState() {
    getpref();
    DateTime currentDate = DateTime.now();
    DateTime newDate = DateTime(currentDate.year,currentDate.month + months, currentDate.day);
    newdate = DateFormat('dd-MMMM-yyyy').format(newDate);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
          title: Text('Home Page', style: TextStyle(color: Colors.white),),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                color: Colors.indigo.shade900
            ),
          )
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(''),
              accountEmail: Text(''),
              currentAccountPicture: Container(
                width: 50, // Set the desired width
                height: 150, // Set the desired height
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/eventify_logo.png'),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.indigo.shade900
              ),
            ),
            ExpansionTile(title: Text('Clubs'),
              children: [
                ListTile(
                  title: Text('Technical Clubs'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TechClubs()));
                    // Handle item 1 tap
                  },
                ),
                ListTile(
                  title: Text('Cultural Clubs'),
                  onTap: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => ViewUsers()));
                    // Handle item 1 tap
                  },
                ),
                ListTile(
                  title: Text('Sports Clubs'),
                  onTap: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => ViewUsers()));
                    // Handle item 1 tap
                  },
                ),
              ],
            ),

            ListTile(
              title: Text('Hackathons'),
              onTap: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => RegisteredUsers()));
                // Handle item 1 tap
              },
            ),
            ListTile(
              title: Text('Events'),
              onTap: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => Charts()));
                // Handle item 1 tap
              },
            ),
            ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: _confirmLogout
            ),
            // Add more list items as needed
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIndex,
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });

          switch (index) {
            case 0:
              //Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterHackathon()));
              break;
            case 1:
              //Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterEvent()));
              break;
            default:
              break;
          }
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Register Hackathon',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Register Event',
          ),

        ],),


      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),
      ),


    );
  }
}
