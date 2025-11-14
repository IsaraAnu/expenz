import 'package:expenz/constants/colors.dart';
import 'package:flutter/material.dart';

class IcomeExpenceCard extends StatefulWidget {
  final String title;
  final double amount;
  final String imageUrl;
  final Color bgColor;

  const IcomeExpenceCard({
    super.key,
    required this.title,
    required this.amount,
    required this.imageUrl,
    required this.bgColor,
  });

  @override
  State<IcomeExpenceCard> createState() => _IcomeExpenceCardState();
}

class _IcomeExpenceCardState extends State<IcomeExpenceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        color: widget.bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.15,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(widget.imageUrl, width: 100),
            ),
            SizedBox(width: 10),
            Column(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 1),
                Text(
                  "\$${widget.amount.toStringAsFixed(0)}",
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
