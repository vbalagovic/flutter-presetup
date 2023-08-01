import 'package:flutter/material.dart';
import 'package:presetup/utilities/theme.dart';

class FpButton extends StatelessWidget {
  const FpButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.buttonColor,
    this.isLoading = false,
  }) : super(key: key);

  final String title;
  final Color? buttonColor;
  final void Function()? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          )),
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(vertical: 12, horizontal: 16)),
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.disabled)) {
              return FpTheme.of(context).primaryColor.withOpacity(0.7);
            }
            return FpTheme.of(context).primaryColor;
          }),
        ),
        onPressed: !isLoading ? onPressed : null,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          if (isLoading)
            Container(
              width: 16,
              height: 16,
              padding: const EdgeInsets.all(2),
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            ),
          if (isLoading)
            const SizedBox(
              width: 8,
            ),
          Text(title,
              style: FpTheme.of(context)
                  .bodyText1
                  .copyWith(color: FpTheme.of(context).primaryBtnText))
        ]));
  }
}
