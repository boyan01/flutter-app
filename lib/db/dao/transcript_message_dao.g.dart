// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transcript_message_dao.dart';

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$TranscriptMessageDaoMixin on DatabaseAccessor<MixinDatabase> {
  Conversations get conversations => attachedDatabase.conversations;
  FloodMessages get floodMessages => attachedDatabase.floodMessages;
  Jobs get jobs => attachedDatabase.jobs;
  MessageMentions get messageMentions => attachedDatabase.messageMentions;
  Messages get messages => attachedDatabase.messages;
  Participants get participants => attachedDatabase.participants;
  StickerAlbums get stickerAlbums => attachedDatabase.stickerAlbums;
  PinMessages get pinMessages => attachedDatabase.pinMessages;
  Addresses get addresses => attachedDatabase.addresses;
  Apps get apps => attachedDatabase.apps;
  Assets get assets => attachedDatabase.assets;
  CircleConversations get circleConversations =>
      attachedDatabase.circleConversations;
  Circles get circles => attachedDatabase.circles;
  Hyperlinks get hyperlinks => attachedDatabase.hyperlinks;
  MessagesFts get messagesFts => attachedDatabase.messagesFts;
  MessagesHistory get messagesHistory => attachedDatabase.messagesHistory;
  Offsets get offsets => attachedDatabase.offsets;
  ParticipantSession get participantSession =>
      attachedDatabase.participantSession;
  ResendSessionMessages get resendSessionMessages =>
      attachedDatabase.resendSessionMessages;
  SentSessionSenderKeys get sentSessionSenderKeys =>
      attachedDatabase.sentSessionSenderKeys;
  Snapshots get snapshots => attachedDatabase.snapshots;
  StickerRelationships get stickerRelationships =>
      attachedDatabase.stickerRelationships;
  Stickers get stickers => attachedDatabase.stickers;
  Users get users => attachedDatabase.users;
  TranscriptMessages get transcriptMessages =>
      attachedDatabase.transcriptMessages;
  Selectable<TranscriptMessageItem> baseTranscriptMessageItem(
      Expression<bool?> Function(
              TranscriptMessages transcript,
              Messages message,
              Users sender,
              Users sharedUser,
              Stickers sticker)
          where,
      Limit Function(TranscriptMessages transcript, Messages message,
              Users sender, Users sharedUser, Stickers sticker)
          limit) {
    final generatedwhere = $write(
        where(
            alias(this.transcriptMessages, 'transcript'),
            alias(this.messages, 'message'),
            alias(this.users, 'sender'),
            alias(this.users, 'sharedUser'),
            alias(this.stickers, 'sticker')),
        hasMultipleTables: true);
    final generatedlimit = $write(
        limit(
            alias(this.transcriptMessages, 'transcript'),
            alias(this.messages, 'message'),
            alias(this.users, 'sender'),
            alias(this.users, 'sharedUser'),
            alias(this.stickers, 'sticker')),
        hasMultipleTables: true);
    return customSelect(
        'SELECT transcript.transcript_id AS transcriptId, transcript.message_id AS messageId, message.conversation_id AS conversationId, transcript.category AS type, transcript.content AS content, transcript.created_at AS createdAt, message.status AS status, transcript.media_status AS mediaStatus, transcript.media_waveform AS mediaWaveform, transcript.media_name AS mediaName, transcript.media_mime_type AS mediaMimeType, transcript.media_size AS mediaSize, transcript.media_width AS mediaWidth, transcript.media_height AS mediaHeight, transcript.thumb_image AS thumbImage, transcript.thumb_url AS thumbUrl, transcript.media_url AS mediaUrl, transcript.media_duration AS mediaDuration, transcript.quote_id AS quoteId, transcript.quote_content AS quoteContent, transcript.shared_user_id AS sharedUserId, sender.user_id AS userId, IFNULL(sender.full_name, transcript.user_full_name) AS userFullName, sender.identity_number AS userIdentityNumber, sender.app_id AS appId, sender.relationship AS relationship, sender.avatar_url AS avatarUrl, sharedUser.full_name AS sharedUserFullName, sharedUser.identity_number AS sharedUserIdentityNumber, sharedUser.avatar_url AS sharedUserAvatarUrl, sharedUser.is_verified AS sharedUserIsVerified, sharedUser.app_id AS sharedUserAppId, sticker.asset_url AS assetUrl, sticker.asset_width AS assetWidth, sticker.asset_height AS assetHeight, sticker.sticker_id AS stickerId, sticker.name AS assetName, sticker.asset_type AS assetType FROM transcript_messages AS transcript INNER JOIN messages AS message ON message.message_id = transcript.transcript_id LEFT JOIN users AS sender ON transcript.user_id = sender.user_id LEFT JOIN users AS sharedUser ON transcript.shared_user_id = sharedUser.user_id LEFT JOIN stickers AS sticker ON sticker.sticker_id = transcript.sticker_id WHERE ${generatedwhere.sql} ORDER BY transcript.created_at, transcript."rowid" ${generatedlimit.sql}',
        variables: [
          ...generatedwhere.introducedVariables,
          ...generatedlimit.introducedVariables
        ],
        readsFrom: {
          transcriptMessages,
          messages,
          users,
          stickers,
          ...generatedwhere.watchedTables,
          ...generatedlimit.watchedTables,
        }).map((QueryRow row) {
      return TranscriptMessageItem(
        transcriptId: row.read<String>('transcriptId'),
        messageId: row.read<String>('messageId'),
        conversationId: row.read<String>('conversationId'),
        type: row.read<String>('type'),
        content: row.read<String?>('content'),
        createdAt: TranscriptMessages.$converter0
            .mapToDart(row.read<int>('createdAt'))!,
        status: Messages.$converter1.mapToDart(row.read<String>('status'))!,
        mediaStatus: TranscriptMessages.$converter1
            .mapToDart(row.read<String?>('mediaStatus')),
        mediaWaveform: row.read<String?>('mediaWaveform'),
        mediaName: row.read<String?>('mediaName'),
        mediaMimeType: row.read<String?>('mediaMimeType'),
        mediaSize: row.read<int?>('mediaSize'),
        mediaWidth: row.read<int?>('mediaWidth'),
        mediaHeight: row.read<int?>('mediaHeight'),
        thumbImage: row.read<String?>('thumbImage'),
        thumbUrl: row.read<String?>('thumbUrl'),
        mediaUrl: row.read<String?>('mediaUrl'),
        mediaDuration: row.read<String?>('mediaDuration'),
        quoteId: row.read<String?>('quoteId'),
        quoteContent: row.read<String?>('quoteContent'),
        sharedUserId: row.read<String?>('sharedUserId'),
        userId: row.read<String?>('userId'),
        userFullName: row.read<String?>('userFullName'),
        userIdentityNumber: row.read<String?>('userIdentityNumber'),
        appId: row.read<String?>('appId'),
        relationship:
            Users.$converter0.mapToDart(row.read<String?>('relationship')),
        avatarUrl: row.read<String?>('avatarUrl'),
        sharedUserFullName: row.read<String?>('sharedUserFullName'),
        sharedUserIdentityNumber: row.read<String?>('sharedUserIdentityNumber'),
        sharedUserAvatarUrl: row.read<String?>('sharedUserAvatarUrl'),
        sharedUserIsVerified: row.read<bool?>('sharedUserIsVerified'),
        sharedUserAppId: row.read<String?>('sharedUserAppId'),
        assetUrl: row.read<String?>('assetUrl'),
        assetWidth: row.read<int?>('assetWidth'),
        assetHeight: row.read<int?>('assetHeight'),
        stickerId: row.read<String?>('stickerId'),
        assetName: row.read<String?>('assetName'),
        assetType: row.read<String?>('assetType'),
      );
    });
  }
}

