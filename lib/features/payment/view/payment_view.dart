import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/common.dart';
import '../../feature.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});
  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  bool isdrop = false, ggplay = false;
  @override
  void initState() {
    super.initState();
    // Lock screen to portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    // Reset to allow all orientations when leaving the screen
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  List<String> card = [
    'assets/images/visa.png',
    'assets/images/master_card.png',
    'assets/images/discover.png',
  ];
  int selectIndex = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text('Payment View'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Payment mode'),
              tapBtn(
                onTap: () {
                  print('cash ');
                },
                icon: FontAwesomeIcons.moneyBills,
                title: 'Cash on Delivery',
              ),
              BuildCard(
                icon: FontAwesomeIcons.creditCard,
                title: 'Google Play/Other',
                widget: Container(
                  margin: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Saved Cards'),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(card.length + 1, (index) {
                            if (index == 0) {
                              return addCart(onTap: () {});
                            } else if (index - 1 < card.length) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectIndex = index;
                                  });
                                },
                                child: cardImage(
                                  index,
                                  color: selectIndex == index
                                      ? Colors.blueAccent
                                      : Colors.grey,
                                  isshow: selectIndex == index,
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                        ),
                      ),
                      if (selectIndex == 1) VisaCard(size: size),
                      if (selectIndex == 2) MasterCard(size: size),
                      if (selectIndex == 3) BankCard(size: size),
                    ],
                  ),
                ),
              ),
              BuildCard(
                icon: FontAwesomeIcons.googlePlay,
                title: 'Google Play /Other',
                widget: Container(),
              ),
              BuildCard(
                icon: Icons.assured_workload_outlined,
                title: 'Netbanking',
                widget: Container(),
              ),
              BuildCard(
                icon: Icons.wallet,
                title: 'Wallet',
                widget: Container(),
              ),
              Row(
                children: [
                  // Checkbox(value: , onChanged: onChanged)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget cardImage(
    int index, {
    required Color color,
    required bool isshow,
  }) {
    return Container(
      margin: EdgeInsets.all(4.0),
      height: 40,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: color,
        ),
        image: DecorationImage(
          image: AssetImage(
            card[index - 1],
          ),
          fit: BoxFit.contain,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          isshow
              ? Positioned(
                  top: -5,
                  right: -5,
                  child: Container(
                    alignment: Alignment.center,
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 15,
                        weight: 5,
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget addCart({
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(4.0),
        height: 40,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Text(
          'Add Card +',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget tapBtn({
    required Function onTap,
    required IconData icon,
    required String title,
  }) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.blue,
          ),
          title: Text(
            title,
            style: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
