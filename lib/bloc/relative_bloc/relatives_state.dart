import 'package:astrotak/models/relative_model.dart';

abstract class RelativesState {}

class InitialRelativesState extends RelativesState {
  InitialRelativesState();
}

class FetchingRelativesState extends RelativesState {
  FetchingRelativesState();
}

class FetchedRelativesState extends RelativesState {
  final List<Relative> relatives;
  FetchedRelativesState(this.relatives);
}

class AddingRelativeState extends RelativesState {
  AddingRelativeState();
}

class AddedRelativeState extends RelativesState {
  AddedRelativeState();
}

class UpdatingRelativeState extends RelativesState {
  UpdatingRelativeState();
}

class UpdatedRelativeState extends RelativesState {
  UpdatedRelativeState();
}

class DeletingRelativeState extends RelativesState {
  DeletingRelativeState();
}

class DeletedRelativeState extends RelativesState {
  DeletedRelativeState();
}

class NoReqState extends RelativesState {
  NoReqState();
}
