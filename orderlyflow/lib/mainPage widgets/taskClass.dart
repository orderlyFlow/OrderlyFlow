// ignore_for_file: file_names, non_constant_identifier_names

class Tasks {

  final int ID;

  final String name;

  late final bool status;


  Tasks({required this.ID,required this.name, required this.status});

    @override
  String toString() {
    return 'Task(name: $name, status: $status,)';
  }

    Tasks copyWith({int? ID, String? name, bool? status}) {
    return Tasks(
      ID: ID ?? this.ID,
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }


}