class TranscriptMessageItem {
  final String transcriptId;
  final String messageId;
  final String conversationId;
  final String type;
  final String? content;
  final DateTime createdAt;
  final MessageStatus status;
  final MediaStatus? mediaStatus;
  final String? mediaWaveform;
  final String? mediaName;
  final String? mediaMimeType;
  final int? mediaSize;
  final int? mediaWidth;
  final int? mediaHeight;
  final String? thumbImage;
  final String? thumbUrl;
  final String? mediaUrl;
  final String? mediaDuration;
  final String? quoteId;
  final String? quoteContent;
  final String? sharedUserId;
  final String? userId;
  final String? userFullName;
  final String? userIdentityNumber;
  final String? appId;
  final UserRelationship? relationship;
  final String? avatarUrl;
  final String? sharedUserFullName;
  final String? sharedUserIdentityNumber;
  final String? sharedUserAvatarUrl;
  final bool? sharedUserIsVerified;
  final String? sharedUserAppId;
  final String? assetUrl;
  final int? assetWidth;
  final int? assetHeight;
  final String? stickerId;
  final String? assetName;
  final String? assetType;
  TranscriptMessageItem({
    required this.transcriptId,
    required this.messageId,
    required this.conversationId,
    required this.type,
    this.content,
    required this.createdAt,
    required this.status,
    this.mediaStatus,
    this.mediaWaveform,
    this.mediaName,
    this.mediaMimeType,
    this.mediaSize,
    this.mediaWidth,
    this.mediaHeight,
    this.thumbImage,
    this.thumbUrl,
    this.mediaUrl,
    this.mediaDuration,
    this.quoteId,
    this.quoteContent,
    this.sharedUserId,
    this.userId,
    this.userFullName,
    this.userIdentityNumber,
    this.appId,
    this.relationship,
    this.avatarUrl,
    this.sharedUserFullName,
    this.sharedUserIdentityNumber,
    this.sharedUserAvatarUrl,
    this.sharedUserIsVerified,
    this.sharedUserAppId,
    this.assetUrl,
    this.assetWidth,
    this.assetHeight,
    this.stickerId,
    this.assetName,
    this.assetType,
  });
  @override
  int get hashCode => $mrjf($mrjc(
      transcriptId.hashCode,
      $mrjc(
          messageId.hashCode,
          $mrjc(
              conversationId.hashCode,
              $mrjc(
                  type.hashCode,
                  $mrjc(
                      content.hashCode,
                      $mrjc(
                          createdAt.hashCode,
                          $mrjc(
                              status.hashCode,
                              $mrjc(
                                  mediaStatus.hashCode,
                                  $mrjc(
                                      mediaWaveform.hashCode,
                                      $mrjc(
                                          mediaName.hashCode,
                                          $mrjc(
                                              mediaMimeType.hashCode,
                                              $mrjc(
                                                  mediaSize.hashCode,
                                                  $mrjc(
                                                      mediaWidth.hashCode,
                                                      $mrjc(
                                                          mediaHeight.hashCode,
                                                          $mrjc(
                                                              thumbImage
                                                                  .hashCode,
                                                              $mrjc(
                                                                  thumbUrl
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      mediaUrl
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          mediaDuration
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              quoteId.hashCode,
                                                                              $mrjc(quoteContent.hashCode, $mrjc(sharedUserId.hashCode, $mrjc(userId.hashCode, $mrjc(userFullName.hashCode, $mrjc(userIdentityNumber.hashCode, $mrjc(appId.hashCode, $mrjc(relationship.hashCode, $mrjc(avatarUrl.hashCode, $mrjc(sharedUserFullName.hashCode, $mrjc(sharedUserIdentityNumber.hashCode, $mrjc(sharedUserAvatarUrl.hashCode, $mrjc(sharedUserIsVerified.hashCode, $mrjc(sharedUserAppId.hashCode, $mrjc(assetUrl.hashCode, $mrjc(assetWidth.hashCode, $mrjc(assetHeight.hashCode, $mrjc(stickerId.hashCode, $mrjc(assetName.hashCode, assetType.hashCode))))))))))))))))))))))))))))))))))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TranscriptMessageItem &&
          other.transcriptId == this.transcriptId &&
          other.messageId == this.messageId &&
          other.conversationId == this.conversationId &&
          other.type == this.type &&
          other.content == this.content &&
          other.createdAt == this.createdAt &&
          other.status == this.status &&
          other.mediaStatus == this.mediaStatus &&
          other.mediaWaveform == this.mediaWaveform &&
          other.mediaName == this.mediaName &&
          other.mediaMimeType == this.mediaMimeType &&
          other.mediaSize == this.mediaSize &&
          other.mediaWidth == this.mediaWidth &&
          other.mediaHeight == this.mediaHeight &&
          other.thumbImage == this.thumbImage &&
          other.thumbUrl == this.thumbUrl &&
          other.mediaUrl == this.mediaUrl &&
          other.mediaDuration == this.mediaDuration &&
          other.quoteId == this.quoteId &&
          other.quoteContent == this.quoteContent &&
          other.sharedUserId == this.sharedUserId &&
          other.userId == this.userId &&
          other.userFullName == this.userFullName &&
          other.userIdentityNumber == this.userIdentityNumber &&
          other.appId == this.appId &&
          other.relationship == this.relationship &&
          other.avatarUrl == this.avatarUrl &&
          other.sharedUserFullName == this.sharedUserFullName &&
          other.sharedUserIdentityNumber == this.sharedUserIdentityNumber &&
          other.sharedUserAvatarUrl == this.sharedUserAvatarUrl &&
          other.sharedUserIsVerified == this.sharedUserIsVerified &&
          other.sharedUserAppId == this.sharedUserAppId &&
          other.assetUrl == this.assetUrl &&
          other.assetWidth == this.assetWidth &&
          other.assetHeight == this.assetHeight &&
          other.stickerId == this.stickerId &&
          other.assetName == this.assetName &&
          other.assetType == this.assetType);
  @override
  String toString() {
    return (StringBuffer('TranscriptMessageItem(')
          ..write('transcriptId: $transcriptId, ')
          ..write('messageId: $messageId, ')
          ..write('conversationId: $conversationId, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('status: $status, ')
          ..write('mediaStatus: $mediaStatus, ')
          ..write('mediaWaveform: $mediaWaveform, ')
          ..write('mediaName: $mediaName, ')
          ..write('mediaMimeType: $mediaMimeType, ')
          ..write('mediaSize: $mediaSize, ')
          ..write('mediaWidth: $mediaWidth, ')
          ..write('mediaHeight: $mediaHeight, ')
          ..write('thumbImage: $thumbImage, ')
          ..write('thumbUrl: $thumbUrl, ')
          ..write('mediaUrl: $mediaUrl, ')
          ..write('mediaDuration: $mediaDuration, ')
          ..write('quoteId: $quoteId, ')
          ..write('quoteContent: $quoteContent, ')
          ..write('sharedUserId: $sharedUserId, ')
          ..write('userId: $userId, ')
          ..write('userFullName: $userFullName, ')
          ..write('userIdentityNumber: $userIdentityNumber, ')
          ..write('appId: $appId, ')
          ..write('relationship: $relationship, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('sharedUserFullName: $sharedUserFullName, ')
          ..write('sharedUserIdentityNumber: $sharedUserIdentityNumber, ')
          ..write('sharedUserAvatarUrl: $sharedUserAvatarUrl, ')
          ..write('sharedUserIsVerified: $sharedUserIsVerified, ')
          ..write('sharedUserAppId: $sharedUserAppId, ')
          ..write('assetUrl: $assetUrl, ')
          ..write('assetWidth: $assetWidth, ')
          ..write('assetHeight: $assetHeight, ')
          ..write('stickerId: $stickerId, ')
          ..write('assetName: $assetName, ')
          ..write('assetType: $assetType')
          ..write(')'))
        .toString();
  }
}