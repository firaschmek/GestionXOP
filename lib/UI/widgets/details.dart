import 'package:appgestion/constant/constants.dart';
import 'package:appgestion/models/article_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Details extends StatefulWidget {
  final Article item;
  final Function numbeofItemsChanged;

  const Details({
    Key key,
    this.item, this.numbeofItemsChanged,
  }) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int count=1;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.item.lib_art,
                style: kTitleStyle.copyWith(fontSize: 18),
              ),
              SvgPicture.asset(
                'assets/icons/favorite.svg',
                color: kBlackColor.withOpacity(0.7),
              ),
            ],
          ),
          SizedBox(height: 10),
          /*Text(
            item.lib_art,
            style: kDescriptionStyle,
          ),*/
          SizedBox(height: 20),
          Row(
            children: [
              IconButton(
                  icon: Icon(
                    Icons.horizontal_rule,
                    color: kBlackColor.withOpacity(0.7),
                  ),
                  onPressed: () {
                    setState(() {
                      count--;
                    });
                    widget.numbeofItemsChanged(count);
                  }),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: kBorderColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  count.toString(),
                  style: kTitleStyle,
                ),
              ),
              IconButton(
                icon: Icon(Icons.add, color: kPrimaryColor),
                onPressed: () {
                  setState(() {
                    count++;
                  });
                  widget.numbeofItemsChanged(count);
                },
              ),
              Spacer(),
              Text('DT ${double.parse(widget.item.prix) * count}',
                  style: kTitleStyle.copyWith(fontSize: 18))
            ],
          ),
        ],
      ),
    );
  }
}
