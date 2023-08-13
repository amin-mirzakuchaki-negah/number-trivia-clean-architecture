import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/number_trivia_bloc.dart';
import '../widgets/loading_widget.dart';
import '../widgets/message_display.dart';
import '../widgets/trivia_display.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Number Trivia'),
        ),
        body: BlocProvider(
          create: (_) => getIt<NumberTriviaBloc>(),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                //Top Half
                BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                  builder: (context, state) {
                    if (state is NumberTriviaInitial) {
                      return const MessageDisplay(message: 'Start Searching!');
                    } //
                    // else if(state is Internet) {}
                    else if (state is NumberTriviaLoadingState) {
                      return const LoadingWidget();
                    } //
                    else if (state is InputFailureState) {
                      return MessageDisplay(
                          message: state.message ?? "Something went wrong");
                    } else if (state is NumberTriviaSuccessState) {
                      return TriviaDisplay(numberTrivia: state.response);
                    } //
                    else {
                      return const Text('test');
                    }
                  },
                ),
                const SizedBox(height: 20),
                //Bottom Half
                const BottomHalf(),
              ],
            ),
          ),
        ));
  }
}

class BottomHalf extends StatefulWidget {
  const BottomHalf({super.key});

  @override
  State<BottomHalf> createState() => _BottomHalfState();
}

class _BottomHalfState extends State<BottomHalf> {
  late String inputStr;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          //Text Field
          TextField(
            onSubmitted: (_){dispatchConcrete();},
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Input a number',
            ),
            onChanged: (value) {
              inputStr = value;
            },
          ),
          const SizedBox(height: 20),
          //Buttons
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: dispatchConcrete,
                    child: const Text('Search'),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // Use the backgroundColor property to set the button's color
                      backgroundColor: Colors.grey,
                    ),
                    onPressed: dispatchRandom,
                    child: const Text('Get random Trivia',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void dispatchConcrete() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetConcreteNumberTriviaEvent(inputStr));
  }

  void dispatchRandom() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetRandomNumberTriviaEvent());
  }
}
