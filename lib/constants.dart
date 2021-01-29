import 'dart:ui';

const systemUser = '00000000-0000-0000-0000-000000000000';

const scp =
    'PROFILE:READ PROFILE:WRITE PHONE:READ PHONE:WRITE CONTACTS:READ CONTACTS:WRITE MESSAGES:READ MESSAGES:WRITE ASSETS:READ SNAPSHOTS:READ CIRCLES:READ CIRCLES:WRITE';

const acknowledgeMessageReceipts = 'ACKNOWLEDGE_MESSAGE_RECEIPTS';
const sendingMessage = 'SENDING_MESSAGE';
const resendMessages = 'RESEND_MESSAGES';
const createMessage = 'CREATE_MESSAGE';
const resendKey = 'RESEND_KEY';

class MessageCategory {
  static const String signalKey = 'SIGNAL_KEY';
  static const String signalText = 'SIGNAL_TEXT';
  static const String signalImage = 'SIGNAL_IMAGE';
  static const String signalVideo = 'SIGNAL_VIDEO';
  static const String signalSticker = 'SIGNAL_STICKER';
  static const String signalData = 'SIGNAL_DATA';
  static const String signalContact = 'SIGNAL_CONTACT';
  static const String signalAudio = 'SIGNAL_AUDIO';
  static const String signalLive = 'SIGNAL_LIVE';
  static const String signalPost = 'SIGNAL_POST';
  static const String signalLocation = 'SIGNAL_LOCATION';
  static const String plainText = 'PLAIN_TEXT';
  static const String plainImage = 'PLAIN_IMAGE';
  static const String plainVideo = 'PLAIN_VIDEO';
  static const String plainData = 'PLAIN_DATA';
  static const String plainSticker = 'PLAIN_STICKER';
  static const String plainContact = 'PLAIN_CONTACT';
  static const String plainAudio = 'PLAIN_AUDIO';
  static const String plainLive = 'PLAIN_LIVE';
  static const String plainPost = 'PLAIN_POST';
  static const String plainJson = 'PLAIN_JSON';
  static const String plainLocation = 'PLAIN_LOCATION';
  static const String messageRecall = 'MESSAGE_RECALL';
  static const String appButtonGroup = 'APP_BUTTON_GROUP';
  static const String appCard = 'APP_CARD';
  static const String systemConversation = 'SYSTEM_CONVERSATION';
  static const String systemUser = 'SYSTEM_USER';
  static const String systemCircle = 'SYSTEM_CIRCLE';
  static const String systemSession = 'SYSTEM_SESSION';
  static const String systemAccountSnapshot = 'SYSTEM_ACCOUNT_SNAPSHOT';
}

final circleColors = [
  const Color(0xFF8E7BFF),
  const Color(0xFF657CFB),
  const Color(0xFFA739C2),
  const Color(0xFFBD6DDA),
  const Color(0xFFFD89F1),
  const Color(0xFFFA7B95),
  const Color(0xFFE94156),
  const Color(0xFFFA9652),
  const Color(0xFFF1D22B),
  const Color(0xFFBAE361),
  const Color(0xFF5EDD5E),
  const Color(0xFF4BE6FF),
  const Color(0xFF45B7FE),
  const Color(0xFF00ECD0),
  const Color(0xFFFFCCC0),
  const Color(0xFFCEA06B)
];

final avatarColors = [
  const Color(0xFFFFD659),
  const Color(0xFFFFC168),
  const Color(0xFFF58268),
  const Color(0xFFF4979C),
  const Color(0xFFEC7F87),
  const Color(0xFFFF78CB),
  const Color(0xFFC377E0),
  const Color(0xFF8BAAFF),
  const Color(0xFF78DCFA),
  const Color(0xFF88E5B9),
  const Color(0xFFBFF199),
  const Color(0xFFC5E1A5),
  const Color(0xFFCD907D),
  const Color(0xFFBE938E),
  const Color(0xFFB68F91),
  const Color(0xFFBC987B),
  const Color(0xFFA69E8E),
  const Color(0xFFD4C99E),
  const Color(0xFF93C2E6),
  const Color(0xFF92C3D9),
  const Color(0xFF8FBFC5),
  const Color(0xFF80CBC4),
  const Color(0xFFA4DBDB),
  const Color(0xFFB2C8BD),
  const Color(0xFFF7C8C9),
  const Color(0xFFDCC6E4),
  const Color(0xFFBABAE8),
  const Color(0xFFBABCD5),
  const Color(0xFFAD98DA),
  const Color(0xFFC097D9)
];

final nameColors = [
  const Color(0xFF8C8DFF),
  const Color(0xFF7983C2),
  const Color(0xFF6D8DDE),
  const Color(0xFF5979F0),
  const Color(0xFF6695DF),
  const Color(0xFF8F7AC5),
  const Color(0xFF9D77A5),
  const Color(0xFF8A64D0),
  const Color(0xFFAA66C3),
  const Color(0xFFA75C96),
  const Color(0xFFC8697D),
  const Color(0xFFB74D62),
  const Color(0xFFBD637C),
  const Color(0xFFB3798E),
  const Color(0xFF9B6D77),
  const Color(0xFFB87F7F),
  const Color(0xFFC5595A),
  const Color(0xFFAA4848),
  const Color(0xFFB0665E),
  const Color(0xFFB76753),
  const Color(0xFFBB5334),
  const Color(0xFFC97B46),
  const Color(0xFFBE6C2C),
  const Color(0xFFCB7F40),
  const Color(0xFFA47758),
  const Color(0xFFB69370),
  const Color(0xFFA49373),
  const Color(0xFFAA8A46),
  const Color(0xFFAA8220),
  const Color(0xFF76A048),
  const Color(0xFF9CAD23),
  const Color(0xFFA19431),
  const Color(0xFFAA9100),
  const Color(0xFFA09555),
  const Color(0xFFC49B4B),
  const Color(0xFF5FB05F),
  const Color(0xFF6AB48F),
  const Color(0xFF71B15C),
  const Color(0xFFB3B357),
  const Color(0xFFA3B561),
  const Color(0xFF909F45),
  const Color(0xFF93B289),
  const Color(0xFF3D98D0),
  const Color(0xFF429AB6),
  const Color(0xFF4EABAA),
  const Color(0xFF6BC0CE),
  const Color(0xFF64B5D9),
  const Color(0xFF3E9CCB),
  const Color(0xFF2887C4),
  const Color(0xFF52A98B)
];
