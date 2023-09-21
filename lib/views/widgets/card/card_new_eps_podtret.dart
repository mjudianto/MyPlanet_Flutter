import 'package:flutter/material.dart';
import 'package:myplanet/theme.dart';
import 'package:myplanet/views/pages/podtret/new_eps_podtret.dart';

class CardNewEps extends StatelessWidget {
  const CardNewEps({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                NewEpsPodtret(), // Ganti dengan nama yang sesuai
          ),
        );
      },
      child: Container(
          width: 136,
          // height: 278,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Image.asset(
                  'assets/podtret/thumbnail/eps73.png',
                  width: 136,
                  height: 77,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Eps 73 : MANTAN Bocoran Info RING 1',
                        style: blackTextStyle.copyWith(
                            fontSize: 11, fontWeight: semiBold),
                        overflow: TextOverflow
                            .ellipsis, // klo tulisannya panjang jadi titik titik
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        '329x Watching • 13 July 2023',
                        style: secondaryTextStyle.copyWith(
                          fontSize: 8,
                          fontWeight: regular,
                        ),
                        overflow: TextOverflow
                            .ellipsis, // klo tulisannya panjang jadi titik titik
                        maxLines: 1, // maksimal tulisan 1 baris
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Sapa Mantan',
                        style: secondaryTextStyle.copyWith(
                          fontSize: 8,
                          fontWeight: regular,
                        ),
                      ),
                    ]),
              )
            ],
          )),
    );
  }
}
