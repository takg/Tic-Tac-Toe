enum Mode {EASY, MEDIUM, HARD, VERY_HARD}
enum Player {NONE, PERSON, COMPUTER}

// sharing the mode list as a function rather than global variable
List<String> getModeList() {
  return ["Easy", "Medium", "Hard", "Very Hard"];
}

Mode getMode(String text) {
  var modeList = [Mode.EASY, Mode.MEDIUM, Mode.HARD, Mode.VERY_HARD];
  var textList = getModeList();

  return modeList[textList.indexOf(text)];
}
