import 'package:flutter/material.dart';
import 'package:meal_roulette/configs/common_widgets/gradient_text.dart';
import 'package:meal_roulette/configs/resources/resources.dart';
import 'package:meal_roulette/configs/resources/sizing.dart';
import 'package:meal_roulette/modules/mensa/data/models/mensa_models.dart';
import 'package:meal_roulette/modules/mensa/presentation/widgets/mensa_list.dart';

class MensaView extends StatelessWidget {
  const MensaView({super.key});

  @override
  Widget build(BuildContext context) {
    final mensas = [
      MensaModel(
        name: 'Untere Mensa',
        tags: 'Garden • Pure Asia • No butcher',
        location: 'UZH Zentrum',
        time: '12:00 AM - 3:00 PM',
        capacity: 200,
        imageUrl:
            'https://images.unsplash.com/photo-1504674900247-0877df9cc836',
      ),
      MensaModel(
        name: 'Obere Mensa',
        tags: 'Farm • Voll Anders • No butcher',
        location: 'UZH Zentrum',
        time: '12:00 PM - 2:30 PM',
        capacity: 150,
        imageUrl: 'https://images.unsplash.com/photo-1555992336-03a23c7b20ec',
      ),
      MensaModel(
        name: 'Mensa UZH Irchel',
        tags: 'Garden • Farm • Butcher',
        location: 'Irchel',
        time: '12:00 AM - 2:00 PM',
        capacity: 100,
        imageUrl:
            'https://images.unsplash.com/photo-1520201163981-8cc95007dd2a',
      ),
      MensaModel(
        name: 'Green Kitchen Lab',
        tags: 'One • Two',
        location: 'Irchel',
        time: '12:00 PM - 3:00 PM',
        capacity: 120,
        imageUrl:
            'https://images.unsplash.com/photo-1504674900247-0877df9cc836',
      ),
      MensaModel(
        name: 'Untere Mensa',
        tags: 'Garden • Pure Asia • No butcher',
        location: 'UZH Zentrum',
        time: '12:00 AM - 3:00 PM',
        capacity: 200,
        imageUrl:
        'https://images.unsplash.com/photo-1504674900247-0877df9cc836',
      ),
      MensaModel(
        name: 'Obere Mensa',
        tags: 'Farm • Voll Anders • No butcher',
        location: 'UZH Zentrum',
        time: '12:00 PM - 2:30 PM',
        capacity: 150,
        imageUrl: 'https://images.unsplash.com/photo-1555992336-03a23c7b20ec',
      ),
      MensaModel(
        name: 'Untere Mensa',
        tags: 'Garden • Pure Asia • No butcher',
        location: 'UZH Zentrum',
        time: '12:00 AM - 3:00 PM',
        capacity: 200,
        imageUrl:
        'https://images.unsplash.com/photo-1504674900247-0877df9cc836',
      ),
      MensaModel(
        name: 'Obere Mensa',
        tags: 'Farm • Voll Anders • No butcher',
        location: 'UZH Zentrum',
        time: '12:00 PM - 2:30 PM',
        capacity: 150,
        imageUrl: 'https://images.unsplash.com/photo-1555992336-03a23c7b20ec',
      ),
    ];

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
              gradient: LinearGradient(
                colors: [R.colors.splashGrad1, R.colors.splashGrad2],
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding:  EdgeInsets.only( bottom: 16.h),
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
      body: MensaList(mensaModels: mensas),
    );
  }
}
