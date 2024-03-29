import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/speech': (context) => RecordAudio(),
        '/text': (context) => TextPage(),
        '/image': (context) => ImageGenerator(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Machine Translation'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/siplab.png',
                width: 420,
                height: 120,
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/speech',
                      arguments: 'Speech to Text');
                },
                child: CardWidget(
                  image: 'assets/images/micro.png',
                  text: 'Speech to Text',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/text',
                      arguments: 'Text to Text');
                },
                child: CardWidget(
                  image: 'assets/images/text.png',
                  text: 'Text to Text',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/image',
                      arguments: 'Text to Image');
                },
                child: CardWidget(
                  image: 'assets/images/image.png',
                  text: 'Text to Image',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final String image;
  final String text;

  const CardWidget({Key? key, required this.image, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.2,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            image,
            width: 80,
            height: 80,
          ),
          SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}

// class speech extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Speech to Speech'),
//         backgroundColor: Colors.white,
//         iconTheme: IconThemeData(color: Colors.black),
//       ),
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 16),
//             Row(
//               children: [
//                 // Dropdown 1
//                 Expanded(
//                   child: DropdownButton<String>(
//                     items: ['English', 'Spanish', 'French']
//                         .map((String value) => DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             ))
//                         .toList(),
//                     onChanged: (String? value) {
//                       // Handle dropdown change
//                     },
//                     hint: Text('Select Language'),
//                   ),
//                 ),
//                 // Icon
//                 Icon(Icons.swap_horiz, size: 36),
//                 // Dropdown 2
//                 Expanded(
//                   child: DropdownButton<String>(
//                     items: ['English', 'Spanish', 'French']
//                         .map((String value) => DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             ))
//                         .toList(),
//                     onChanged: (String? value) {
//                       // Handle dropdown change
//                     },
//                     hint: Text('Select Language'),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             // Input Boxes
//             Container(
//               width: MediaQuery.of(context).size.width * 0.8,
//               height: MediaQuery.of(context).size.height * 0.4,
//               child: Column(
//                 children: [
//                   TextField(
//                     maxLines: null,
//                     keyboardType: TextInputType.multiline,
//                     decoration: InputDecoration(
//                       labelText: 'Translated Text will Appear Here',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   TextField(
//                     maxLines: null,
//                     keyboardType: TextInputType.multiline,
//                     decoration: InputDecoration(
//                       labelText: 'Your Text Appers Here',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SpeechTranslation extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Speech Translation'),
//         backgroundColor: Colors.white,
//         iconTheme: IconThemeData(color: Colors.black),
//       ),
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 16),
//             Row(
//               children: [
//                 // Dropdown 1
//                 Expanded(
//                   child: DropdownButton<String>(
//                     items: ['English', 'Spanish', 'French', 'German', 'Chinese']
//                         .map((String value) => DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             ))
//                         .toList(),
//                     onChanged: (String? value) {
//                       // Handle source language change
//                     },
//                     hint: Text('Select Source Language'),
//                   ),
//                 ),
//                 // Icon
//                 Icon(Icons.swap_horiz, size: 36),
//                 // Dropdown 2
//                 Expanded(
//                   child: DropdownButton<String>(
//                     items: ['English', 'Spanish', 'French', 'German', 'Chinese']
//                         .map((String value) => DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             ))
//                         .toList(),
//                     onChanged: (String? value) {
//                       // Handle target language change
//                     },
//                     hint: Text('Select Target Language'),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             // Input Boxes
//             Container(
//               width: MediaQuery.of(context).size.width * 0.8,
//               height: MediaQuery.of(context).size.height * 0.4,
//               child: Column(
//                 children: [
//                   TextField(
//                     maxLines: 6,
//                     keyboardType: TextInputType.multiline,
//                     decoration: InputDecoration(
//                       labelText: 'Translated Text',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   TextField(
//                     maxLines: 6,
//                     keyboardType: TextInputType.multiline,
//                     decoration: InputDecoration(
//                       labelText: 'Original Text',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),
//             // Record Button
//             RecordButton(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class RecordButton extends StatefulWidget {
//   @override
//   _RecordButtonState createState() => _RecordButtonState();
// }

// class _RecordButtonState extends State<RecordButton> {
//   bool isRecording = false;
//   AudioPlayer audioPlayer = AudioPlayer();
//   String audioPath = '';

//   Future<void> _startRecording() async {
//     Directory appDocDir = await getApplicationDocumentsDirectory();
//     String appDocPath = appDocDir.path;
//     audioPath = '$appDocPath/recorded_audio.wav';

//     if (await AudioRecorder.hasPermissions) {
//       await AudioRecorder.start(
//         path: audioPath,
//         audioOutputFormat: AudioOutputFormat.AAC_ADTS,
//       );

//       setState(() {
//         isRecording = true;
//       });
//     } else {
//       // Handle no permission
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Permission Required'),
//             content:
//                 Text('Please grant microphone permission to record audio.'),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   Future<void> _stopRecording() async {
//     if (isRecording) {
//       Recording recording = await AudioRecorder.stop();
//       print('Recording saved to: ${recording.path}');

