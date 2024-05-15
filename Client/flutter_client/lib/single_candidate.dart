import 'package:flutter/material.dart';
import 'package:flutter_client/connection/handler.dart';
import 'package:flutter_client/login_page.dart';

class SingleCandidate extends StatefulWidget {
  final ServerConnection serverConnection;
  final String name;
  final int id;
  final String party;
  final String imageUrl;
  const SingleCandidate(
      {super.key,
      required this.name,
      required this.serverConnection,
      required this.id,
      required this.party,
      required this.imageUrl});

  @override
  State<SingleCandidate> createState() => _SingleCandidateState();
}

class _SingleCandidateState extends State<SingleCandidate> {
  bool hasVoted = false;
  late Color buttonColor;
  late Color textColor;

  @override
  Widget build(BuildContext context) {
    if (hasVoted) {
      buttonColor = Theme.of(context).primaryColor;
      textColor = Colors.white;
    } else {
      textColor = Theme.of(context).primaryColor;
      buttonColor = Colors.white;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.name,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              widget.party,
            ),
            const SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 150,
              backgroundImage: AssetImage(
                widget.imageUrl,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () async {
                  widget.serverConnection
                      .sendRequest("VOTE ${widget.id.toString()}");
                  setState(() {
                    hasVoted = true;
                  });
                  print(widget.serverConnection.getResponse());
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Successfully Voted!'),
                    ),
                  );
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (Route<dynamic> route) => false,
                    );
                  });
                },
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor,
                  backgroundColor: buttonColor,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                        color: Theme.of(context).primaryColor, width: 2),
                  ),
                ),
                child: Text(
                  "Cast Vote",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
