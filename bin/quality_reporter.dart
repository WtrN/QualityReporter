import 'dart:io';

import 'package:args/args.dart';
import 'package:quality_report/metrics_report.dart';
import 'package:quality_report/quality_report.dart';
import 'package:quality_report/src/model/coverage_option.dart';

void main(List<String> arguments) {
  final parser = ArgParser();
  final metricsCommand = ArgParser();
  final coverageCommand = ArgParser();

  metricsCommand.addOption('file', abbr: 'f', defaultsTo: 'coverage/lcov.info');
  metricsCommand.addOption('target', abbr: 't', defaultsTo: 'lib/');

  coverageCommand.addOption(CoverageOption.file.name,
      abbr: CoverageOption.file.abbr, defaultsTo: 'metrics/metrics.json');
  coverageCommand.addOption(CoverageOption.target.name,
      abbr: CoverageOption.target.abbr, defaultsTo: 'lib/');
  coverageCommand.addFlag(CoverageOption.onlyOverAll.name, defaultsTo: false);

  parser.addCommand('metrics', metricsCommand);
  parser.addCommand('coverage', coverageCommand);

  final argResults = parser.parse(arguments);

  switch (argResults.command?.name) {
    case 'metrics':
      metricsReport(arguments, metricsCommand);
      break;
    case 'coverage':
      qualityReport(arguments, coverageCommand);
      break;
    default:
      exit(1);
  }
}
