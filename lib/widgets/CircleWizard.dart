import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttersosmed/theme/colors/Warna.dart';
import 'package:fluttersosmed/theme/styles/text/montserrat_style_text.dart';

class CircleWizard extends StatelessWidget {
  final int progress;
  final int steps;
  const CircleWizard({
    Key? key,
    required this.progress,
    required this.steps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final elementLength = steps + (steps - 1);

    return Row(
      children: List.generate(elementLength, (index) {
        if (index.isEven) {
          final nom = (index / 2) + 1;
          return _Circle(
            step: nom.toInt(),
            isOn: progress >= nom,
          );
        }
        return Expanded(
          child: Container(
            height: 2,
            color: (progress * 2) >= index ? Warna.hijau : Color(0xFFC7C7C7),
          ),
        );
      }),
    );
    return Row(
      children: [
        _Circle(
          step: 1,
          isOn: true,
        ),
        Expanded(
          child: Container(
            height: 2,
            color: Warna.hijau,
          ),
        ),
        _Circle(
          step: 2,
          isOn: false,
        ),
        Expanded(
          child: Container(
            height: 2,
            color: Color(0xFFC7C7C7),
          ),
        ),
        _Circle(
          step: 3,
          isOn: false,
        ),
        Expanded(
          child: Container(
            height: 2,
            color: Color(0xFFC7C7C7),
          ),
        ),
        _Circle(
          step: 4,
          isOn: false,
        ),
      ],
    );
  }
}

class _Circle extends StatelessWidget {
  final bool isOn;
  final int step;
  const _Circle({
    super.key,
    required this.step,
    required this.isOn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isOn ? Warna.hijau : Colors.white,
        border: Border.all(
          width: 1.0,
          color: isOn ? Warna.hijau : Color(0xFFC7C7C7),
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: Offset(0.0, 3.0), //(x,y)
            blurRadius: 13.0,
          ),
        ],
      ),
      padding: EdgeInsets.all(8),
      child: Center(
        child: Text(
          step.toString(),
          style: MontserratSemiBold14.copyWith(
            color: isOn ? Colors.white : Color(0xFFC7C7C7),
          ),
        ),
      ),
    );
  }
}
