class QuorumModel{
  final String surah;
  final int startVerse;
  final int endVerse;

  QuorumModel({
    required this.surah,
    required this.startVerse,
    required this.endVerse,
  });

  @override
  String toString() {
    return "$surah ($startVerse-$endVerse)";
  }
}