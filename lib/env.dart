import 'package:flutter_dotenv/flutter_dotenv.dart';
final environment = {
  'baseApiUrl': DotEnv().env['BASE_API_URL'],
};


