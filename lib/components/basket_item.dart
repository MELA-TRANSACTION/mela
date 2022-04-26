import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../size_config.dart';

class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    Key? key,
    required this.svgSrc,
    this.numOfitem = 0,
    required this.press,
  }) : super(key: key);

  final String svgSrc;
  final int numOfitem;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: press,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(16),
          horizontal: 24,
        ),
        height: getProportionateScreenWidth(74),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color(0xff21CE99),
          // shape: BoxShape.circle,
        ),
        child: Row(
          // clipBehavior: Clip.none,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "$numOfitem",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(32),
                        height: 1,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SvgPicture.asset(
                  svgSrc,
                  color: Colors.white,
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: const [
                Text(
                  "Continuer ",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  CupertinoIcons.chevron_right,
                  color: Colors.white,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