//       setState(() {
//         isRecording = false;
//       });

//       // Play the recorded audio (optional)
//       await audioPlayer.play(recording.path, isLocal: true);
//     }
//   }

//   @override
//   void dispose() {
//     audioPlayer.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: (_) => _startRecording(),
//       onTapUp: (_) => _stopRecording(),
//       child: Container(
//         padding: EdgeInsets.all(10),
//         margin: EdgeInsets.only(bottom: 16),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: isRecording ? Colors.red : Colors.blue,
//         ),
//         child: Icon(
//           Icons.mic,
//           color: Colors.white,
//           size: 36,
//         ),
//       ),
//     );
//   }
// }

// class RecordAudio extends StatefulWidget {
//   @override
//   _RecordAudioState createState() => _RecordAudioState();
// }

// class _RecordAudioState extends State<RecordAudio> {
//   final _recorder = FlutterSoundRecorder();
//   bool _isRecording = false;
//   late final String _recordedFilePath;

//   @override
//   void initState() {
//     super.initState();
//     _initRecorder();
//   }

//   Future<void> _initRecorder() async {
//     final status = await Permission.microphone.request();
//     if (status == PermissionStatus.granted) {
//       await _recorder.openRecorder();
//       final appDir = await getApplicationDocumentsDirectory();
//       _recordedFilePath = '${appDir.path}/recorded_audio.wav';
//     }
//   }

//   Future<void> _startRecording() async {
//     if (!_isRecording) {
//       await _recorder.startRecorder(
//         toFile: _recordedFilePath,
//         codec: Codec.pcm16WAV,
//       );
//       setState(() {
//         _isRecording = true;
//       });
//     }
//   }

//   Future<void> _stopRecording() async {
//     if (_isRecording) {
//       await _recorder.stopRecorder();
//       setState(() {
//         _isRecording = false;
//       });
//     }
//   }

//   Future<void> _playRecording() async {
//     final file = File(_recordedFilePath);
//     final player = AudioPlayer();

//     if (await file.exists()) {
//       final bytes = await file.readAsBytes();
//       final source = BytesSource(bytes);
//       await player.play(source);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Record Audio'),
//       ),
//       body: Center(
//         child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
//   ElevatedButton(
//     onPressed: _isRecording ? _stopRecording : _startRecording,
//     child: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
//   ),
//   SizedBox(height: 20),
//   ElevatedButton(
//     onPressed: _playRecording,
//     child: Text('Play Recording'),
//   ),
// ],
//         ),
//       ),
//     );
//   }
// }

class RecordAudio extends StatefulWidget {
  @override
  _RecordAudioState createState() => _RecordAudioState();
}

class _RecordAudioState extends State<RecordAudio> {
  String selectedLanguage1 = 'English'; // Initial value
  String selectedLanguage2 = 'Lambani'; // Initial value
  final _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  late final String _recordedFilePath;

  void swapSelectedLanguages() {
    setState(() {
      String temp = selectedLanguage1;
      selectedLanguage1 = selectedLanguage2;
      selectedLanguage2 = temp;
    });
  }

  @override
  void initState() {
    super.initState();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    final status = await Permission.microphone.request();
    if (status == PermissionStatus.granted) {
      await _recorder.openRecorder();
      final appDir = await getApplicationDocumentsDirectory();
      _recordedFilePath = '${appDir.path}/recorded_audio.wav';
    }
  }

  Future<void> _startRecording() async {
    if (!_isRecording) {
      await _recorder.startRecorder(
        toFile: _recordedFilePath,
        codec: Codec.pcm16WAV,
      );
      setState(() {
        _isRecording = true;
      });
    }
  }

  Future<void> _stopRecording() async {
    if (_isRecording) {
      await _recorder.stopRecorder();
      setState(() {
        _isRecording = false;
      });
    }
  }

  Future<void> _playRecording() async {
    final file = File(_recordedFilePath);
    final player = AudioPlayer();

    if (await file.exists()) {
      final bytes = await file.readAsBytes();
      final source = BytesSource(bytes);
      await player.play(source);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech to Text'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Language Dropdowns
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: selectedLanguage1,
                      items: ['English', 'Lambani', 'Soliga', 'Kui', 'Mundri']
                          .map((String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedLanguage1 = value!;
                        });
                      },
                      hint: Text('Select Language 1'),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.swap_horiz, size: 36),
                    onPressed: swapSelectedLanguages,
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      value: selectedLanguage2,
                      items: ['Lambani', 'English', 'Soliga', 'Kui', 'Mundri']
                          .map((String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedLanguage2 = value!;
                        });
                      },
                      hint: Text('Select Language 2'),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),
              // Input Boxes
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  children: [
                    TextField(
                      maxLines: 4,
                      readOnly: true,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: 'Translated Text Appears here',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: 'Your Text Appears Here',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 2),
              // Translate Button
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed:
                          _isRecording ? _stopRecording : _startRecording,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            // Change background color to red when recording, green otherwise
                            if (_isRecording) {
                              return Colors.red;
                            } else {
                              return Colors.green;
                            }
                          },
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _isRecording ? Icons.stop : Icons.mic,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text(
                            _isRecording ? 'Stop Recording' : 'Start Recording',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _playRecording,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Play Recording',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 20),
                    // // Widget to display signal of the audio recording
                    // Container(
                    //   width: double.infinity,
                    //   height: 50, // Adjust height as needed
                    //   color: Colors.grey[300], // Placeholder color
                    //   // Add your widget to display the signal here
                    // ),
                  ],
                ),
              )

              // Other UI elements can be added here
            ],
          ),
        ),
      ),
    );
  }
}

