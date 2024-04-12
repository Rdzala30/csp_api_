class ProjectDetails {
  List<Data>? data;

  ProjectDetails({this.data});

  ProjectDetails.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? name;
  AssociatedManager? associatedManager;
  String? overview;
  Budget? budget;
  String? timeline;
  Stack? stack;
  String? scope;
  String? startDate;
  String? status;
  int? iV;

  Data(
      {this.sId,
        this.name,
        this.associatedManager,
        this.overview,
        this.budget,
        this.timeline,
        this.stack,
        this.scope,
        this.startDate,
        this.status,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    associatedManager = json['associated_manager'] != null
        ? new AssociatedManager.fromJson(json['associated_manager'])
        : null;
    overview = json['overview'];
    budget =
    json['budget'] != null ? new Budget.fromJson(json['budget']) : null;
    timeline = json['timeline'];
    stack = json['stack'] != null ? new Stack.fromJson(json['stack']) : null;
    scope = json['scope'];
    startDate = json['start_date'];
    status = json['status'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    if (this.associatedManager != null) {
      data['associated_manager'] = this.associatedManager!.toJson();
    }
    data['overview'] = this.overview;
    if (this.budget != null) {
      data['budget'] = this.budget!.toJson();
    }
    data['timeline'] = this.timeline;
    if (this.stack != null) {
      data['stack'] = this.stack!.toJson();
    }
    data['scope'] = this.scope;
    data['start_date'] = this.startDate;
    data['status'] = this.status;
    data['__v'] = this.iV;
    return data;
  }
}

class AssociatedManager {
  String? sId;
  String? name;
  String? designation;

  AssociatedManager({this.sId, this.name, this.designation});

  AssociatedManager.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['designation'] = this.designation;
    return data;
  }
}

class Budget {
  String? type;
  String? typeValue;

  Budget({this.type, this.typeValue});

  Budget.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    typeValue = json['type_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['type_value'] = this.typeValue;
    return data;
  }
}

class Stack {
  String? label;
  String? value;

  Stack({this.label, this.value});

  Stack.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    return data;
  }
}
