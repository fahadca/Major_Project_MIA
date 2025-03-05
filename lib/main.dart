import 'package:flutter/material.dart';
import 'services/fall_detection_service.dart';
import 'services/speech_to_text_service.dart';
import 'components/settings.dart';
import 'components/emergency_contacts.dart';
import 'components/object_identification.dart';
import 'components/emotion_identification.dart';

void main() {
  runApp(MIAApp());
}

class MIAApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FallDetectionService fallService = FallDetectionService();
  final SpeechToTextService speechService = SpeechToTextService();
  String fallStatus = "No Fall";

  @override
  void initState() {
    super.initState();
    fallService.startMonitoring(_updateFallStatus);
    speechService.startListening(_handleVoiceCommand);
  }

  void _updateFallStatus(String status) {
    setState(() {
      fallStatus = status;
    });
  }

  void _handleVoiceCommand(String command) {
    if (command.contains("settings")) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsScreen()));
    } else if (command.contains("emergency")) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => EmergencyContactsScreen()));
    } else if (command.contains("object")) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ObjectIdentificationScreen()));
    } else if (command.contains("emotion")) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => EmotionIdentificationScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MIA')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _handleVoiceCommand("settings"),
              child: Text("Settings"),
            ),
            ElevatedButton(
              onPressed: () => _handleVoiceCommand("emergency"),
              child: Text("Emergency Contacts"),
            ),
            ElevatedButton(
              onPressed: () => _handleVoiceCommand("object"),
              child: Text("Object Identification"),
            ),
            ElevatedButton(
              onPressed: () => _handleVoiceCommand("emotion"),
              child: Text("Emotion Identification"),
            ),
            SizedBox(height: 30),
            Text(
              "Fall Status: $fallStatus",
              style: TextStyle(
                fontSize: 20,
                color: fallStatus == "Fall Confirmed!" ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
