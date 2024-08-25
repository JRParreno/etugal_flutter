import 'package:equatable/equatable.dart';

class ListResponse extends Equatable {
  final int count;
  final String? next;
  final String? previous;

  const ListResponse({
    required this.count,
    required this.next,
    required this.previous,
  });

  @override
  List<Object?> get props => [
        count,
        next,
        previous,
      ];
}
