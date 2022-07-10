enum CoverageOption {
  onlyOverAll('onlyOverAll', ''),
  target('target', 't'),
  file('file', 'f');

  const CoverageOption(this.name, this.abbr);
  final String name;
  final String abbr;
}