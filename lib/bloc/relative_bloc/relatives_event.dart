import '../../models/relative_model.dart';

abstract class RelativesEvent {}

class FetchAllRelatives extends RelativesEvent {
    FetchAllRelatives();
}

class AddRelative extends RelativesEvent {
    final Relative relative;
    AddRelative(this.relative);
}

class UpdateRelative extends RelativesEvent {
    final Relative relative;
    UpdateRelative(this.relative);
}

class DeleteRelative extends RelativesEvent {
    String uuid;
    DeleteRelative(this.uuid);
}



 