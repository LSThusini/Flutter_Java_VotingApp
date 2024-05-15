import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_client/connection/handler.dart';
import 'package:flutter_client/single_candidate.dart';

class CandidateCard extends StatelessWidget {
  final String name;
  final ServerConnection serverConnection;
  final int id;
  final String party;
  final String imageUrl;

  const CandidateCard(
      {super.key,
      required this.name,
      required this.serverConnection,
      required this.id,
      required this.party,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Theme.of(context).primaryColor,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.black, width: 2.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              child: Image(
                image: AssetImage(imageUrl),
                height: 155,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          party,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SingleCandidate(
                            serverConnection: serverConnection,
                            name: name,
                            id: id,
                            party: party,
                            imageUrl: imageUrl,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30, left: 30),
                      child: Text(
                        "Vote",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
