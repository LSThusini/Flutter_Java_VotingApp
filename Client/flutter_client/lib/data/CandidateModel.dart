class CandidateModel {
  final int index;
  final String lastName;
  final String firstName;
  final String partyName;
  final String partyAbbreviation;
  final String candidateImage;
  final String logoImage;

  CandidateModel({
    required this.index,
    required this.lastName,
    required this.firstName,
    required this.partyName,
    required this.partyAbbreviation,
    required this.candidateImage,
    required this.logoImage,
  });

  @override
  String toString() {
    return 'Index: $index, Last Name: $lastName, First Name: $firstName, Party: $partyName, Abbreviation: $partyAbbreviation, Candidate Image: $candidateImage, Logo Image: $logoImage';
  }
}
