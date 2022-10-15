import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class SResetRandomSaveButtons extends StatefulWidget {
  const SResetRandomSaveButtons({
    super.key,
    this.random,
    this.reset,
    this.resetAll,
    this.save,
    this.saveAll,
    this.edit,
    this.editAll,
  });

  final Function()? random;
  final Function()? reset;
  final Function()? resetAll;
  final Function()? save;
  final Function()? saveAll;
  final Function()? edit;
  final Function()? editAll;

  @override
  State<SResetRandomSaveButtons> createState() =>
      _SResetRandomSaveButtonsState();
}

class _SResetRandomSaveButtonsState extends State<SResetRandomSaveButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Visibility(
                visible: widget.reset != null,
                child:
                    _AnimatedTextButton(title: "Reset", onClick: widget.reset)),
            Visibility(
                visible: widget.resetAll != null,
                child: _AnimatedTextButton(
                  title: "Reset all",
                  onClick: widget.resetAll,
                  showConfirm: true,
                ))
          ],
        ),
        Row(
          children: [
            Visibility(
              visible: widget.random != null,
              child:
                  _AnimatedTextButton(title: "Random", onClick: widget.random),
            ),
            Visibility(
                visible: widget.edit != null,
                child:
                    _AnimatedTextButton(title: "Edit", onClick: widget.edit)),
            Visibility(
                visible: widget.editAll != null,
                child: _AnimatedTextButton(
                    title: "Edit all", onClick: widget.editAll)),
            Visibility(
              visible: widget.save != null,
              child: _AnimatedTextButton(title: "Save", onClick: widget.save),
            ),
            Visibility(
              visible: widget.saveAll != null,
              child: _AnimatedTextButton(
                  title: "Save all", onClick: widget.saveAll),
            ),
          ],
        ),
      ],
    );
  }
}

class _AnimatedTextButton extends StatefulWidget {
  _AnimatedTextButton(
      {required this.title, required this.onClick, this.showConfirm = false});

  final String title;
  bool showConfirm;

  final Function()? onClick;

  @override
  State<_AnimatedTextButton> createState() => __AnimatedTextButtonState();
}

class __AnimatedTextButtonState extends State<_AnimatedTextButton> {
  bool showCheck = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        action();
      },
      child: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return SharedAxisTransition(
            child: child,
            fillColor: Colors.transparent,
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.vertical,
          );
        },
        child: showCheck
            ? Row(
                children: [Icon(Icons.check)],
              )
            : Text(widget.title),
      ),
    );
  }

  void action() {
    widget.onClick?.call();
    showCheck = true;
    setState(() {});
    Future.delayed(Duration(seconds: 1), () {
      showCheck = false;
      if (mounted) {
        setState(() {});
      }
    });
  }
}