class TextPage extends StatefulWidget {
  @override
  _TextPageState createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  String selectedLanguage1 = 'English';
  String selectedLanguage2 = 'Lambani';
  // Future<void> sendDataToServer(String text1, String text2) async {
  //   final url = Uri.parse('https://your-server-url.com/api/endpoint');
  //   final body = {
  //     'text1': text1,
  //     'text2': text2,
  //   };

  //   try {
  //     final response = await http.post(url, body: body);

  //     if (response.statusCode == 200) {
  //       // Data sent successfully
  //       print('Data sent successfully');
  //     } else {
  //       // Error sending data
  //       print('Error sending data: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     // Error occurred
  //     print('Error: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text to Text'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Row(
                children: [
                  // Dropdown 1
                  Expanded(
                    child: DropdownButton<String>(
                      value: selectedLanguage1,
                      items: ['English', 'Lambani', 'Soliga', 'Kui', 'Mundri']
                          .map((String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedLanguage1 = value!;
                        });
                      },
                      hint: Text('Select Language 1'),
                    ),
                  ),
                  // Icon
                  IconButton(
                    icon: Icon(Icons.swap_horiz, size: 36),
                    onPressed: () {
                      // Handle swap button click
                      setState(() {
                        final temp = selectedLanguage1;
                        selectedLanguage1 = selectedLanguage2;
                        selectedLanguage2 = temp;
                      });
                    },
                  ),
                  // Dropdown 2
                  Expanded(
                    child: DropdownButton<String>(
                      value: selectedLanguage2,
                      items: ['Lambani', 'English', 'Soliga', 'Kui', 'Mundri']
                          .map((String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedLanguage2 = value!;
                        });
                      },
                      hint: Text('Select Language 2'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
// Input Boxes
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center the content vertically
                  children: [
                    Center(
                      // Center the content horizontally
                      child: TextField(
                        maxLines: 4,
                        readOnly: true,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: 'Translated Text Appears here',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Center(
                      // Center the content horizontally
                      child: TextField(
                        maxLines: 4,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: 'Your Text Appears Here',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 1),
              // Translate Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final text1 = selectedLanguage1;

                    final text2 = selectedLanguage2;

                    // sendDataToServer(text1, text2);
                    // Handle translate button click
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: Text(
                    'Translate',
                    style: TextStyle(
                      color: Colors.white, // Text color
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageGenerator extends StatefulWidget {
  @override
  _ImageGeneratorState createState() => _ImageGeneratorState();
}

class _ImageGeneratorState extends State<ImageGenerator> {
  final TextEditingController promptController = TextEditingController();
  String imageUrl = '';
  final apiUrl = Uri.parse('https://f103-103-232-241-226.ngrok-free.app/process_text/');

  void getImage() async {
    // Append a unique query parameter to the URL to force fetching a new image
    final newImageUrl = 'https://f103-103-232-241-226.ngrok-free.app/generated_image?timestamp=${DateTime.now().millisecondsSinceEpoch}';
    
    setState(() {
      imageUrl = newImageUrl;
    });
  }  

  Future<void> sendTextToServer(String text) async {
    try {
      var jsonData = {'text': text};
      var response = await http.post(
        apiUrl,
        body: jsonEncode(jsonData),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        print('Text sent successfully!');
        print('Response: ${response.body}');
        // You can handle the response here
        getImage(); // Call getImage() after successful response
      } else {
        print('Failed to send text. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending text: $error');
    }
  }

  void generateImage(BuildContext context) {
    String promptText = promptController.text;
    // Call sendTextToServer to send the prompt text to the server
    sendTextToServer(promptText);
    // Add your logic to handle the response and update the UI accordingly
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Generator'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display Generated Image
              Container(
                width: MediaQuery.of(context).size.width,
                height: 400, // Adjust the height based on your needs
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Placeholder color
                  borderRadius: BorderRadius.circular(10),
                ),
                // You can replace the child with the actual generated image widget
                child: Center(
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          width: 400, // Set the width as per your requirement
                          height: 400, // Set the height as per your requirement
                        )
                      : Container(), // Placeholder widget when image URL is empty
                ),
              ),

              SizedBox(height: 16),
              // Text Field for Prompt
              TextField(
                controller: promptController,
                maxLines: 2,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Enter Prompt',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              // Generate Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Call generateImage function when the button is pressed
                    generateImage(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Generate',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
