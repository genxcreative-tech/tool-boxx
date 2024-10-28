import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hugeicons/hugeicons.dart';
import 'edit_username_screen.dart'; // Import the new screen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<IconData> _icons = [
    HugeIcons.strokeRoundedText,
    HugeIcons.strokeRoundedShuffle,
    HugeIcons.strokeRoundedTextAlignCenter,
    HugeIcons.strokeRoundedMailEdit01,
    HugeIcons.strokeRoundedCoinsDollar,
    HugeIcons.strokeRoundedWeightScale,
    HugeIcons.strokeRoundedMaximize01,
    HugeIcons.strokeRoundedAnalytics01,
  ];
  
  final List<String> _titles = [
    'Text Multiplier',
    'Random Text Generator',
    'Text Formatter',
    'Email Extractor',
    'Currency Converter',
    'Weight Converter',
    'Size Converter',
    'Text Analyzer',
  ];

  // For primitive types
  var box = Hive.box('main');
  var value = "";

  void _setUsername() {
    if (box.isNotEmpty) {
      var dbox = box.get('username');
      setState(() {
        value = dbox ?? "user!"; // Set to "user!" if dbox is null
      });
    } else {
      setState(() {
        value = "user!";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _setUsername();
  }

  void _navigateToEditUsername() async {
    final TextEditingController usernameController = TextEditingController(text: value);
    // Navigate to the Edit Username screen
    final newUsername = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditUsernameScreen(usernameController: usernameController),
      ),
    );

    if (newUsername != null && newUsername is String) {
      setState(() {
        value = newUsername; // Update the displayed username
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dheight = MediaQuery.of(context).size.height;
    final dwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          "Tool Boxx",
          style: TextStyle(color: Colors.pink),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const HugeIcon(
              icon: HugeIcons.strokeRoundedSetting06,
              color: Colors.black,
              size: 26,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Text(
                  "👋 Hey $value! ", // Show the username
                  style: TextStyle(fontSize: 28, color: Colors.grey.shade800),
                ),
                const SizedBox(width: 5),
                InkWell(
                  enableFeedback: true,
                  onTap: _navigateToEditUsername, // Navigate to the edit screen when tapped
                  child: Container(
                    height: 25,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        "edit username",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Here are all the tools you need for your daily tasks.",
              style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "🛠️ Basic Tools: ",
              style: TextStyle(fontSize: 28, color: Colors.grey.shade800),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: dheight / 2,
              width: dwidth,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 35,
                  crossAxisSpacing: 15,
                  mainAxisExtent: 100,
                ),
                itemCount: _icons.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        height: 80,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: HugeIcon(icon: _icons[index], color: Colors.black),
                        ),
                      ),
                      Text(
                        _titles[index],
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
