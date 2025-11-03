import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool enabled;
  final IconData? icon;

  const RoundedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.enabled = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: icon != null ? Icon(icon) : SizedBox.shrink(),
      onPressed: enabled ? onPressed : null,
      label: Text(text ,style: TextStyle(color: Colors.white),),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 46),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
