import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BankCard extends StatelessWidget {
  const BankCard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(8.0),
      height: size.height * 0.28,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(10),
        // image: DecorationImage(
        //   image: AssetImage('assets/images/login.png'),
        //   fit: BoxFit.cover,
        // ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                ),
                color: Colors.red,
              ),
              child: RotatedBox(
                quarterTurns: 1,
                child: Text(
                  'virtual'.toUpperCase(),
                  style: GoogleFonts.lora(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 28,
            left: 20,
            child: Text(
              'ABC BANK'.toUpperCase(),
              style: GoogleFonts.lato(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 50,
            child: Image.asset(
              'assets/images/discover.png',
              height: 100,
            ),
          ),
          Positioned(
            bottom: 70,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CHHEANG TONG'.toUpperCase(),
                  style: GoogleFonts.lora(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '4802 - 2215 - 1183 - 4289',
                  style: GoogleFonts.lora(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 15,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'expiry:'.toUpperCase(),
                  style: GoogleFonts.lora(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
                Text(
                  '05/26',
                  style: GoogleFonts.lora(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VisaCard extends StatelessWidget {
  const VisaCard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(8.0),
      height: size.height * 0.28,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage('assets/images/login.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                ),
                color: Colors.red,
              ),
              child: RotatedBox(
                quarterTurns: 1,
                child: Text(
                  'virtual'.toUpperCase(),
                  style: GoogleFonts.lora(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 28,
            left: 20,
            child: Text(
              'ABC BANK'.toUpperCase(),
              style: GoogleFonts.lato(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 50,
            child: Image.asset(
              'assets/images/visa.png',
              height: 100,
            ),
          ),
          Positioned(
            bottom: 70,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CHHEANG TONG'.toUpperCase(),
                  style: GoogleFonts.lora(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '4802 - 2215 - 1183 - 4289',
                  style: GoogleFonts.lora(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 15,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'expiry:'.toUpperCase(),
                  style: GoogleFonts.lora(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
                Text(
                  '05/26',
                  style: GoogleFonts.lora(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MasterCard extends StatelessWidget {
  const MasterCard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(8.0),
      height: size.height * 0.28,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage('assets/images/login.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                ),
                color: Colors.red,
              ),
              child: RotatedBox(
                quarterTurns: 1,
                child: Text(
                  'virtual'.toUpperCase(),
                  style: GoogleFonts.lora(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 28,
            left: 20,
            child: Text(
              'ABC BANK'.toUpperCase(),
              style: GoogleFonts.lato(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 30,
            child: Image.asset(
              'assets/images/master_card.png',
              height: 80,
            ),
          ),
          Positioned(
            bottom: 70,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CHHEANG TONG'.toUpperCase(),
                  style: GoogleFonts.lora(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '4802 - 2215 - 1183 - 4289',
                  style: GoogleFonts.lora(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 15,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'expiry:'.toUpperCase(),
                  style: GoogleFonts.lora(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
                Text(
                  '05/26',
                  style: GoogleFonts.lora(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
