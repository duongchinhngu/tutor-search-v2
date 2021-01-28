//this class for category item( contains filter values to search inside)
class FilterItem {
  String title;
  String subTitle;
  final List<SubItems> subItems;
  bool hasIcon;

  FilterItem(
    this.title,
    this.subTitle,
    this.subItems,
    this.hasIcon,
  );
}

abstract class SubItems {
  int id;
  String name;
  String description;
  bool isChecked;

  SubItems(
    this.id,
    this.name,
    this.description,
    this.isChecked,
  );
}

//study fee
class FeeRange extends SubItems {
  FeeRange(int id, String name, String description, bool isChecked)
      : super(id, name, description, isChecked);
}

//days in week
class Weekday extends SubItems {
  Weekday(int id, String name, String description, bool isChecked)
      : super(id, name, description, isChecked);
}

// subjects list
class SubjectInFilter extends SubItems {
  SubjectInFilter(int id, String name, String description, bool isChecked)
      : super(id, name, description, isChecked);
}

//classes list in filter
class ClassInFilter extends SubItems {
  ClassInFilter(int id, String name, String description, bool isChecked)
      : super(id, name, description, isChecked);
}

//gender list
class Gender extends SubItems {
  Gender(int id, String name, String description, bool isChecked)
      : super(id, name, description, isChecked);
}

//education level
class EducationLevel extends SubItems {
  EducationLevel(int id, String name, String description, bool isChecked)
      : super(id, name, description, isChecked);
}
