class TestCaseCoverage {
  const TestCaseCoverage._(this.filePath, this.allLine, this.hitLine);

  factory TestCaseCoverage(List<String> lcovData) {
    final filePath =
        lcovData.firstWhere((element) => element.startsWith('SF:')).split(':');
    final allLine =
        lcovData.firstWhere((element) => element.startsWith('LF:')).split(':');
    final hitLine =
        lcovData.firstWhere((element) => element.startsWith('LH:')).split(':');
    return TestCaseCoverage._(
        filePath.last, int.parse(allLine.last), int.parse(hitLine.last));
  }

  final String filePath;
  final int allLine;
  final int hitLine;

  String toOutput() {
    final coverageAverage = allLine != 0 ? 100 * hitLine ~/ allLine : 0;

    return '| $filePath | $coverageAverage |\n';
  }
}
