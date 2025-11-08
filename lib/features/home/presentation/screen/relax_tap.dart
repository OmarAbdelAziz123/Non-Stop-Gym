import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop/features/home/bloc/cubit/home_cubit.dart';
import 'package:non_stop/features/home/presentation/widgets/available_times.dart';
import 'package:non_stop/features/home/presentation/widgets/calender_widget.dart';
import 'package:non_stop/features/home/presentation/widgets/time_slots_widget.dart';

class RelaxTap extends StatelessWidget {
  const RelaxTap({
    super.key,
    required this.times,
    required this.selectedTimeSlot,
  });

  final List<List<String>> times;
  final String? selectedTimeSlot;

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    return Column(
      children: [
        AvailableTimesWidget(),
        // Calendar
        CalenderWidget(homeCubit: homeCubit),
        // Time Slots
        TimeSlotsWidget(times: times, selectedTimeSlot: selectedTimeSlot),
        Image.asset("lib/features/home/about_us.png"),
        SizedBox(height: 8),
        Text(
          style: TextStyle(color: Colors.white60, fontSize: 13),

          'نحن نادي Non-stop مشروع رياضي متكامل يقع في برج العبد الكريم ويخدم موظفي وموظفات اكثر من ٢٠ شركه من مختلف القطاعات. تأسس النادي لتوفير بيئه مرنه وصحيه تساعد الموظفين علي تحقيق التوازن بين العمل والحياه. وتعزز من صحتهم الجسديه والذهنيه.',
        ),
        SizedBox(height: 8),

        Image.asset("assets/pngs/eyes.png"),
        SizedBox(height: 8),

        Text(
          style: TextStyle(color: Colors.white60, fontSize: 13),

          'ان نكون الخيار الاول والمفضل للموظفين والموظفات في بيئه العمل العصريه، من خلال تقديم تجربه رياضيه تجمع بين الراحه، والتنوع، وتسهم في رفع جوده الحياه والصحه العامه.',
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
