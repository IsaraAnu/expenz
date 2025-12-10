import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  final String title;
  final double amount;
  final double total;
  final Color progressColor;
  final bool isExepense;
  const CategoryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.total,
    required this.progressColor,
    required this.isExepense,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    double progressWidth = widget.amount != 0
        ? MediaQuery.of(context).size.width * (widget.amount / widget.total)
        : 0;
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kWhite,
        boxShadow: [BoxShadow(color: kBlack.withOpacity(0.1), blurRadius: 20)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: widget.progressColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 7,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.progressColor,
                        ),
                      ),
                      SizedBox(width: 7),
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: kBlack,
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              widget.isExepense == true
                  ? Text(
                      "-\$${widget.amount.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: kRed,
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                      ),
                    )
                  : Text(
                      "+\$${widget.amount.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: kGreen,
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                      ),
                    ),
            ],
          ),
          SizedBox(height: 15),
          // leanier progressbra
          Container(
            height: 10,
            width: progressWidth,
            decoration: BoxDecoration(
              color: widget.progressColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}
