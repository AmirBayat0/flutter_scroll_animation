import 'package:flutter/material.dart';
import 'package:flutter_scroll_animation/models/jewellery.dart';
import 'package:flutter_scroll_animation/repository/jewellery_repository.dart';
import 'package:remixicon/remixicon.dart';

class FinalView extends StatefulWidget {
  const FinalView({Key? key}) : super(key: key);

  @override
  _FinalViewState createState() => _FinalViewState();
}

class _FinalViewState extends State<FinalView> {
  /// Categories keys
  final List<GlobalKey> jewelleryCategories = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];

  /// Scroll Controller
  late ScrollController scrollController;

  /// Tab Context
  BuildContext? tabContext;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(animateToTab);
    super.initState();
  }

  /// Animate To Tab
  void animateToTab() {
    late RenderBox box;

    for (var i = 0; i < jewelleryCategories.length; i++) {
      box = jewelleryCategories[i].currentContext!.findRenderObject()
          as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);

      if (scrollController.offset >= position.dy) {
        DefaultTabController.of(tabContext!).animateTo(
          i,
          duration: const Duration(milliseconds: 100),
        );
      }
    }
  }

  /// Scroll to Index
  void scrollToIndex(int index) async {
    scrollController.removeListener(animateToTab);
    final categories = jewelleryCategories[index].currentContext!;
    await Scrollable.ensureVisible(
      categories,
      duration: const Duration(milliseconds: 600),
    );
    scrollController.addListener(animateToTab);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Builder(
        builder: (BuildContext context) {
          tabContext = context;
          return Scaffold(
            appBar: _buildAppBar(),
            body: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  /// Earnings Title - Content
                  _buildCategoryTitle('Earnings', 0),
                  _buildItemList(JewelleryRepository.earnings),

                  /// Ring Title - Content
                  _buildCategoryTitle('Ring', 1),
                  _buildItemList(JewelleryRepository.ring),

                  /// Diamonds Title - Content
                  _buildCategoryTitle('Diamond', 2),
                  _buildItemList(JewelleryRepository.diamond),

                  /// Empty Bottom space
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// AppBar
  AppBar _buildAppBar() {
    return AppBar(
      leading:
          IconButton(onPressed: () {}, icon: const Icon(Remix.menu_2_line)),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Remix.search_line,
          ),
        )
      ],
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Purchase your Jewellery in a minute with',
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          Text(
            'JewellGo',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
            ),
          )
        ],
      ),
      bottom: TabBar(
        tabs: const [
          Tab(child: Text('Earnings')),
          Tab(child: Text('Ring')),
          Tab(child: Text('Diamond')),
        ],
        onTap: (int index) => scrollToIndex(index),
      ),
    );
  }

  /// Item Lists
  Widget _buildItemList(List<JewelleryModel> categories) {
    return Column(
      children: categories.map((m3) => _buildSingleItem(m3)).toList(),
    );
  }

  /// Single Product item widget
  Widget _buildSingleItem(JewelleryModel item) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 160,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Image.network(
                    item.image,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          item.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade600),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "€${item.price}",
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "€${item.price + 26.07}",
                                    style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 13,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                              const Icon(Remix.arrow_right_s_line)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  /// Category Title
  Widget _buildCategoryTitle(String title, int index) {
    return Padding(
      key: jewelleryCategories[index],
      padding: const EdgeInsets.only(top: 14, right: 12, left: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View more',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      color: Colors.indigo),
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
