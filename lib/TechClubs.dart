import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';




class TechClubs extends StatefulWidget {
  const TechClubs({super.key});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<TechClubs> createState() => _TechClubsState();


//static void navigateToBookmarked(BuildContext context) {
//Navigator.push(context, MaterialPageRoute(builder: (context) => Bookmarked()));
//}

}

class _TechClubsState extends State<TechClubs> {
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
    print(MediaQuery.of(context).size.width);
    var arrColors=[ Colors.red,
      Colors.orange,
      Colors.grey,
      Colors.blue,
      Colors.pink,
      Colors.green,
      Colors.purpleAccent,
      Colors.brown
    ];
    return Scaffold(

      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Technical Clubs', style: TextStyle(color: Colors.white),),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                color: Colors.indigo.shade900
            ),
          )
      ),



      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, // Number of columns
          mainAxisSpacing: 5.0, // Spacing between rows
          crossAxisSpacing: 5.0, // Spacing between columns
          childAspectRatio: 3, // Aspect ratio of each grid item
        ),
        itemCount: 20, // Number of grid items
        itemBuilder: (BuildContext context, int index) {
          // Create your grid items here
          return Container(
            padding: EdgeInsets.only(top: 0, bottom: 5),
            height: 5,
            width: 5,
            color: Colors.blueAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Club $index',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Club Coordinator $index',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          );

        },
      ),


    );
  }
}
