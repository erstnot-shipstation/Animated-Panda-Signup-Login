import '../../assets_db/assets_db.dart';
import '../../routes/routes.dart';
import '../../stores/introduction/introduction.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

class Introduction extends StatefulWidget {
  const Introduction({super.key});

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  late IntroductionStore _introductionStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _introductionStore = Provider.of<IntroductionStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Introduction Screen"),
    );
  }
}
