import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:skin_care/common/colors/app_colors.dart';
import 'package:skin_care/common/widgets/scale_button.dart';
import 'package:skin_care/data/data.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _controller = PageController(
    initialPage: 5,
    viewportFraction: .2,
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.cream,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.elliptical(80, 50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 70),
                const Text(
                  "Daily Routine",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: 100,
                    child: PageView.builder(
                      pageSnapping: false,
                      controller: _controller,
                      itemBuilder: (context, index) {
                        bool isSelected;
                        try {
                          isSelected = _controller.page!.round() == index;
                        } catch (e) {
                          isSelected = index == 5;
                        }

                        int l = index - 5;

                        DateTime dt = DateTime.now().add(Duration(days: l));

                        return ScaleButton(
                          onTap: () {
                            _controller.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.fastEaseInToSlowEaseOut,
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.fastEaseInToSlowEaseOut,
                            margin: EdgeInsets.symmetric(
                                horizontal: 4, vertical: !isSelected ? 8 : 0),
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                            ),
                            width: isSelected ? 70 : 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(isSelected ? 25 : 30),
                            ),
                            child: Column(
                              children: [
                                Center(
                                  child: AnimatedDefaultTextStyle(
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.black
                                          : Colors.grey,
                                      fontSize: isSelected ? 20 : 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    duration: const Duration(milliseconds: 300),
                                    child: Text("${dt.day}"),
                                  ),
                                ),
                                const Spacer(),
                                AnimatedDefaultTextStyle(
                                  style: TextStyle(
                                    color:
                                        isSelected ? Colors.black : Colors.grey,
                                    fontSize: isSelected ? 16 : 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  duration: const Duration(milliseconds: 300),
                                  child: Text(DateFormat('EEE').format(dt)),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      ItemModel m = ItemsData.data[index];
                      return ItemGrid(m: m);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      ItemModel m = ItemsData.data[index + 4];
                      return ItemGrid(m: m);
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 140),
        ],
      ),
    );
  }
}

class ItemGrid extends StatefulWidget {
  const ItemGrid({
    super.key,
    required this.m,
  });

  final ItemModel m;

  @override
  State<ItemGrid> createState() => _ItemGridState();
}

class _ItemGridState extends State<ItemGrid> {
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
      width: double.infinity,
      height: 242,
      child: ScaleButton(
        onTap: () {
          if (ItemsData().savedItems.contains(widget.m)) {
            ItemsData().savedItems.remove(widget.m);
          } else {
            ItemsData().savedItems.add(widget.m);
          }
          setState(() {});
        },
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: color?.vibrantColor?.color.withOpacity(.2) ??
                      AppColors.cream,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Image.asset(
                        widget.m.image,
                        height: 120,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      widget.m.brand,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        height: .8,
                      ),
                    ),
                    Text(
                      widget.m.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: .9,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 15,
              right: 10,
              child: IconButton(
                icon: Icon(
                  ItemsData().savedItems.contains(widget.m)
                      ? Iconsax.heart5
                      : Iconsax.heart,
                  color: AppColors.black.withOpacity(.9),
                ),
                onPressed: () {
                  if (ItemsData().savedItems.contains(widget.m)) {
                    ItemsData().savedItems.remove(widget.m);
                  } else {
                    ItemsData().savedItems.add(widget.m);
                  }
                  setState(() {});
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
