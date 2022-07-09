import 'dart:io';

import 'package:args/args.dart';
import 'package:quality_report/metrics_report.dart';
import 'package:quality_report/quality_report.dart';

void main(List<String> arguments) {
  final parser = ArgParser();
  final metricsCommand = ArgParser();
  final coverageCommand = ArgParser();

  metricsCommand.addOption('file', abbr: 'f', defaultsTo: 'coverage/lcov.info');
  metricsCommand.addOption('target', abbr: 't', defaultsTo: 'lib/');
  coverageCommand.addOption('file',
      abbr: 'f', defaultsTo: 'metrics/metrics.json');
  coverageCommand.addOption('target', abbr: 't', defaultsTo: 'lib/');

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
