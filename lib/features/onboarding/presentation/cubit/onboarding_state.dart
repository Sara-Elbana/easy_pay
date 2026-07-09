class OnboardingState {
  final int pageIndex;
  final bool isLastPage;
  final bool isFinished;

  const OnboardingState({
    required this.pageIndex,
    required this.isLastPage,
    this.isFinished = false,
  });

  factory OnboardingState.initial() {
    return const OnboardingState(
      pageIndex: 0,
      isLastPage: false,
      isFinished: false,
    );
  }

  OnboardingState copyWith({
    int? pageIndex,
    bool? isLastPage,
    bool? isFinished,
  }) {
    return OnboardingState(
      pageIndex: pageIndex ?? this.pageIndex,
      isLastPage: isLastPage ?? this.isLastPage,
      isFinished: isFinished ?? this.isFinished,
    );
  }
}
