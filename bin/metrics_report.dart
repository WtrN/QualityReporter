import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:args/args.dart';
import 'package:quarty_report/src/model/dart_metrics.dart';

void main(List<String> arguments) {
  final parser = ArgParser();
  parser.addOption('file', abbr: 'f', defaultsTo: 'coverage/lcov.info');
  parser.addOption('target', abbr: 't', defaultsTo: 'lib/');

  final argResults = parser.parse(arguments);

  final metricsFile = File(argResults['file']);
  final Map<String, dynamic> metricsJson =
      jsonDecode(metricsFile.readAsStringSync());

  final model = DartMetrics.fromJson(metricsJson);
  final maximumNesting = model.records.map((e) {
    final nestingLevelList = e.functions.values.map((e) => e.metrics
        .where(
            (element) => element.metricsId == MetricsId.MAXIMUM_NESTING_LEVEL)
        .toList());

    final list = nestingLevelList.expand((element) => element);

    return list.map((e) => e.value).toList();
  }).toList();

  final maximumNestingValue = maximumNesting.expand((i) => i).reduce(max);

  var output = '| Metrics | Result(%) |\n| --- | --- |\n';
  output += '| Maximum Nesting | $maximumNestingValue |\n';
  stdout.write(output);
}
