import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/number_trivia.dart';
import '../bloc/number_trivia_bloc.dart';
import '../widgets/bottomhalf/bottom_half.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                SizedBox(height: 10),
                //Top Half
                BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                  builder: (context, state) {
                    if (state is NumberTriviaInitial) {
                      return const MessageDisplay(message: 'Start Searching!');
                    } //
                    else if(state is NumberTriviaLoadingState) {
                      return const LoadingWidget();
                    } //
                    else if(state is InputFailureState) {
                      return MessageDisplay(message: state.message ?? "Something went wrong");
                    }
                    else if(state is NumberTriviaSuccessState) {
                      return Text('dfe');
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

class MessageDisplay extends StatelessWidget {
  final String message;

  const MessageDisplay({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height / 3,
      child: Center(
        child: SingleChildScrollView(
          child: Text(
            message,
            style: const TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {

  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height / 3,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class TriviaDisplay extends StatelessWidget {
  final NumberTrivia numberTrivia;

  const TriviaDisplay({super.key, required this.numberTrivia});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height / 3,
      child: Column(
        children: [
          Text(numberTrivia.number.toString(), style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Text(
                  numberTrivia.text,
                  style: const TextStyle(fontSize: 25),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}