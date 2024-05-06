import 'package:flutter/material.dart';

class CandidateCard extends StatelessWidget {
  final String name;
  final String party;
  final String imageUrl;
  const CandidateCard(
      {super.key,
      required this.name,
      required this.party,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image.asset(imageUrl),
          Column(
            children: [
              Text(name),
              Text(party),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
