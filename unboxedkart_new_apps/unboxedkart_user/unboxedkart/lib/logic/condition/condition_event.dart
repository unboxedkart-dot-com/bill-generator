part of 'condition_bloc.dart';

abstract class ConditionEvent extends Equatable {
  const ConditionEvent();

  @override
  List<Object> get props => [];
}

class LoadData extends ConditionEvent {
  final String conditionName;

  const LoadData(this.conditionName);
}

class LoadConditionCarouselItems extends ConditionEvent {
  final String condition;

  const LoadConditionCarouselItems(this.condition);

}

