// ignore_for_file: omit_local_variable_types

List<String> explodeTitle(String title) {
  List<String> splitList = title.split(' ');
  List<String> indexList = [];

  for (int i = 0; i < splitList.length; i++) {
    for (int k = 3; k < splitList[i].length + 1; k++) {
      var temp = splitList[i].substring(0, k).toLowerCase();
      if (indexList.contains(temp) == false) {
        indexList.add(temp);
      }
    }
  }
  //print(indexList);
  return indexList;
}
