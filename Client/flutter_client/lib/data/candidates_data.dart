import 'dart:io';

import 'package:flutter_client/data/CandidateModel.dart';

List<CandidateModel> readCandidatesFromFile(String filePath) {
  List<CandidateModel> candidates = [];

  // Open the file
  File file = File(filePath);

  // Read the contents of the file
  List<String> lines = file.readAsLinesSync();

  // Iterate over each line
  for (String line in lines) {
    // Split the line into fields using '#' as the delimiter
    List<String> data = line.split('#');

    // Extract individual pieces of information
    int index = int.parse(data[0]);
    String lastName = data[1];
    String firstName = data[2];
    String partyName = data[3];
    String partyAbbreviation = data[4];
    String candidateImage = data[5];
    String logoImage = data[6];

    // Create a Candidate object and add it to the list
    CandidateModel candidate = CandidateModel(
      index: index,
      lastName: lastName,
      firstName: firstName,
      partyName: partyName,
      partyAbbreviation: partyAbbreviation,
      candidateImage: candidateImage,
      logoImage: logoImage,
    );
    candidates.add(candidate);
  }

  return candidates;
}
