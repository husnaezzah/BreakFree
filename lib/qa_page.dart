import 'package:flutter/material.dart';

class QAPage extends StatefulWidget {
  @override
  _QAPageState createState() => _QAPageState();
}

class _QAPageState extends State<QAPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  // Simulate bot responses based on simple keywords or questions
  void _getBotResponse(String message) {
    String response;

 if (message.toLowerCase().contains("hello")|| message.toLowerCase().contains("hi")) {
      response = "Hello! How can I assist you today?";

} else if (message.toLowerCase().contains("domestic") || message.toLowerCase().contains("violence")) {
  response = "Domestic violence is a serious issue, and BreakFree is here to provide support, resources, and information.";

} else if (message.toLowerCase().contains("sign") || message.toLowerCase().contains("symptom")) {
    response = "Signs of domestic violence can include controlling behavior, isolation from family and friends, verbal threats, physical harm, and emotional manipulation.";

} else if (message.toLowerCase().contains("what") || message.toLowerCase().contains("do")) {
  response = "Contact us and lodge you report now through our Capture feature.";

} else if (message.toLowerCase().contains("resources")) {
    response = "Our app provides local resources including nearby shelters, hospitals, and hotlines. You can find help close by anytime.";

} else if (message.toLowerCase().contains("emergency") || message.toLowerCase().contains("help")) {
    response = "Press the 'SOS' button to alert authorities.";

} else if (message.toLowerCase().contains("confidentiality")) {
    response = "Your privacy and safety are our top priorities. We offer data security to keep your information secure.";

} else if (message.toLowerCase().contains("trauma")) {
    response = "Our app is designed to be sensitive to trauma, avoiding potentially triggering content while offering support resources.";

} else if (message.toLowerCase().contains("stigma")) {
    response = "We understand the fear of stigma. Our app offers anonymous support, so you can access help privately and securely.";

} else {
    response = "I'm here to help, but I didn't quite understand that. Could you please rephrase?";
}


    // Add bot response to the messages list
    setState(() {
      _messages.add({"bot": response});
    });
  }

  void _sendMessage(String message) {
    setState(() {
      _messages.add({"user": message});
    });
    _controller.clear();
    _getBotResponse(message); // Generate bot response
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BreakFree Chatbot",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold
          )),
        backgroundColor: Colors.purple[100],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Align(
                    alignment: message.containsKey("user")
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: message.containsKey("user")
                            ? Colors.grey[100]
                            : Colors.purple[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        message.containsKey("user")
                            ? message["user"]!
                            : message["bot"]!,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Ask a question...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _sendMessage(_controller.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
