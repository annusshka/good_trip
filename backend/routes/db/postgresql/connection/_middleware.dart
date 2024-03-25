import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

Handler middleware(Handler handler) {
  return (context) async {
    final conn = await Connection.open(Endpoint(
      host: '5432:5432',
      database: 'trip_db',
      username: 'localguide',
      password: '1234',
    ));

    final response = await handler
        .use(provider((_) => conn))
        .call(context);

    await conn.close();

    return response;
  };
}
