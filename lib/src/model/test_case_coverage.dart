class TestCaseCoverage {
  const TestCaseCoverage(this.filePath, this.allLine, this.hitLine);

  final String filePath;
  final int allLine;
  final int hitLine;

  String toOutput() {
    return '| $filePath | ${100 * hitLine ~/ allLine} |\n';
  }
}
