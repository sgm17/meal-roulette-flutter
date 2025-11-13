import 'package:flutter/material.dart';
import 'package:meal_roulette/configs/common_widgets/gradient_text.dart';
import 'package:meal_roulette/configs/resources/resources.dart';
import 'package:meal_roulette/configs/resources/sizing.dart';
import 'package:meal_roulette/modules/mensa/presentation/provider/mensa_provider.dart';
import 'package:meal_roulette/modules/mensa/presentation/widgets/mensa_list.dart';
import 'package:provider/provider.dart';

class MensaView extends StatefulWidget {
  const MensaView({super.key});

  @override
  State<MensaView> createState() => _MensaViewState();
}

class _MensaViewState extends State<MensaView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MensaProvider>().fetchMensas();
    });
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<MensaProvider>(context, listen: false).initializeJoinStatuses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MensaProvider>(context);

    return Scaffold(
      backgroundColor: R.colors.white,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70.h,
        title: Column(
          children: [
            GradientText(
              'Welcome back, Demo User!',
              style: R.textStyles.font24B,
              gradient: LinearGradient(colors: [R.colors.splashGrad1, R.colors.splashGrad2]),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 16.h),
              child: Text(
                'Ready to meet someone new over lunch today?',
                style: R.textStyles.font11R.copyWith(color: R.colors.textGrey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          MensaList(),
          if (provider.isLoading)  Center(child: CircularProgressIndicator(backgroundColor: R.colors.transparent,)),
        ],
      ),
    );
  }
}
