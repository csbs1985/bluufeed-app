import 'package:algolia/algolia.dart';

class AlgoliaConfig {
  static const Algolia algoliaHistoria = Algolia.init(
    applicationId: 'LJOI61CXTQ',
    apiKey: '94112e99e64dced010b4756aad693e47',
  );

  static const Algolia algoliaUsuario = Algolia.init(
    applicationId: 'I8DSIVIJK9',
    apiKey: 'd39e544b036bf505a7e40c0277630b01',
  );
}
