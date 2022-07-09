import 'dart:io';

import 'package:args/args.dart';
import 'package:quality_report/src/model/test_case_coverage.dart';

void qualityReport(List<String> arguments, ArgParser parser) {

  final argResults = parser.parse(arguments);

  final lcovFile = File(argResults['file']);
  final lcov = lcovFile.readAsStringSync();

  final list = lcov
      .split('end_of_record')
      .map((e) => e.split('\n')..removeWhere((element) => element.isEmpty))
      .toList()
    ..removeWhere((element) => element.isEmpty);

  final modelList = list.map((line) {
    final filePath =
        line.firstWhere((element) => element.startsWith('SF:')).split(':');
    final allLine =
        line.firstWhere((element) => element.startsWith('LF:')).split(':');
    final hitLine =
        line.firstWhere((element) => element.startsWith('LH:')).split(':');
    return TestCaseCoverage(
        filePath.last, int.parse(allLine.last), int.parse(hitLine.last));
  });

  final allMethodLine = modelList.fold<int>(
      0, (previousValue, element) => previousValue + element.allLine);
  final allHitLine = modelList.fold<int>(
      0, (previousValue, element) => previousValue + element.hitLine);

  final allLineCoverage = 100 * allHitLine ~/ allMethodLine;

  var output = '| File | Line Coverage(%) |\n| --- | --- |\n';
  for(final model in modelList) {
    output += model.toOutput();
  }
  output += '| All | $allLineCoverage |\n';
  stdout.write(output);
}
