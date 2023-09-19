import 'package:flutter/material.dart';
import 'package:myplanet/theme.dart';

class CardTopEps extends StatelessWidget {
  const CardTopEps({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          width: 300,
          margin: const EdgeInsets.only(
            right: 38,
            bottom: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image.asset(
                  'assets/podtret/thumbnail/eps72.png',
                  width: 122,
                  height: 69,
                ),
              ),
              const SizedBox(width: 10), // Jarak antara thumbnail dan teks
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 4.5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            100), // Mengatur border radius
                        color: primaryColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        child: Text(
                          'Ngobrol Santai',
                          style: blackTextStyle.copyWith(
                            fontSize: 8,
                            fontWeight: medium,
                            color:
                                whiteColor, // Ganti warna teks sesuai kebutuhan
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Eps 72 : Jawabin Pertanyaan Lucu Gens dari IG',
                      style: blackTextStyle.copyWith(
                        fontSize: 11,
                        fontWeight: semiBold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '349x Watching • 21 July 2023',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 8,
                        fontWeight: regular,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
