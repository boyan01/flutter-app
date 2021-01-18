import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_converter.dart';
import 'package:flutter_app/constants/resources.dart';
import 'package:flutter_app/db/mixin_database.dart';
import 'package:flutter_app/db/extension/conversation.dart';
import 'package:flutter_app/ui/home/bloc/conversation_cubit.dart';
import 'package:flutter_app/ui/home/bloc/conversation_list_bloc.dart';
import 'package:flutter_app/bloc/paging/paging_bloc.dart';
import 'package:flutter_app/ui/home/bloc/multi_auth_cubit.dart';
import 'package:flutter_app/ui/home/bloc/slide_category_cubit.dart';
import 'package:flutter_app/ui/home/route/responsive_navigator_cubit.dart';
import 'package:flutter_app/utils/datetime_format_utils.dart';
import 'package:flutter_app/utils/list_utils.dart';
import 'package:flutter_app/widgets/avatar_view.dart';
import 'package:flutter_app/widgets/brightness_observer.dart';
import 'package:flutter_app/widgets/dialog.dart';
import 'package:flutter_app/widgets/interacter_decorated_box.dart';
import 'package:flutter_app/widgets/message_status_icon.dart';
import 'package:flutter_app/widgets/search_bar.dart';
import 'package:flutter_app/widgets/unread_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_app/generated/l10n.dart';

class ConversationPage extends StatelessWidget {
  const ConversationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: BrightnessData.dynamicColor(
        context,
        const Color.fromRGBO(255, 255, 255, 1),
        darkColor: const Color.fromRGBO(44, 49, 54, 1),
      ),
      child: Column(
        children: [
          const SearchBar(),
          Expanded(
            child: BlocConverter<ConversationListBloc,
                PagingState<ConversationItem>, int>(
              converter: (state) => state?.list?.length ?? 0,
              builder: (context, itemCount) {
                if (itemCount == 0) return _Empty();
                return _List(itemCount: itemCount);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dynamicColor = BrightnessData.dynamicColor(
      context,
      const Color.fromRGBO(229, 233, 240, 1),
    );
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        SvgPicture.asset(
          Resources.assetsImagesConversationEmptySvg,
          height: 78,
          width: 58,
          color: dynamicColor,
        ),
        const SizedBox(height: 24),
        Text(
          Localization.of(context).noData,
          style: TextStyle(
            color: dynamicColor,
            fontSize: 14,
          ),
        ),
      ]),
    );
  }
}

class _List extends StatelessWidget {
  const _List({
    Key key,
    this.itemCount,
  }) : super(key: key);

  final int itemCount;

