import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final Widget widget;
  const BuildCard({
    super.key,
    required this.icon,
    required this.title,
    required this.widget,
  });

  @override
  State<BuildCard> createState() => _BuildCardState();
}

class _BuildCardState extends State<BuildCard> {
  bool isdrop = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    isdrop = !isdrop;
                  });
                },
                icon: Icon(
                  widget.icon,
                  color: Colors.blue,
                ),
              ),
              Expanded(
                child: Text(
                  widget.title,
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isdrop = !isdrop;
                  });
                },
                icon: Icon(
                  isdrop
                      ? Icons.keyboard_arrow_up_outlined
                      : Icons.keyboard_arrow_down_outlined,
                ),
              ),
            ],
          ),
          isdrop == true ? widget.widget : Container(),
        ],
      ),
    );
  }
}
