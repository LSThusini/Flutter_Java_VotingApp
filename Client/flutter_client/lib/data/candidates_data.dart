import 'package:flutter/services.dart';
import 'package:flutter_client/data/CandidateModel.dart';

Future<String> loadAsset(String path) async {
  return await rootBundle.loadString(path);
}

List<CandidateModel> parseCandidates(String data) {
  List<CandidateModel> candidates = [];

  // Split the data into lines
  List<String> lines = data.split('\n');

  // Iterate over each line
  for (String line in lines) {
    // Split the line into fields using '#' as the delimiter
    List<String> fields = line.split('#');

    // Ensure that the line has the correct number of fields
    if (fields.length != 7) {
      continue; // Skip this line and proceed to the next one
    }

    try {
      // Extract individual pieces of information
      int index = int.parse(fields[0]);
      String lastName = fields[1];
      String firstName = fields[2];
      String partyName = fields[3];
      String partyAbbreviation = fields[4];
      String candidateImage = fields[5];
      String logoImage = fields[6];

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
    } catch (e) {
      print('Error parsing line: $line - $e');
    }
  }

  return candidates;
}

Future<List<CandidateModel>> readCandidatesFromFile(String filePath) async {
  String data = await loadAsset(filePath);
  List<CandidateModel> candidatesList = parseCandidates(data);
  return candidatesList;
}