  @override
  Widget build(BuildContext context) =>
      NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          final dimension =
              max(notification.metrics.viewportDimension / 2, 300);
          final bloc = BlocProvider.of<ConversationListBloc>(context);
          if (notification.metrics.pixels >
                  notification.metrics.maxScrollExtent - dimension &&
              !bloc.state.noMoreData) {
            bloc.loadBefore();
          }
          return false;
        },
        child: BlocBuilder<SlideCategoryCubit, SlideCategoryState>(
          builder: (context, slideCategoryState) => ListView.builder(
            key: PageStorageKey(slideCategoryState),
            itemCount: itemCount,
            itemBuilder: (BuildContext context, int index) => BlocConverter<
                ConversationListBloc,
                PagingState<ConversationItem>,
                ConversationItem>(
              converter: (state) => state.list[index],
              builder: (context, conversation) =>
                  BlocConverter<ConversationCubit, ConversationItem, bool>(
                converter: (state) =>
                    conversation?.conversationId == state?.conversationId,
                builder: (context, selected) => _Item(
                  selected: selected,
                  conversation: conversation,
                  onTap: () {
                    BlocProvider.of<ConversationCubit>(context)
                        .emit(conversation);
                    ResponsiveNavigatorCubit.of(context)
                        .pushPage(ResponsiveNavigatorCubit.chatPage);
                  },
                  onRightClick: (pointerUpEvent) => showContextMenu(
                    context: context,
                    pointerPosition: pointerUpEvent.position,
                    menus: [
                      ContextMenu(
                        title: Localization.of(context).pin,
                      ),
                      ContextMenu(
                        title: Localization.of(context).unMute,
                      ),
                      ContextMenu(
                        title: Localization.of(context).deleteChat,
                        isDestructiveAction: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class _Item extends StatelessWidget {
  const _Item({
    Key key,
    this.selected = false,
    @required this.conversation,
    this.onTap,
    this.onRightClick,
  }) : super(key: key);

  final bool selected;
  final ConversationItem conversation;
  final VoidCallback onTap;
  final ValueChanged<PointerUpEvent> onRightClick;

  @override
  Widget build(BuildContext context) {
    final messageColor = BrightnessData.dynamicColor(
      context,
      const Color.fromRGBO(184, 189, 199, 1),
      darkColor: const Color.fromRGBO(255, 255, 255, 0.4),
    );
    return InteractableDecoratedBox(
      onTap: onTap,
      onRightClick: onRightClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: DecoratedBox(
          decoration: selected
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: BrightnessData.dynamicColor(
                    context,
                    const Color.fromRGBO(246, 247, 250, 1),
                    darkColor: const Color.fromRGBO(255, 255, 255, 0.06),
                  ),
                )
              : const BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: AvatarsWidget(
                    size: 50,
                    avatars: [
                      conversation.groupIconUrl ?? conversation.avatarUrl
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                conversation.name,
                                style: TextStyle(
                                  color: BrightnessData.dynamicColor(
                                    context,
                                    const Color.fromRGBO(51, 51, 51, 1),
                                    darkColor: const Color.fromRGBO(
                                        255, 255, 255, 0.9),
                                  ),
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              convertStringTime(
                                  conversation.lastMessageCreatedAt ??
                                      conversation.createdAt),
                              style: TextStyle(
                                color: messageColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                          child: Row(
                            children: [
                              Expanded(
                                child: _MessagePreview(
                                  messageColor: messageColor,
                                  conversation: conversation,
                                ),
                              ),
                              if (conversation.unseenMessageCount ?? 0 > 0)
                                _UnreadText(conversation: conversation),
                              if (conversation.unseenMessageCount ?? 0 <= 0)
                                _StatusRow(conversation: conversation),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({Key key, this.conversation}) : super(key: key);
  final ConversationItem conversation;

  @override
  Widget build(BuildContext context) {
    final dynamicColor = BrightnessData.dynamicColor(
      context,
      const Color.fromRGBO(229, 231, 235, 1),
      darkColor: const Color.fromRGBO(255, 255, 255, 0.4),
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: joinList(
        [
          if (conversation.muteUntil?.isAfter(DateTime.now()) == true)
            SvgPicture.asset(
              Resources.assetsImagesMuteSvg,
              color: dynamicColor,
            ),
          if (conversation.pinTime?.isAfter(DateTime.now()) == true)
            SvgPicture.asset(
              Resources.assetsImagesPinSvg,
              color: dynamicColor,
            ),
        ],
        const SizedBox(width: 4),
      ),
    );
  }
}

class _UnreadText extends StatelessWidget {
  const _UnreadText({
    Key key,
    @required this.conversation,
  }) : super(key: key);

  final ConversationItem conversation;

  @override
  Widget build(BuildContext context) {
    return UnreadText(
      count: conversation.unseenMessageCount ?? 0,
      backgroundColor: conversation.pinTime?.isAfter(DateTime.now()) == true
          ? BrightnessData.dynamicColor(
              context,
              const Color.fromRGBO(61, 117, 227, 1),
              darkColor: const Color.fromRGBO(65, 145, 255, 1),
            )
          : BrightnessData.dynamicColor(
              context,
              const Color.fromRGBO(184, 189, 199, 1),
              darkColor: const Color.fromRGBO(255, 255, 255, 0.4),
            ),
      textColor: conversation.pinTime != null
          ? BrightnessData.dynamicColor(
              context,
              const Color.fromRGBO(255, 255, 255, 1),
              darkColor: const Color.fromRGBO(255, 255, 255, 1),
            )
          : BrightnessData.dynamicColor(
              context,
              const Color.fromRGBO(255, 255, 255, 1),
              darkColor: const Color.fromRGBO(44, 49, 54, 1),
            ),
    );
  }
}

class _MessagePreview extends StatelessWidget {
  const _MessagePreview({
    Key key,
    @required this.messageColor,
    @required this.conversation,
  }) : super(key: key);

  final Color messageColor;
  final ConversationItem conversation;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _MessageStatusIcon(conversation: conversation),
          Expanded(
            child: _MessageContent(conversation: conversation),
          ),
        ],
      );
}

class _MessageContent extends StatelessWidget {
  const _MessageContent({Key key, this.conversation}) : super(key: key);
  final ConversationItem conversation;

  @override
  Widget build(BuildContext context) {
    final dynamicColor = BrightnessData.dynamicColor(
      context,
      const Color.fromRGBO(184, 189, 199, 1),
      darkColor: const Color.fromRGBO(255, 255, 255, 0.4),
    );
    String icon;
    String content;

    if (conversation.messageStatus == 'FAILED') {
      icon = Resources.assetsImagesSendingSvg;
      content = Localization.of(context).waitingForThisMessage;
    } else if (conversation.isText) {
      // todo markdown and mention
      content = conversation.content;
    } else if (conversation.contentType == 'SYSTEM_ACCOUNT_SNAPSHOT') {
      content = '[${Localization.of(context).transfer}]';
      icon = Resources.assetsImagesTransferSvg;
    } else if (conversation.isSticker) {
      content = '[${Localization.of(context).sticker}]';
      icon = Resources.assetsImagesStickerSvg;
    } else if (conversation.isImage) {
      content = '[${Localization.of(context).image}]';
      icon = Resources.assetsImagesImageSvg;
    } else if (conversation.isVideo) {
      content = '[${Localization.of(context).video}]';
      icon = Resources.assetsImagesVideoSvg;
    } else if (conversation.isLive) {
      content = '[${Localization.of(context).live}]';
      icon = Resources.assetsImagesLiveSvg;
    } else if (conversation.isData) {
      content = '[${Localization.of(context).file}]';
      icon = Resources.assetsImagesFileSvg;
    } else if (conversation.isPost) {
      icon = Resources.assetsImagesFileSvg;
      // todo
      content = 'post';
    } else if (conversation.isLocation) {
      content = '[${Localization.of(context).location}]';
      // icon = Resources.assetsImagesLocationSvg;
    } else if (conversation.isAudio) {
      content = '[${Localization.of(context).audio}]';
      icon = Resources.assetsImagesAudioSvg;
    } else if (conversation.contentType == 'APP_BUTTON_GROUP') {
      // todo
      content = 'APP_BUTTON_GROUP';
      icon = Resources.assetsImagesAppButtonSvg;
    } else if (conversation.contentType == 'APP_CARD') {
      content = 'APP_CARD';
      icon = Resources.assetsImagesAppButtonSvg;
    } else if (conversation.isContact) {
      content = '[${Localization.of(context).contact}]';
      icon = Resources.assetsImagesContactSvg;
    } else if (conversation.isCallMessage) {
      content = '[${Localization.of(context).videoCall}]';
      icon = Resources.assetsImagesVideoCallSvg;
    } else if (conversation.isRecall) {
      // todo
      // content = '[${Localization.of(context).recall}]';
      icon = Resources.assetsImagesRecallSvg;
    } else if (conversation.isGroupCall) {
// todo
    }

    return Row(
      children: joinList(
        [
          if (icon != null)
            SvgPicture.asset(
              icon,
              color: dynamicColor,
            ),
          Expanded(
            child: Text(
              content,
              style: TextStyle(
                color: dynamicColor,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
        const SizedBox(width: 4),
      ),
    );
  }
}

class _MessageStatusIcon extends StatelessWidget {
  const _MessageStatusIcon({Key key, this.conversation}) : super(key: key);

  final ConversationItem conversation;

  @override
  Widget build(BuildContext context) {
    if (MultiAuthCubit.of(context)?.state?.current?.account?.userId ==
            conversation.messageStatus &&
        conversation.contentType != 'SYSTEM_CONVERSATION' &&
        conversation.contentType != 'SYSTEM_ACCOUNT_SNAPSHOT' &&
        !conversation.isCallMessage &&
        !conversation.isRecall &&
        !conversation.isGroupCall) {
      return MessageStatusIcon(status: conversation.messageStatus);
    }
    return const SizedBox();
  }
}
