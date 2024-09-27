import 'package:flutter/material.dart';
import 'package:myapp/pages/chat.dart';
import 'package:myapp/pages/settings.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Darsistant',
            theme: themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
            home: HomePage(),
          );
        },
      ),
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode = false;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Darsistant'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
          ),
        ],
      ),
      body: ResponsiveLayout(),
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Row(
            children: [
              NavigationSidebar(),
              Expanded(child: HomeContent()),
            ],
          );
        } else {
          return Scaffold(
            body: HomeContent(),
            bottomNavigationBar: NavigationBottomBar(),
          );
        }
      },
    );
  }
}

class NavigationSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: 0,
      onDestinationSelected: (int index) {

        switch (index) {
          case 0:
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            break;
          case 1:
            Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()));
            break;
          case 2:
            Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
            break;
        }
        
      },
      labelType: NavigationRailLabelType.all,
      destinations: [
        NavigationRailDestination(
          icon: Icon(Icons.home),
          label: Text('Home'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.chat),
          label: Text('Chat'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.settings),
          label: Text('Settings'),
        ),
      ],
    );
  }
}

class NavigationBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (int index) {
        // Handle navigation

        switch (index) {
          case 0:
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            break;
          case 1:
            Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()));
            break;
          case 2:
            Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
            break;
        }



      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          QuickChatSection(),
          QuickSettingsSection(),
          OptionsCard(),
        ],
      ),
    );
  }
}

class QuickChatSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Quick Chat'),
        onTap: () {
          // Navigate to chat page
        },
      ),
    );
  }
}

class QuickSettingsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Quick Settings'),
        onTap: () {
          // Navigate to settings page
        },
      ),
    );
  }
}

class OptionsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('Ask for help with your app'),
            onTap: () {
              // Handle action
            },
          ),
          ListTile(
            title: Text('Quick correct Dart errors'),
            onTap: () {
              // Handle action
            },
          ),
        ],
      ),
    );
  }
}




























// import 'package:flutter/material.dart';
// import 'package:googleapis/dialogflow/v2.dart';
// import 'package:googleapis_auth/auth_io.dart';
// import 'package:flutter/services.dart';


// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.brown,
//       ),
//       home: ChatMessages(),
//     );
//   }
// }

// class ChatMessages extends StatefulWidget {
//   const ChatMessages({super.key});

//   @override
//   _ChatMessagesState createState() => _ChatMessagesState();
// }

// class _ChatMessagesState extends State<ChatMessages>
//     with TickerProviderStateMixin {
//   final List<ChatMessage> _messages = List<ChatMessage>();
//   bool _isComposing = false;

//   final TextEditingController _controllerText = TextEditingController();

//   late DialogflowApi _dialog;

//   @override
//   void initState() {
//     super.initState();
//     _initChatbot();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: const Text("ChatBot GDG")),
//         body: Column(
//           children: <Widget>[
//             _buildList(),
//             Divider(height: 8.0, color: Theme.of(context).colorScheme.secondary),
//             _buildComposer()
//           ],
//         ));
//   }

//   _buildList() {
//     return Flexible(
//       child: ListView.builder(
//           padding: const EdgeInsets.all(8.0),
//           reverse: true,
//           itemCount: _messages.length,
//           itemBuilder: (_, index) {
//             return Container(child: ChatMessageListItem(_messages[index]));
//           }),
//     );
//   }

//   _buildComposer() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Row(
//         children: <Widget>[
//           Flexible(
//             child: TextField(
//               controller: _controllerText,
//               onChanged: (value) {
//                 setState(() {
//                   _isComposing = _controllerText.text.isNotEmpty;
//                 });
//               },
//               onSubmitted: _handleSubmit,
//               decoration: const InputDecoration.collapsed(hintText: "Parle moi"),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.send),
//             onPressed:
//             _isComposing ? () => _handleSubmit(_controllerText.text) : null,
//           ),
//         ],
//       ),
//     );
//   }

//   _handleSubmit(String value) {
//     _controllerText.clear();
//     _addMessage(
//       text: value,
//       name: "John Doe",
//       initials: "DJ",
//     );

//     _requestChatBot(value);
//   }

//   _requestChatBot(String text) async {
//     var dialogSessionId = "projects/chatbot-gdg/agent/sessions/ChatbotGDG";

//     Map data = {
//       "queryInput": {
//         "text": {
//           "text": text,
//           "languageCode": "fr",
//         }
//       }
//     };

//     var request = GoogleCloudDialogflowV2DetectIntentRequest.fromJson(data);

//     var resp = await _dialog.projects.agent.sessions
//         .detectIntent(request, dialogSessionId);
//     var result = resp.queryResult;
//     _addMessage(
//         name: "Chat Bot",
//         initials: "CB",
//         bot: true,
//         text: result.fulfillmentText);
//   }

//   void _initChatbot() async {
//     String configString = await rootBundle.loadString('config/dialogflow.json');
//     String dialogFlowConfig = configString;

//     var credentials = ServiceAccountCredentials.fromJson(dialogFlowConfig);

//     const SCOPES = [DialogflowApi.CloudPlatformScope];

//     var httpClient = await clientViaServiceAccount(credentials, SCOPES);
//     _dialog = DialogflowApi(httpClient);
//   }

//   void _addMessage(
//       {String name, String initials, bool bot = false, String text}) {
//     var animationController = AnimationController(
//       duration: const Duration(milliseconds: 700),
//       vsync: this,
//     );

//     var message = ChatMessage(
//         name: name,
//         text: text,
//         initials: initials,
//         bot: bot,
//         animationController: animationController);

//     setState(() {
//       _messages.insert(0, message);
//     });

//     animationController.forward();
//   }
// }

// class ChatMessage {
//   final String name;
//   final String initials;
//   final String text;
//   final bool bot;

//   AnimationController animationController;

//   ChatMessage(
//       {this.name,
//         this.initials,
//         this.text,
//         this.bot = false,
//         this.animationController});
// }

// class ChatMessageListItem extends StatelessWidget {
//   final ChatMessage chatMessage;

//   const ChatMessageListItem(this.chatMessage, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizeTransition(
//       sizeFactor: CurvedAnimation(
//           parent: chatMessage.animationController, curve: Curves.easeOut),
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Row(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(left: 16.0),
//               child: CircleAvatar(
//                 backgroundColor: chatMessage.bot
//                     ? Theme.of(context).colorScheme.secondary
//                     : Theme.of(context).highlightColor,
//                 child: Text(chatMessage.initials ?? "JD"),
//               ),
//             ),
//             Flexible(
//               child: Container(
//                 margin: const EdgeInsets.only(left: 16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(chatMessage.name ?? "Jane Doe",
//                         style: Theme.of(context).textTheme.subtitle1),
//                     Container(
//                       margin: const EdgeInsets.only(top: 5.0),
//                       child: Text(chatMessage.text)
//                     )
//                   ],
//                 ))
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }









































// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
