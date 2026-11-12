import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class _Question {
  const _Question(this.prompt, this.options, this.correctIndex);

  final String prompt;
  final List<String> options;
  final int correctIndex;
}

const _questions = [
  _Question('Which planet is known as the Red Planet?',
      ['Earth', 'Mars', 'Venus', 'Jupiter'], 1),
  _Question('What is the largest ocean on Earth?',
      ['Atlantic', 'Indian', 'Pacific', 'Arctic'], 2),
  _Question('How many sides does a hexagon have?', ['5', '6', '7', '8'], 1),
  _Question('Which language is used to write Flutter apps?',
      ['Dart', 'Python', 'Swift', 'Ruby'], 0),
  _Question(
      'What is the chemical symbol for gold?', ['Ag', 'Fe', 'Au', 'O'], 2),
];

class QuizTab extends StatefulWidget {
  const QuizTab({super.key});

  @override
  State<QuizTab> createState() => _QuizTabState();
}

class _QuizTabState extends State<QuizTab> {
  final _controller = PageController();
  final List<int?> _answers = List.filled(_questions.length, null);
  int _current = 0;
  bool _finished = false;

  int get _answered => _answers.whereType<int>().length;
  int get _score => List.generate(_questions.length, (i) => i)
      .where((i) => _answers[i] == _questions[i].correctIndex)
      .length;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigate(int index) {
    _controller.animateToPage(index,
        duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
  }

  void _restart() {
    setState(() {
      _answers.fillRange(0, _answers.length, null);
      _current = 0;
      _finished = false;
    });
    _controller.jumpToPage(0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Score: $_score / ${_questions.length}',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text('$_answered of ${_questions.length} answered'),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                        value: _answered / _questions.length,
                        semanticsLabel: 'Questions answered'),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      children: List.generate(_questions.length, (index) {
                        return ChoiceChip(
                          label: Text('${index + 1}'),
                          tooltip: 'Question ${index + 1}',
                          avatar: _answers[index] == null
                              ? null
                              : const Icon(Icons.check, size: 16),
                          selected: _current == index,
                          onSelected: (_) => _navigate(index),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                      PointerDeviceKind.stylus,
                      PointerDeviceKind.trackpad,
                    },
                  ),
                  child: PageView.builder(
                    key: const Key('quizPages'),
                    controller: _controller,
                    itemCount: _questions.length,
                    onPageChanged: (index) => setState(() => _current = index),
                    itemBuilder: (context, index) {
                      final question = _questions[index];
                      final answer = _answers[index];
                      return SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                                'Question ${index + 1} of ${_questions.length}',
                                style: Theme.of(context).textTheme.labelLarge),
                            const SizedBox(height: 12),
                            Text(question.prompt,
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            const SizedBox(height: 16),
                            ...List.generate(question.options.length, (option) {
                              final selected = answer == option;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Semantics(
                                  selected: selected,
                                  child: OutlinedButton(
                                    onPressed: _finished
                                        ? null
                                        : () => setState(
                                            () => _answers[index] = option),
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.all(16),
                                      backgroundColor: selected
                                          ? Theme.of(context)
                                              .colorScheme
                                              .secondaryContainer
                                          : null,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(selected
                                            ? Icons.radio_button_checked
                                            : Icons.radio_button_unchecked),
                                        const SizedBox(width: 12),
                                        Expanded(
                                            child:
                                                Text(question.options[option])),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                            if (_finished) ...[
                              const SizedBox(height: 8),
                              Text(answer == question.correctIndex
                                  ? 'Correct!'
                                  : 'Correct answer: ${question.options[question.correctIndex]}'),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text('Swipe left or right to change questions.'),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: _current == 0
                              ? null
                              : () => _navigate(_current - 1),
                          icon: const Icon(Icons.chevron_left),
                          label: const Text('Previous'),
                        ),
                        TextButton.icon(
                          onPressed: _current == _questions.length - 1
                              ? null
                              : () => _navigate(_current + 1),
                          icon: const Icon(Icons.chevron_right),
                          label: const Text('Next'),
                        ),
                      ],
                    ),
                    if (_finished) ...[
                      Text(
                          'Quiz complete! $_score of ${_questions.length} correct '
                          '(${(_score / _questions.length * 100).round()}%).'),
                      const Text(
                          'Browse the questions to review your answers.'),
                      TextButton.icon(
                        onPressed: _restart,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Restart quiz'),
                      ),
                    ] else ...[
                      FilledButton(
                        onPressed: _answered == _questions.length
                            ? () => setState(() => _finished = true)
                            : null,
                        child: const Text('Finish quiz'),
                      ),
                      if (_answered < _questions.length)
                        const Text('Answer every question to finish.'),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
