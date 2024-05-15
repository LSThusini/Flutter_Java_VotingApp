import 'package:flutter/material.dart';
import 'package:flutter_client/candidates_list.dart';
import 'package:flutter_client/connection/handler.dart';
import 'package:flutter_client/results_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController textEditingController = TextEditingController();
  final ServerConnection _serverConnection = ServerConnection();

  @override
  void initState() {
    super.initState();
    _serverConnection.connectToServer();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    String idNumber = textEditingController.text;
    try {
      String response = await _serverConnection.sendRequest("LOGIN $idNumber");

      if (response.startsWith("VOTER")) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CandidatesList(serverConnection: _serverConnection),
          ),
        );
      } else if (response.startsWith("ADMIN")) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ResultsPage(serverConnection: _serverConnection),
          ),
        );
      } else if (response.startsWith("FAIL")) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login failed.User has Voted or Not Registered!!'),
          ),
        );
      }
      // Update the UI based on the response
      setState(() {
        // Use the response or logged status if needed
      });

      // if (_serverConnection.getLogged()) {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => const CandidatesList(),
      //     ),
      //   );
      // } else {
      //   // Show an error message if login failed
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text(
      //           'Login failed. Please check your ID number and try again.'),
      //     ),
      //   );
      // }
    } catch (error) {
      // Handle any errors that occurred during the request
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.black,
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(10),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "I-VOTE",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Welcome to I-Vote",
              style: TextStyle(
                color: Color.fromARGB(255, 6, 94, 165),
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: "Enter your ID Number: ",
                  prefixIcon: const Icon(Icons.account_box_outlined),
                  hintStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIconColor: Colors.black,
                  focusedBorder: border,
                  enabledBorder: border,
                ),
                keyboardType: const TextInputType.numberWithOptions(),
                controller: textEditingController,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () async {
                  await login();
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 6, 94, 165),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
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
