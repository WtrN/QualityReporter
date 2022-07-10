import 'dart:io';

import 'package:args/args.dart';
import 'package:quality_report/src/model/coverage_option.dart';
import 'package:quality_report/src/model/test_case_coverage.dart';

void qualityReport(List<String> arguments, ArgParser parser) {
  final argResults = parser.parse(arguments);

  final targetPath = argResults[CoverageOption.target.name];

  final lcovFile = File(argResults[CoverageOption.file.name]);
  final lcov = lcovFile.readAsStringSync();

  final list = lcov
      .split('end_of_record')
      .map((e) => e.split('\n')..removeWhere((element) => element.isEmpty))
      .toList()
    ..removeWhere((element) => element.isEmpty);

  final modelList = list
      .map((line) => TestCaseCoverage(line))
      .where((e) => e.filePath.startsWith(targetPath))
      .toList();

  final allMethodLine = modelList.fold<int>(
      0, (previousValue, element) => previousValue + element.allLine);
  final allHitLine = modelList.fold<int>(
      0, (previousValue, element) => previousValue + element.hitLine);

  final allLineCoverageAverage =
      allMethodLine != 0 ? 100 * allHitLine ~/ allMethodLine : 0;

  var output = '| File | Line Coverage(%) |\n| --- | --- |\n';
  for (final model in modelList) {
    output += model.toOutput();
  }
  output += '| All | $allLineCoverageAverage |\n';
  stdout.write(output);
}
