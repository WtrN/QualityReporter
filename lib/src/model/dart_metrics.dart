// ignore_for_file: constant_identifier_names

import 'dart:convert';

DartMetrics dartMetricsFromJson(String str) =>
    DartMetrics.fromJson(json.decode(str));

String dartMetricsToJson(DartMetrics data) => json.encode(data.toJson());

class DartMetrics {
  DartMetrics({
    required this.formatVersion,
    required this.timestamp,
    required this.records,
    required this.summary,
  });

  int formatVersion;
  DateTime timestamp;
  List<Record> records;
  List<Summary> summary;

  factory DartMetrics.fromJson(Map<String, dynamic> json) => DartMetrics(
        formatVersion: json["formatVersion"],
        timestamp: DateTime.parse(json["timestamp"]),
        records:
            List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
        summary:
            List<Summary>.from(json["summary"].map((x) => Summary.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "formatVersion": formatVersion,
        "timestamp": timestamp.toIso8601String(),
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
        "summary": List<dynamic>.from(summary.map((x) => x.toJson())),
      };
}

class Record {
  Record({
    required this.path,
    required this.fileMetrics,
    required this.classes,
    required this.functions,
    required this.issues,
    required this.antiPatternCases,
  });

  String path;
  List<Metric> fileMetrics;
  Map<String, Class> classes;
  Map<String, Class> functions;
  List<Issue> issues;
  List<Issue> antiPatternCases;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        path: json["path"],
        fileMetrics: List<Metric>.from(
            json["fileMetrics"].map((x) => Metric.fromJson(x))),
        classes: Map.from(json["classes"])
            .map((k, v) => MapEntry<String, Class>(k, Class.fromJson(v))),
        functions: Map.from(json["functions"])
            .map((k, v) => MapEntry<String, Class>(k, Class.fromJson(v))),
        issues: List<Issue>.from(json["issues"].map((x) => x)),
        antiPatternCases:
            List<Issue>.from(json["antiPatternCases"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "path": path,
        "fileMetrics": List<dynamic>.from(fileMetrics.map((x) => x.toJson())),
        "classes": Map.from(classes)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "functions": Map.from(functions)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "issues": List<dynamic>.from(issues.map((x) => x)),
        "antiPatternCases": List<dynamic>.from(antiPatternCases.map((x) => x)),
      };
}

class Issue {
  Issue({
    required this.ruleId,
    required this.codeSpan,
    required this.documentation,
    required this.severity,
    required this.message,
    required this.verboseMessage,
    required this.suggestion,
  });

  String ruleId;
  CodeSpan codeSpan;
  String documentation;
  String severity;
  String message;
  String verboseMessage;
  Suggestion suggestion;

  factory Issue.fromJson(Map<String, dynamic> json) => Issue(
        ruleId: json["ruleId"],
        codeSpan: CodeSpan.fromJson(json["codeSpan"]),
        documentation: json["documentation"],
        severity: json["severity"],
        message: json["message"],
        verboseMessage: json["verboseMessage"],
        suggestion: Suggestion.fromJson(json["suggestion"]),
      );

  Map<String, dynamic> toJson() => {
        "ruleId": ruleId,
        "codeSpan": codeSpan.toJson(),
        "documentation": documentation,
        "severity": severity,
        "message": message,
        "verboseMessage": verboseMessage,
        "suggestion": suggestion.toJson(),
      };
}

class Suggestion {
  Suggestion({
    required this.comment,
    required this.replacement,
  });

  String comment;
  String replacement;

  factory Suggestion.fromJson(Map<String, dynamic> json) => Suggestion(
        comment: json["comment"],
        replacement: json["replacement"],
      );

  Map<String, dynamic> toJson() => {
        "comment": comment,
        "replacement": replacement,
      };
}

class Class {
  Class({
    required this.codeSpan,
    required this.metrics,
  });

  CodeSpan codeSpan;
  List<Metric> metrics;

  factory Class.fromJson(Map<String, dynamic> json) => Class(
        codeSpan: CodeSpan.fromJson(json["codeSpan"]),
        metrics:
            List<Metric>.from(json["metrics"].map((x) => Metric.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "codeSpan": codeSpan.toJson(),
        "metrics": List<dynamic>.from(metrics.map((x) => x.toJson())),
      };
}

class CodeSpan {
  CodeSpan({
    required this.start,
    required this.end,
    required this.text,
  });

  End start;
  End end;
  String text;

  factory CodeSpan.fromJson(Map<String, dynamic> json) => CodeSpan(
        start: End.fromJson(json["start"]),
        end: End.fromJson(json["end"]),
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "start": start.toJson(),
        "end": end.toJson(),
        "text": text,
      };
}

class End {
  End({
    required this.offset,
    required this.line,
    required this.column,
  });

  int offset;
  int line;
  int column;

  factory End.fromJson(Map<String, dynamic> json) => End(
        offset: json["offset"],
        line: json["line"],
        column: json["column"],
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "line": line,
        "column": column,
      };
}

class Metric {
  Metric({
    required this.metricsId,
    required this.value,
    required this.unitType,
    required this.level,
    required this.comment,
    required this.context,
  });

  MetricsId metricsId;
  double value;
  UnitType? unitType;
  Status level;
  String comment;
  List<Context> context;

  factory Metric.fromJson(Map<String, dynamic> json) => Metric(
        metricsId: metricsIdValues.map[json["metricsId"]]!,
        value: json["value"].toDouble(),
        unitType: unitTypeValues.map[json["unitType"]],
        level: statusValues.map[json["level"]]!,
        comment: json["comment"],
        context:
            List<Context>.from(json["context"].map((x) => Context.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "metricsId": metricsIdValues.reverse[metricsId],
        "value": value,
        "unitType": unitTypeValues.reverse[unitType],
        "level": statusValues.reverse[level],
        "comment": comment,
        "context": List<dynamic>.from(context.map((x) => x.toJson())),
      };
}

class Context {
  Context({
    required this.message,
    required this.codeSpan,
  });

  String message;
  CodeSpan codeSpan;

  factory Context.fromJson(Map<String, dynamic> json) => Context(
        message: json["message"],
        codeSpan: CodeSpan.fromJson(json["codeSpan"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "codeSpan": codeSpan.toJson(),
      };
}

enum Status { none }

final statusValues = EnumValues({"none": Status.none});

enum MetricsId {
  NUMBER_OF_METHODS,
  WEIGHT_OF_CLASS,
  TECHNICAL_DEBT,
  CYCLOMATIC_COMPLEXITY,
  HALSTEAD_VOLUME,
  LINES_OF_CODE,
  MAXIMUM_NESTING_LEVEL,
  SOURCE_LINES_OF_CODE,
  MAINTAINABILITY_INDEX,
  NUMBER_OF_PARAMETERS
}

final metricsIdValues = EnumValues({
  "cyclomatic-complexity": MetricsId.CYCLOMATIC_COMPLEXITY,
  "halstead-volume": MetricsId.HALSTEAD_VOLUME,
  "lines-of-code": MetricsId.LINES_OF_CODE,
  "maintainability-index": MetricsId.MAINTAINABILITY_INDEX,
  "maximum-nesting-level": MetricsId.MAXIMUM_NESTING_LEVEL,
  "number-of-methods": MetricsId.NUMBER_OF_METHODS,
  "number-of-parameters": MetricsId.NUMBER_OF_PARAMETERS,
  "source-lines-of-code": MetricsId.SOURCE_LINES_OF_CODE,
  "technical-debt": MetricsId.TECHNICAL_DEBT,
  "weight-of-class": MetricsId.WEIGHT_OF_CLASS
});

enum UnitType { METHODS, METHOD, LINES, LINE }

final unitTypeValues = EnumValues({
  "line": UnitType.LINE,
  "lines": UnitType.LINES,
  "method": UnitType.METHOD,
  "methods": UnitType.METHODS
});

class Summary {
  Summary({
    required this.status,
    required this.title,
    required this.value,
    required this.violations,
  });

  Status status;
  String title;
  dynamic value;
  int violations;

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        status: statusValues.map[json["status"]]!,
        title: json["title"],
        value: json["value"],
        violations: json["violations"],
      );

  Map<String, dynamic> toJson() => {
        "status": statusValues.reverse[status],
        "title": title,
        "value": value,
        "violations": violations,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap ?? {};
  }
}
