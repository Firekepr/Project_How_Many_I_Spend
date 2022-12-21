import 'package:flutter/material.dart';
import 'package:how_many_i_spend/strings/calendar-strings.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../database/interfaces/calendar-items.dart';
import '../../../styles/custom-colors.dart';
import '../../../styles/custom-text-styles.dart';

class CalendarListItem extends StatelessWidget {
  final CalendarItems item;
  final void Function(CalendarItems scale) onSelectItem;
  final bool isLightTheme;
  final Color iconColor;
  final Color titleColor;

  const CalendarListItem({
    Key? key,
    required this.item,
    required this.onSelectItem,
    required this.iconColor,
    required this.titleColor,
    required this.isLightTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        side: BorderSide(
          color: Colors.black,
          width: 0.5,
        ),
      ),
      child: GestureDetector(
        onTap: () => onSelectItem(item),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Title
                    Row(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: Text(
                            '- ' + item.description,
                            textAlign: TextAlign.start,
                            style: CustomTextStyles.subTitleStyle1(context),
                          ),
                        ),
                      ],
                    ),

                    //Local and purchase type
                    Row(
                      children: [
                        Text(
                          item.spending + ' - ',
                          style: CustomTextStyles.subTitleStyle2Color(
                            color: Theme.of(context).primaryColor,
                            bold: false,
                          ),
                        ),
                        Text(
                          CalendarStrings.purchaseBy(item.type, item.parcel),
                          textAlign: TextAlign.start,
                          style: CustomTextStyles.subTitleStyle2Color(
                            color: ColorsService.handleTypeColor(item.type),
                            bold: false,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Icon(
                          MdiIcons.mapMarker,
                          color: iconColor,
                        ),
                        Text(
                          item.local!,
                          style: CustomTextStyles.subTitleStyle2Color(
                            color: Theme.of(context).primaryColor,
                            bold: false,
                          ),
                        ),
                      ],
                    )

                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.navigate_next,
                    color: iconColor,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
