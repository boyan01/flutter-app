import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_converter.dart';
import 'package:flutter_app/constants/resources.dart';
import 'package:flutter_app/ui/home/bloc/multi_auth_cubit.dart';
import 'package:flutter_app/ui/home/bloc/slide_category_cubit.dart';
import 'package:flutter_app/widgets/brightness_observer.dart';
import 'package:flutter_app/widgets/dialog.dart';
import 'package:flutter_app/widgets/select_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter_app/generated/l10n.dart';

class SlidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SizedBox(
        width: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 64),
            const _Title(data: 'People'),
            const SizedBox(height: 12),
            _CategoryList(categoryList: [
              {
                'asset': Resources.assetsImagesContactsPng,
                'title': Localization.of(context).contacts,
              },
              {
                'asset': Resources.assetsImagesGroupPng,
                'title': Localization.of(context).group,
              },
              {
                'asset': Resources.assetsImagesBotPng,
                'title': Localization.current.bots
              },
              {
                'asset': Resources.assetsImagesStrangersPng,
                'title': Localization.of(context).strangers,
              },
            ]),
            const SizedBox(height: 16),
            _Title(data: Localization.of(context).circle),
            const SizedBox(height: 12),
            const _CircleList(),
            // todo user profile callback
            Builder(
              builder: (context) => BlocConverter<MultiAuthCubit,
                  MultiAuthState, Tuple2<String, String>>(
                converter: (state) => Tuple2(state.current?.account?.fullName,
                    state.current?.account?.avatarUrl),
                when: (a, b) => b.item1 != null && b.item2 != null,
                builder: (context, tuple) =>
                    BlocConverter<SlideCategoryCubit, SlideCategoryState, bool>(
                  converter: (state) =>
                      state?.type == SlideCategoryType.setting,
                  builder: (context, selected) => SelectItem(
                    icon: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: tuple.item2,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    title: tuple.item1,
                    selected: selected,
                    onTap: () => BlocProvider.of<SlideCategoryCubit>(context)
                        .select(SlideCategoryType.setting),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
          ]),
        ),
      );
}

class _CircleList extends StatelessWidget {
  const _CircleList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        // todo circle list callback
        child: Builder(builder: (context) {
          const circleType = [
            {
              'asset': Resources.assetsImagesCirclePng,
              'title': 'Mixin',
            },
          ];
          return ListView.separated(
            itemCount: 1,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 8),
            itemBuilder: (BuildContext context, int index) =>
                BlocConverter<SlideCategoryCubit, SlideCategoryState, bool>(
              converter: (state) =>
                  state?.type == SlideCategoryType.people &&
                  state?.name == circleType[index]['title'],
              builder: (BuildContext context, bool selected) {
                final circle = circleType[index];
                return SelectItem(
                  icon: Image.asset(
                    circle['asset'],
                    width: 24,
                    height: 24,
                    color: BrightnessData.dynamicColor(
                      context,
                      const Color.fromRGBO(65, 145, 255, 1),
                    ),
                  ),
                  title: circle['title'],
                  onTap: () =>
                      BlocProvider.of<SlideCategoryCubit>(context).select(
                    SlideCategoryType.people,
                    circle['title'],
                  ),
                  selected: selected,
                  count: 99,
                  onRightClick: (pointerUpEvent) async {
                    final result = await showContextMenu(
                      context: context,
                      pointerPosition: pointerUpEvent.position,
                      menus: [
                        ContextMenu(
                          title: Localization.of(context).editCircleName,
                        ),
                        ContextMenu(
                          title: Localization.of(context).editConversations,
                        ),
                        ContextMenu(
                          title: Localization.of(context).deleteCircle,
                          isDestructiveAction: true,
                          value: () {
                            showMixinDialog(
                              context: context,
                              child: AlertDialogLayout(
                                content: Text(Localization.of(context)
                                    .pageDeleteCircle(circle['title'])),
                                actions: [
                                  MixinButton(
                                    backgroundTransparent: true,
                                    child:
                                        Text(Localization.of(context).cancel),
                                  ),
                                  MixinButton(
                                    child:
                                        Text(Localization.of(context).delete),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    );
                    result?.call();
                  },
                );
              },
            ),
          );
        }),
      );
}

class _CategoryList extends StatelessWidget {
  const _CategoryList({
    Key key,
    @required this.categoryList,
  }) : super(key: key);

  final List<Map<String, String>> categoryList;

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final item = categoryList[index];
          return BlocConverter<SlideCategoryCubit, SlideCategoryState, bool>(
            converter: (state) =>
                state?.type == SlideCategoryType.people &&
                state?.name == item['title'],
            builder: (BuildContext context, bool selected) => SelectItem(
              icon: Image.asset(
                item['asset'],
                width: 24,
                height: 24,
                color: BrightnessData.dynamicColor(
                  context,
                  const Color.fromRGBO(51, 51, 51, 1),
                  darkColor: const Color.fromRGBO(255, 255, 255, 0.9),
                ),
              ),
              title: item['title'],
              onTap: () => BlocProvider.of<SlideCategoryCubit>(context).select(
                SlideCategoryType.people,
                item['title'],
              ),
              selected: selected,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 8),
        itemCount: categoryList.length,
      );
}

class _Title extends StatelessWidget {
  const _Title({
    Key key,
    this.data,
  }) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          data,
          style: TextStyle(
            color: BrightnessData.dynamicColor(
              context,
              const Color.fromRGBO(51, 51, 51, 0.3),
              darkColor: const Color.fromRGBO(255, 255, 255, 0.3),
            ),
          ),
        ),
      );
}