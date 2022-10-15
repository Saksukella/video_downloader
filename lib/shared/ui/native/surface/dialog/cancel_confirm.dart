import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CancelConfirmButtons extends StatefulWidget {
  const CancelConfirmButtons(
      {super.key,
      this.title = "Confirm",
      required this.onSubmit,
      this.onCancel});

  final String title;
  final bool? Function() onSubmit;
  final Function()? onCancel;

  @override
  State<CancelConfirmButtons> createState() => _CancelConfirmButtonsState();
}

class _CancelConfirmButtonsState extends State<CancelConfirmButtons> {
  bool isLoading = false;
  bool? success;

  void resetLoading() {
    if (!mounted) return;
    setState(() {
      isLoading = false;
      Future.delayed(const Duration(seconds: 2), () {
        success = null;
        if (mounted) {
          setState(() {});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 40,
            child: OutlinedButton(
                onPressed: () {
                  widget.onCancel?.call();

                  Get.back(result: null);
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                )),
                child: const Text(
                  "Cancel",
                  style: TextStyle(fontSize: 16),
                )),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 3,
          child: SizedBox(
            height: 40,
            child: ElevatedButton(
                onPressed: () async {
                  isLoading = true;
                  setState(() {});
                  success = await widget.onSubmit();
                  resetLoading();
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                )),
                child: PageTransitionSwitcher(
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                  ) {
                    return SharedAxisTransition(
                      fillColor: Colors.transparent,
                      animation: animation,
                      secondaryAnimation: secondaryAnimation,
                      transitionType: SharedAxisTransitionType.vertical,
                      child: child,
                    );
                  },
                  child: isLoading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : success == null
                          ? Text(
                              widget.title,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                            )
                          : success == true
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                )),
          ),
        )
      ],
    );
  }
}
