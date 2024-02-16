// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:palette_generator/palette_generator.dart';

import 'package:skin_care/common/colors/app_colors.dart';
import 'package:skin_care/data/data.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/E2dba3f6fa15215f066574526575d319 .jpg',
            height: MediaQuery.sizeOf(context).height * .9,
            width: MediaQuery.sizeOf(context).width,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.sizeOf(context).height * .6),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.elliptical(60, 50),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "86%",
                                  style: TextStyle(
                                    color: AppColors.yellow,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Skin health",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(.7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.7),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "14%",
                                  style: TextStyle(
                                    color: AppColors.pink,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Moisture",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(.7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      //  TODO: Add skin age tag here.
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 30),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.elliptical(60, 50),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                height: 4,
                                width: 75,
                                decoration: BoxDecoration(
                                  color: AppColors.black,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Suggested Products",
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: ItemsData.data.length,
                              itemBuilder: (context, index) {
                                ItemsData.data.shuffle();
                                ItemModel m = ItemsData.data[index];
                                return ItemTile(m: m);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 60,
            left: 20,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Iconsax.arrow_left,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemTile extends StatefulWidget {
  const ItemTile({
    Key? key,
    required this.m,
  }) : super(key: key);

  final ItemModel m;

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  PaletteGenerator? color;

  func() async {
    PaletteGenerator c =
        await PaletteGenerator.fromImageProvider(AssetImage(widget.m.image));

    setState(() {
      color = c;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      func();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color:
                  color?.vibrantColor?.color.withOpacity(.2) ?? AppColors.cream,
            ),
            child: Image.asset(
              widget.m.image,
            ),
            // child: Text(widget.m.name),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: SizedBox(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.m.brand,
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        height: .99,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      widget.m.name,
                      style: TextStyle(
                        color: AppColors.black.withOpacity(.7),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const Flexible(
                      child: Text(
                        "A i at more the bird fearing quoth and devil, hear i so again lost home meant something no it..",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Text(
                      "₹ ${widget.m.price}",
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
