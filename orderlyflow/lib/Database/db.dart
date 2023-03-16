// ignore_for_file: unnecessary_new

import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:mongo_dart/mongo_dart.dart' as Mongo;
import 'package:mongo_dart/mongo_dart.dart';
import 'package:orderlyflow/Database/textControllers.dart';
import 'constant.dart';
import 'dart:typed_data';
import 'package:bson/bson.dart';
import 'db.dart';
import 'dart:developer';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'package:bson/bson.dart';
import 'package:email_auth/email_auth.dart';

var db;
var collection;

class MongoDB {
  static connect() async {
    db = await Mongo.Db.create(mongoDB_URL);
    final collectionName = db.collection("Personnel");
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    print(status);
  }

  static Future<Map<String, dynamic>> getInfo() async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(personsCol);
    await db1.open();

    var IDCont = int.parse(StoreController.ID_controller.value.text.trim());
    final information = await coll.findOne(Mongo.where.eq("ID", IDCont))
        as Map<String, dynamic>;
    return information;

    //await db.close();
  }

  static Future<Map<String, dynamic>> getID() async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(personsCol);
    await db1.open();

    var IDCont = int.parse(StoreController.ID_controller.value.text.trim());
    final id_info = await coll.findOne(Mongo.where.eq("ID", IDCont))
        as Map<String, dynamic>;
    if (id_info != null) {
      StoreController.ID_found.value = true;
      return id_info;
    } else {
      return StoreController.ID_controller.update((val) {
        "ID not found";
      }) as Map<String, dynamic>;
    }
    //await db.close();
  }

  static Future<Map<String, dynamic>> getPassword() async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(personsCol);
    await db1.open();

    var PassCont = int.parse(StoreController.Pass_controller.value.text.trim());
    final password = await coll.findOne(Mongo.where.eq("password", PassCont))
        as Map<String, dynamic>;

    if (password != null) {
      StoreController.Pass_found.value = true;
      return password;
    } else {
      return StoreController.ID_controller.update((val) {
        "Password is incorrect";
      }) as Map<String, dynamic>;
    }

    //await db.close();
  }

  static Future<Map<String, dynamic>> getOTP() async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(personsCol);
    await db1.open();

    var OTPCont = int.parse(StoreController.OTP_controller.value.text.trim());
    final otp_info = await coll.findOne(Mongo.where.eq("OTP", OTPCont))
        as Map<String, dynamic>;
    if (otp_info != null) {
      StoreController.OTP_found.value = true;
      return otp_info;
    } else {
      return StoreController.OTP_controller.update((val) {
        "OTP is incorrect";
      }) as Map<String, dynamic>;

      //await db.close();
    }
  }

  static Future<Map<String, dynamic>> Verify_LogIn() async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(personsCol);
    await db1.open();
    var OTPCont = int.parse(StoreController.OTP_controller.value.text.trim());
    var PassCont = int.parse(StoreController.Pass_controller.value.text.trim());
    var IDCont = int.parse(StoreController.ID_controller.value.text.trim());
    final id_info = await coll.findOne(Mongo.where.eq("ID", IDCont));
    if (id_info != null &&
        id_info['OTP'] == OTPCont &&
        id_info['password'] == PassCont) {
      StoreController.Login_found.value = true;
      return id_info as Map<String, dynamic>;
    } else {
      return "Please check your credentials" as Map<String, dynamic>;
    }
  }

  static Future<Uint8List> getProfilePic() async {
    final collection = db.collection("fs.chunks");
    final document = await collection.findOne(Mongo.where.eq("n", 0));
    final photoData = document['data'];

    /*var gridFS = GridFS(db);
    var file = await gridFS.findOne(where.eq('n', 0));
    var stream = await file.download();
    var bytes = await consolidateHttpClientResponseBytes(stream);

    // Convert the image to a Flutter Image widget
    var image = Uint8List.fromList(bytes);
    */

    //Uint8List photo = Uint8List.fromList(photoData);
    //ByteBuffer byteBuffer = photo.buffer;
    //List<int> imageBytes = await photoData.buffer.asInt8List();
    //////////////////////////////////////////WORKS///////////////////// bas can't access
    /////////////////////gridfs
    //GridFS bucket = GridFS(db, collection);

    //Uint8List pic = base64Decode(img["data"]);
    Uint8List bsonBytes = base64Decode(
        "/9j/4AAQSkZJRgABAQAAAQABAAD/4gHYSUNDX1BST0ZJTEUAAQEAAAHIAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAACRyWFlaAAABFAAAABRnWFlaAAABKAAAABRiWFlaAAABPAAAABR3dHB0AAABUAAAABRyVFJDAAABZAAAAChnVFJDAAABZAAAAChiVFJDAAABZAAAAChjcHJ0AAABjAAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAAgAAAAcAHMAUgBHAEJYWVogAAAAAAAAb6IAADj1AAADkFhZWiAAAAAAAABimQAAt4UAABjaWFlaIAAAAAAAACSgAAAPhAAAts9YWVogAAAAAAAA9tYAAQAAAADTLXBhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABtbHVjAAAAAAAAAAEAAAAMZW5VUwAAACAAAAAcAEcAbwBvAGcAbABlACAASQBuAGMALgAgADIAMAAxADb/2wBDAAMCAgICAgMCAgIDAwMDBAYEBAQEBAgGBgUGCQgKCgkICQkKDA8MCgsOCwkJDRENDg8QEBEQCgwSExIQEw8QEBD/2wBDAQMDAwQDBAgEBAgQCwkLEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBD/wAARCAIAAgADASIAAhEBAxEB/8QAHQABAAEFAQEBAAAAAAAAAAAAAAkEBQYHCAMCAf/EAFIQAAEDAwIDBAUEDggEAwkAAAABAgMEBQYHERIhMQhBUWEJExQicTJygbMVIzM2N0JSdoORkqGxtBYkQ1NidYLBNHOT0aSy4SVEVGaio8LE0v/EABsBAQACAwEBAAAAAAAAAAAAAAADBAECBgUH/8QAOxEBAAEDAQUDCQcCBwEAAAAAAAECAxEEBRIhMUEGUXETIjJhgZGhsdEUMzRCcrLBNWIHFSMkUuHwwv/aAAwDAQACEQMRAD8Ak9AAAAAAAAAAAAAAAAAAAAAAAAAAAAx7OdQ8K01sr8hzrJKOz0LVVGvnf78ruvDGxN3yO258LUVduewGQlnynMcUwi2OvOYZHbrNRN3T11bUNia5UTfhbxL7ztk5NTdV7kOH9X/SGZFdXS2nRuz/AGGpen2WuMTJap/TnHD70cfenvcaqipyapyXkmU5LmN1kvmV36vu9wl5Pqa2odNIqJ0TdyrsidyJyTuJqbMzzYykGz30hWkuOufS4TZ7rllQxU2lRvsNK5O/35GrJun/ACtl8TQeXekG1tvnrIcapLFjcKvV0b6ekWpqEb3Nc6ZXRu+KRocwgmi1TDGWx772j9eMiqZKm5atZMx0u6OZR176SJUXqnq4FYxE8tjBK+83i6SOmud1rKuR67ufPO6RVXzVyqUYN4piOUGQAGWAAAAAAAAFZQXm8WqRJbZdayje1d0dBO6NU+lqoZ3Yu0frxjtRHU23VrJnui24WVle+rjRE6J6uZXsVPLY1wDE0xPOGcunsQ9IPrZY1jhyajsWSwo9HSPnpVpqhze9rXQq2NvxWNTfmBekK0kyJ8dLmtnuuKVD1Xilc322kand78aJJuv/ACtk8SOUGk2qZMpqMVzPEs4tiXjDsktt5ol2RZqKpZM1jlRF4XcK+67ZU3auyp3oXghTxvKclw+6R3vFL/cLPXxps2poqh8Mmy9U3aqKqL3ovJe8610d9IVkNtmgs2s1qbdqNVRi3i3xNiqo+vvSQptHInNPkcCoiKuz15ENVmY5M5d7gsGE57h2o9iiyTB8io7xbpeXrad+6sd3te1dnMcne1yIqeBfyFkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADpzU4Z7VXbVlmlrdN9GLpwQs4oLjkNPJzkXo6OlcnRqdFmTrz4OWz3bU0zVOIG0+0Z2zsW0kfU4lhcdPkGWxqscreLekt7k6pM5q7vei/2bVRU58TmqiIsemd6hZnqZfpMlznIaq7V8icKPmds2Jm+/BGxNmxt3VV4Woibqq9VUx5VVVVVXdVPwt0W4oazOQAG7AAAAAAAAAAAAAAAAAAAAAAAH497Y2q96oiJ3gXbB9Ts60kyluS4DkNTa6z3fWtYu8VQz8iWNfdkb5KnLqmy7KSM9mvtpYdrT7PiuVsp8dzFyIxlMr19mr3bdadzujl/unLxeCv57RcTy+uldJ49PgfMcj4ntlie5j2KjmuauyoqdFRSGu3FTMSnbBwv2SO3A+skotMda7onrncNPbMhnftxr0bFVOXv7klXry4+fvL3R1K0xNM4lsAAwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHMPbU7SEml+Opp5htwWPKr7AqzTxO2fbqNd0V6L+LK/m1u3NqI53JeBVzTE1TiBrLto9q6atmrtGtNblwUjOKnv9ygfzmd0dSRuToxOkjk+Uu7OTUdx8VAF2mmKIxDWZyAA2YAAAAAAFNNXxRbtZ77vLp+soZauebkr9k8E5GMi5yVMEXJ8ib+Cc1KZ9zanKONV81XYt4MZFU641C9OFvwQ81rKlesy/RyPEAentNR/fP8A2h7RP/fP/aU8wB6e0T/3z/2lHtE/98/9pTzAHp7RP/fP/aUe0T/3z/2lPMAentE/98/9pR7RUf3z/wBpTzAHqlXUp/bOPh8skn3R6u+KnyAAAMAd4diLtdSzSUOiuqF04lXhp8fulQ/mq9G0krl69yRuX5n5JwefrXOY5HscrXNXdFRdlRTWqmKoZicJ3AcxdibtMLrBirsHzCuR2X4/A3eWR3vXGkTZrZvORvJr/Hdrvxl26dKsxMTiWwADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAxPVXUey6TYDd88vqo6C2w8UUCO4XVM7l4YoWrsuyucqJvsuybqvJFIhs0zC+5/ld0zPJqtam5XaodUTv57Iq8msaiquzGtRGtTua1E7jpXt/axuyvOqbSyzVfFasWX1tdwO3bNcHt5ouyqi+qYvCnRUc+VFOTy1ZoxGZayAAmYAAAAPCqq206bJzevRAPSaeOBvFIvwTvUtlRWSz8t+Fvgn+55SSPlcr3uVVU+TWZAAGAAAAAAAAAAAAAAAAAAAAAAAABkWnud5BpnmdpznF6n1NxtNQk8e+/DI3o+N6J1Y9qua5PBykyWl+oli1WwOz59jsm9HdqdJVjVyK6CVOUkTv8THo5q/DdOSoQlnY/o6taXY5mNbo9eqtUt2R8VXbON3uxVzG++xPD1kbf2o2onNxFdpzGW0dyRYAFdkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADFdVM8otMdO8gzyvRjmWeifPHG9VRss6+7DGqpzTjkcxm/+Iyo459I3n62/E8b02o50SS71T7nWta9UckMCcMbXJ3tc+RzvjCbUxvTEDhC7XS4Xy6Vl6u1XJVV1wqJKqpnkXd0sr3K571XxVyqv0lIAXmgAAAB5zzNgjV7uvRE8VA+KuqSnbsnN69E8PMtTnOe5XOXdV6qfsj3SPV713VT5NZAAGAAAAAAAAAAAAAAAAAAAAAAAAAAAAr7BfbnjF9t+SWWpdT3C11UVZSyt6sljcjmr+tEKAATcaaZxbtSsAsGeWvhSC90MVVwIu/qpFTaSNV8WPRzV82qZKccejX1DdeNPsg04rJuKbHa1tbSI5f8A3apReJrU8Gyse5fOVDscp1RicNwAGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAi57b2YOyztC3umjqWTUuPwU9op1am3DwM45Wr5pNLKn0EoxC7n2ROy/Osiyx7EYt5utXcOFOjfWzOfsnknFsTWI87LErCAC01AAAVURN1LRV1Czy7ovut5NQrLhPwR+qavvP6/AtpiQABqAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAOjewJmTsW7RFttkk3BTZLRVNrl3X3eLg9dH9PHC1qfO8yVAhN0myJ2I6oYjk6O4Utd7oqp/PqxkzVcnwVu6fSTZFe7GKm0cgAETIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALHnl4lx3B8iyCB/DJbLTV1jHeDo4XPRf3ELZMXrg7g0Wz9yd2L3Vf8AwkhDoWLHViQAFhqAHhWyerp3KnV3uoBbqmX10zn93RPgeQBoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIqoqKi7KnRScrF7k69YzaLw53EtdQ09Sq+Kvja7/cg1Jr9HpVm0kwiZesmOW1366aNSC90bQy4AELIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMI1y/AnqD+a12/lJSHYmJ1y/AnqD+a12/lJSHYs2OUsSAAnahQXN/vMj8E3Ury01zuKpf5bIYkeAANQAAAAAAAAAAAAAAAAAAAAzTS3R3UHWK+JY8FsMtWrFT2irfuylpWr+NLIvJvfsnNy7LsiqYqqpojeqnEMxE1TiGFgkNwz0c2mlBaI0zrKL3dbq9qLK6hkZTU8a+DGqxzl26cSrz/JToaL7T/Y4rNFLV/TjDrtVXjGElbFVNqmt9poXPXZivc1Ea9iuVG8SI3ZXNTbnuU7e0LF2vydM8VivS3KKd6YczAAuqwAAAAAAAATV6L/gdwT82bX/KxkKhNXov+B3BPzZtf8rGQ3ujaGZAAgZAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABhGuX4E9QfzWu38pKQ7ExOuX4E9QfzWu38pKQ7FmxyliQAE7ULLOvFNIv8AiX+Jeixv5vcvmpiR+AA1AAAAAAAAAAAAAAAK6y2O9ZHcobPj9orLnXVC8MVNSQOmlevk1qKqiZxxlnmoSstFmu+QXKCz2K2VVxr6p6RwU1LC6WWRy9zWtRVVTqrSP0e+dZKsN11UujcYt7tnLQ06tmr5E8FXnHFunequVOitQ7Y0w0X020ftv2OwTGqeie9qNnrHp6yqqP8AmSu95U358KbNTuRDzdRtO1a4UedPw963a0ddfGrhDkHQ70fV1ufs+Q62Vj7dSrs9tjo5EWokTwmlTdI08Ws3dsvymqdvYpiOMYNZIMcxCx0dpttMn2unpY0Y3fvcve5y97l3Ve9VLuDwb+qu6mc1z7Oj0rVmi1HmwGPah4hSZ/gt/wAKreBIr1b56NHOTdI3vYqMf8Wu4XJ5ohkIIImaZzCSYzGJQiXS2V1ludZZrnTugrKCeSmqIndY5WOVrmr5oqKhSnV3b60VmxHO2aqWakX7D5S7hrVY33YLg1vvb+HrWpxp4ubJ5HKJ2OnvRftxcjq8G7bm1XNMgAJkYAAAAAE1ei/4HcE/Nm1/ysZCoTV6L/gdwT82bX/KxkN7o2hmQAIGQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYRrl+BPUH81rt/KSkOxMTrn+BPUH81rt/KSkOxZscpYkABO1Cxu+UvxL4WN3Ny/ExI/AAagAAAAAAIiquyJuqmZ41oxq1mHC7GtN8jr439Jo7dKkP0yKiMT6VMVVU0RmqcMxTNXJhgOkMT7Auv2QoyS8UdmxyJ2yr9kK9HybeTYEk5+Sqn0G7sK9G9h9C6Ooz/PbldnpzdTW6BtJHv4K93G5yfDhUqXNoae3zqz4cU9Olu19HAJs3Tzs2a1anrFNi+CV6UMuypX1rfZabh/KR8m3GnzOJfIkzwTs8aLabOjnxPT21QVUWytrKiNampRfFJZVc5v8ApVENinn3dsdLVPv+n/a1RoP+c+5xdpp6OOy0SxV+q+YS3GRNnOt1oRYod/B0z043J81rF8zqzB9NMB01t/2MwXE7dZoVRGvWnhRJJdunrJF3fIvm5VUyUHl3tVdv/eVLtuzRa9GAAFdIAAAAALBnmDY7qRiVywrK6L2m23OFYpWouzmLvu2Ri9z2uRHIviiEUWuuhWW6FZdJYL9C+ot1Q5z7ZdGRqkNZEnh+S9N0RzN90XxRUVZfCwZxgeJakY7UYrmtkp7nbalN3RSpzY7uexye8x6brs5qoqF7Ra2rS1YnjTPRX1Gni9HrQsg621l9H7m+NTz3fSWr/pLat1elBO9sdfCngirsyZE8U4XdyNXqct3/ABnI8Ur32rJ7DcLTWM+VT11M+CRP9L0RTpLOotX4zbnLyLlqu1OKoW0AEyMAAAmr0X/A7gn5s2v+VjIVCavRZd9HMEX/AOWbX/KxkN7o2hmQAIGQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYD2gKyGh0M1Annds12NXGFPnSU72N/e5CH0lV7ZtyS2dmzMXpK1j6iOkpmIq7K7jq4WuRPH3VcvwRSKos2OUsSAAnat29mPs11+v8Afat9wrp7ZjNp4Er6yFqetke7fhhh4kVvGqIqq5UVGptui7oi9nw9hHsxxUrKd+BVM0jWo1Z33msR718VRsqN3+DUTyLH6PaCKLQqrkjaiOmyGqe9fFUhgb/BqHTZ4Wr1Fybs0xOIhftW6d2JmHNVw9Hx2dK3f2a33+g3/wDh7o5dv+o15Y5/RsaHSbrBlWbxKvRPbaRyJ/4bf951iCCNTej80t/J0dzkJfRt6NQqnrstzVyeLaukT/8AXUqaX0duhNOu8t3zCp8pbhAn/kgadZuaj2q1yclLe9qserF7lK93VainlXOE9u1aq50uebf2DuzlROR1Tjdzr0TuqLtOiL/03MMstPZS7O9mc11HpRZpFb09rSSqT6Umc7f6TbAK9WpvVc6596aLNuOVMLJY8GwrGeH+jeH2S1cPyfYbfDBt8OBqF7AIZmZ4ykiMcgAGAAAAAAAAAAAAAAAAAKO62az32lWgvdqo7hTO5rDVQNlYv+lyKhWAzyGsr32ZtAb/AByR1+kuOR+tRUc6jpEpHc+9HQ8KovminBna47MkOhF5ob3i9TUVOLXt744EnXilo6hqcSwud+M1W7qx3XZrkXm3idKAcw+kPjY/Qejc5qKrMipHNXwX1M6fwVT0NBqbtN6mnOYngq6m1RNuZxxhGwADp3jBNBoDVtrdC9Palq78WL2tq/OSljRf3opC+S79ji8NvfZpwaqR6KsFHLRuTfmiw1EkSJ+piEN7o2huYAEDIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAOTPSNZLDQaXY7iySObUXe9e0oidHQ08L0ei/65ol+gjyOpvSGZr9ndYKDEKeoe6DGLWxssa9GVVQvrXqnxi9n/Ucsly1GKWsgAJGEkno+/wAA03+fVf1cJ0uc0ej7/ANN/n1X9XCdLnN6n76rxela9CAAECQKKqT7cvwQrSiq/uv0IRXvRSWvSeIAKiyAAAAAAAAAAAAAAAAAAAAAAAAHMfpDfwC035w0n1U504cx+kN/ALTfnDSfVTlrR/iKPFDqPuqvBGsADrnhBJV6NzKG3XRi7Y1JJvNYr3Jwt36Qzxse39b0l/URqnXXo2s4bZNWL1hFRNwQ5Na/Wwt3+XU0zle1Nv8AlPnX6CO7GaW0JIwAVmQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAprpc6Cy2yrvN1qmU1FQQSVNTM/wCTHExque5fJERV+gqTmbt66qphOk7cJt1TwXTMZFpncLlRzKGPZ07t0/KVY49l5K2R/gZpjenAj61EzGs1Bzq/ZvXNcyW9XCas9W53F6pj3KrI0Xwa3hank1DHQC/EY4NAAASSej7/AADTf59V/VwnS5zR6Pv8A03+fVf1cJ0uc3qfvqvF6Vr0IAAQJAoqv7r9CFaUVX91+hCK96KS16TxABUWQAAAAAAAAAAAAAAAAAAAAAAAA5j9Ib+AWm/OGk+qnOnDmP0hv4Bab84aT6qctaP8RR4odR91V4I1gAdc8IMs0nzqp0z1JxvPKXiVbLcIqmVjeskO+0rP9Uavb9JiYExmMMp1qCupLnQ09yt9Qyelq4mTwSsXdskbkRWuTyVFRT3OZ+wNq03UDRqLErhUo+74W9tve1zt3Po3brTP+CNR0f6JPE6YKcxicNgAGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAedVVU1DTTVtbURU9PTxullllejWRsam7nOcvJEREVVVehEl2j9XZtadVrplkT3/YqBfYLRG5NlZRxqvAqp1RXqrpFReivVOiIdZ9vfXpMbx9ujWM1u1zvkSS3mSJ/vU9Eq+7Cu3R0qpzTf7mioqKkiKR+lmzRjzpYkABO1AABJJ6Pv8A03+fVf1cJ0uc0ej7/AADTf59V/VwnS5zep++q8XpWvQgABAkCjq0+2/QVhS1ie81fLYjveiktekpgAU1kAAAAAAAAAAAAAAAAAAAAAAAAOY/SG/gFpvzhpPqpzpw5j9Ib+AWm/OGk+qnLWj/EUeKHUfdVeCNYAHXPCAABt7ss60SaIauW3I6uZzbJcP8A2deWJuqeyyOT7Zt4xuRr/FUaqfjEvkE8NTDHU00zJYZWo+ORjkc17VTdFRU5Kip3kEpI96P7tA/0zxR2j2T1vFesbg47XJI73qm3oqJwebolVE+YrfyXKQXafzQ2iejr8AELIAAAAAAAAAAAAAAAAAAAAAAAAAABi+p2oFn0twO857fPeprTTLKkSLss8qqjYokXZdle9zWou2ycW68kUyg4G9Ifqy655Ja9H7XU/wBWszW3K6o1flVUjftMa8vxIncfJdl9ene02op3pwOUcxy2+Z5lNzzDJKtam5XapdU1Ei77br0a1F6NamzWt7mtRE6FmAL3JoAAAAfE8qQxOkXuTl8QJHfR31kdVobcomb70uS1cLvj7PTO/wDyOoTjn0Z16hqNN8ux5JEWaivjK17e9GzwMY1fpWnd+o7GOc1UYvVPStehAACukDwrG7xo7wU9z4lbxxub5Gtcb1MwzTOKolbwAUVwAAAAAAAAAAAAAAAAAAAAAAAAOWvSLVDYdDbXCvWfJqViJ8Kapd/sdSnGvpKru2HEMKsPFzrLlVVe3ikMTW7/AP3y3oIzqaI9aDUzi1U4EAB1rwwAAC/4Fm9904zG05xjVSsNxs9S2oiXf3XonJ0bvFrmq5rk70cpYAJjIm402z6yaoYLZs9x2TehvFM2drFXd0T+kkTv8THo5q+bVMlOAfRu6wvo7vdtFrvVfaK9r7rZ0evyZ2IiTxN+cxEeidE9W9eqnfxUqjdnDcABqAAAAAAAAAAAAAAAAAAAAAAAALdkd+t2K49c8nu8jmUNoo5q6pc1N1SKJivdsneuzV5ENOZ5Vcs4y28ZjeHItbea2atmRFVWtdI9XcLd/wAVu+yJ3IiISK9vjOv6LaHPx2nmY2ryqvhoeHiVHpTxr66V7duqbxxsXylI0SzYp4ZYkABO1AAALdcZ+N6QtXk3r8Ssqp0giV34y8m/Es6qqqqqu6qYkdk+jPydKLULLsQcmyXa0RV7XKv41NNw8PxVKly/6VJDyIPsnZq3Au0Hht4mkc2mqq9LXU7O4W8FU1YEV3+FrpGvX5hL4eHr6N27vd69p5zRgABRWAAAUE7OCVU7uqHmVlXHxMR6dW/wKMpXKd2rC1RVvUgANG4AAAAAAAAAAAAAAAAAAAAAEd3pHMmbcdVLBi8UnEyzWb1z03+TLPK5VT9iONfpQkRIhO0jmrdQNccwyWGb1tM+4vpKVyLydBAiQxuTyVsaO+k9TZNvev73dCnrqsW8d7WoAOkeQAAAAAMh09zS5adZxY85tCr7VZK6Ksa3fZJGtd70a+Tm8TV8nKTXWG9W/JLHbsitM3rqG6UkVbTSflxSMR7F+lHIQYEpnYDz52Y6A0dnqp/WVmK1k1qfuvvLDylhX4I2TgT/AJZDejq2h0iACBkAAAAAAAAAAAAAAAAAAAAAAABHx6RzLH3HUjG8OjlY+Cy2l1Y5G9WTVMqo5rv9EESp87zORjcXa9v8eR9ozNKuBXerpquK3tRV32Wngjhf/wDWxy/SadLtuMUw1kABuwAFNXzeri4Gr7z+X0AUNXP6+VVRfdbyaeIBoP1j3RuR7HK1zV3RUXZUXxJndDdRItVtJsZztsjXT3KhZ7YjU2RtXHvHO1E7kSVj9vLZe8hhO4PRuatspLhe9GbtVNa2u3vFoR7kTeVrUbURJuu6qrGseiJ0SORe8pa+1v296Oixp6t2rHe74AB4i8AAAqIqbKW+aNYnq3u7i4HnPF61mydU5oR3aN6ODe3VuyoAfqoqLsp+FNaAAAAAAAAAAAAAAAAAAAAAGue0NqK3SzR3JcuZP6qtio3U1v57OWrm+1xKnjwudxr5NUiAVVVd1Xmdi+kS1WS8ZTadJbXVcVNY2Jcbk1ruS1cjftTF82RKrv03kcdHTbLs+Ss7086vl0eRrLm/c3Y6AAPSUwAAAAAOzvRmZc6iz3LcHkk2ju1riuMaKv8AaU8vAqJ5q2oVf9HkcYm8+xLkDsf7S2IPWThiuD6m3ypv8pJaeRGJ/wBTgX6DS5GaZZjmlqABVbAAAAAAAAAAAAAAAAAAAAAAAAIb9Y7jHd9XM3ukW/q6vIrlOzfqjXVMip+5UMPLnlEjpsmu8z/lPrqhy/FZHFsL9PKGsgAMsBaayX1s7l7m+6hc55PVQvk8E5fEspiQABqBe8Ky+94BltpzTHKj1Nxs1VHVwOVV4XK1ebHIipu1ybtcne1yp3lkAmImMSzyTY6aagWLVPBbPnuOycVFd6ZsyMVd3QyJykid/iY9HNXu3by5GTkaHYT7REWmWXv02yyvSLGcnnb7PLIvuUVwXZrXqv4rJERrHL0RUjXkiOUkvOe1FmbFe706PRt1+UpyAAgSAAAp6mDi+2MTn3p4lIXMpqin6yRp8UILtv8ANCa3c6SpQAVk4AAAAAAAAAAAAAAAAYfq5qVZ9I9Prxnd6cxWW+BfZ4FdstTUO5RRJ5udtv4JuvRFMwVURN1XZEIy+2p2go9Ws2ZiOMV3rcWxqR7I3sduytrObZJ025K1E9xi+HE5OTy3o9NOpuxT0jmg1F6LNGern/I8gu2WX+45Nfap1TcbpUyVdTKv40j3K53LuTdeSdybIW4A62IiIxDxJnPEAAYAAAAAAzvQW4radb8AuCLskWS23j+YtSxHfuVTBDI9NXuj1FxWRi7Obe6FyL5pOwxVylmOaboAFNsAAAAAAAAAAAAAAAAAAAAAAAAhg1Dt8toz/JrVMxWSUV4rad7V7nMne1U/cY8bI7SFoqLJr3n1HVMVj5L9V1aIv5E8izMX6WyIv0mty/TxiGsgAMsKS5P2iaz8pf4FtKy5u3la3wbuUZrIAAwAAAEkXYh7UrNQ7RT6T57c98ptcHDbqqd/vXSmYnyVVflTRtTn3uanFzVHqRulTbLncLNcaW72itno66imZUU1RA9WSRSNVFa9rk5oqKiKioQ37FN+ndlJbuTbnMJzwc19kvtbWvWu2xYdmVRT0OcUcXNvJkd1Y1OcsSdEkRE3fGnm5vu7ozpQ8C5bqtVbtXN6FNUVRmAAGjYAAHhNTI/3mcnfxKRWq1dnJsqFyPiWJsrdl69ykNy1FXGEtFzHCVvB+uRWqrV6ofhVWAAAAAAAAAAAADmXtZdrSg0loJ8GwSrhq8zqo+GWVuz2Wljk+W9Oiyqi+6xenynctkdLZs1364ooji0rrpt071TGO252n4sWt1Xo3glei3qvi9XeqyJ3/BQPTnA1U/tXtXn+S1fF27Y+z2ra2suVZPcLhVS1NVVSOmmmler3ySOXdznOXmqqqqqqp4nV6XTU6W3uU+14t67N6rekABYQgAAAAAAABlukNG64as4VQNbxLU5FbYUTx4qmNP8AcxI2v2UrM6+9ovAKJjd1ivEdZt5U6OmX90Zir0ZZjmmGABTbAAAAAAAAAAAAAAAAAAAAAAAAIzu31jT7J2gam7K7iZkNro69Nk+SrGrTq34/1dF/1Ic4He3pIsNdV4viWfQRsRbdWzWupVG++5s7EkjVV/JasMifGTzOCS5anNMNZAASMLVXrvVOTwRE/cU57Vn/ABMnx/2PE1AAGAAAAAAe9BX11rrae52ysnpKyklbNBUQSLHJFI1d2va5Nla5FRFRU5oqEhPZg7ddqyuOkwTWmugtt7RGxUt7ftHS1y9EbN0bDKv5XJjufyV2R0d4Ib1ii/GKklFybc5hOwioqbou6KCLPs99tTUDRv2bHMj9bk+Jx8MbaSeX+s0Uacv6vKv4qJt9rdu3kiNVm6qSH6Ua56Za02v7I4HkkNVNGxH1Nvl+1VlLv3SRLzRN+XEm7FVF2cp4t7TV2J48u9dou03OTPQAV0oAAKKqREmXbvTc8T0mfxyuci8uiHmUa5zVK3TwiAAGrYAAAAAD8c5rGq97ka1qbqqrsiJ4mAar676Y6M0C1Wb5FFDVPZxwW2n2lrKjw4YkXdEXpxO4W+KkfOvvbF1B1lWosNodJjeKv3YtBTy7zVTfGolTZXIv5CbN8eJU3Lmm0V3UzmIxHegvaiizz59zffaa7clvskVZgmi1dHWXNd4au/M2dBTdytp+6R/+P5Kfi8S828FVVVVV1TLW1tTLUVFQ90sssr1e+R7l3VznLzVVVd1VTyB0mn01vTU7tHveRdvVXpzUAAsIgAAAAAAAAAADqP0dWLuvWvj766PeLHrNVVSP25JJIrYGp8VbLJ+pTlwkR9GhhK27A8pz6oi2ferjHb6dXJz9TTMVyuTyV8yp8Y/I0uzilmHZgAKrYAAAAAAAAAAAAAAAAAAAAAAABr/X7T5+qOj2UYXTxLJWVdEs1C1NkVaqFUlhbuvTiexrVXwcpEAqKiqioqKnVFJvyKztgaWrpfrXdo6Om9XacgVbzb+FERrWyuX1sabIiJwyo9Eb3M4PEnsVcd1iWkgAWWq01qbVUnxT+B4FRX7e1P28v4FOagADAAAAAAAAAFZaLxd8fuUF4sN0q7bX0ruOCqpJ3QzRO223a9qorV2VeilGBzHcnZO7Z2qeWZ5Z9Lc/ZR36nuLahsdzcxIKuH1UD5U4lYnBKm0fDzajue6uXovctNfLdUom06Ru/Jk939/Qie7HEb39ozFHNaqpG2vc5fBPYZ03/WqEmBxu3NXVodVFFuIxNMTj15l0OzdNTqrE1Vzxzj4Qz310W3F6xu3kpTzVPEisj6L1Uw2OeaFd4pXs+C7FVHeK5nV7X/Ob/wBjzo2vTXGKowt/5bNM5icsgBZm36ZPlwMX4KqH2l/TvpV/b/8AQzGtsT1+bE6S7HRdgWn7Pp3Uq/t/+h8Pv0y/IgYnxVVE62xHX4SzGkuz0XkKqIm6rsiGPyXiuf0e1nzW/wDcpZJ5pvusr3/FdyGvaNEejGUlOirn0pwv890o4OXreN3gzn+/ocO9rDtfap4tn940uwaWlsNLbm07ZLhEz1lXN62njlXZzvdjRPWbe63i5b8SdDsAjP7Y0b2dozK3OaqJIlA5q+KewwJv+tFPS2Dd+2auabsRiKZnHrzCptS1GmsRVRPHP8S1Bc7ncr1Xz3W8XCprq2pesk1TUyulllcvVXOcqqq+alMAdtyc2AAMAAAAAAAAAAAAAD6iikmkZDDG58kjka1rU3Vyr0RE71Jn9CdPW6WaRYtgro2sqLbb2LWcPRaqTeSdd+9PWPft5bEbvYj0ndqfrjbKuuplks+K7XmtVU91z2OT1Ea93vS8K7L1ax5K8V7s5nDaOQACJkAAAAAAAAAAAAAAAAAAAAAAAANDdsjRd2rmlM9ZaKRZshxf1lxtzWJu+aPhT19Onz2tRUTqr42J0VTfIMxMxOYEHjJ4ZE3ZI1fp5nnPWQwovvI53ciKdBduPs/P0n1DdmePUPBi2VzPniSNvuUdavvSwcuTUXm9icuSuanyDmcuU170ZhrMYfr3uker3Lzcu6n4AGAAAAAAAAAAAAAB0p2CLG646x192dAro7VZJ5EeicmySSRsRPpasn6iQQ5v7AmnUuN6bXDOq+nWOqymqRKfiTn7JBxNYvlxSOlXzRGr4HUD4o3/ACmJ8T5/t3/c6yqaZ5cPd/263Zf+jp4iqOfFbwVTqNPxHqnxPN1LKnREX4KeHNquOj04uUz1eIPtYZU/s3fqPz1cn5Dv1Gu7MdG2YfIPr1ci9GO/UfqQyr0jd9KDdmehmHwD2bSyr1RE+Kno2jT8d6r8DaLVc9Gs3KY6qUj77e9jdbtY6C7NgVsd1skEivVOTpGSSMVPoakf6yRRkUbPksTfxOX+33p1Lkmm1vzugp1kqcWqlSo4U5+yT8LXL58MjYl8kVy+J7mwv9trKZqnnw9//bzNqf62nmIjlxR7gA+gOSAAAAAAAAAAAAAAA6Y7DnZ/fqxqG3M8hoePFsUmZPKkjd2VlanvRQc+SonJ7058ka1flmKqt2MsxGXZXYw0Vfo7pBSyXek9VkOTK26XJHN2fE1W/aYF+Yxd1Tue96G+wCpM54y2AAYAAAAAAAAAAAAAAAAAAAAAAAAAAAYpqjprjereD3PA8qp+OjuMWzZWonrKeZOcczF7nNdsqePNF3RVQh81X0uyjR3OLhguWU3BVUT+KKZqL6uqgVV4Jo172uRPiioqLsqKhNcab7TfZysPaCw32NViosltbXyWe4uTkx69YZNuaxP2Tfvauzk32VF3or3ZOaIYF3yzE8iwbIq7E8rtU1uuttlWGpp5U5td3Ki9HNVNlRyboqKioqopaC1zaAAAAAAAAAAAGfaIaS3jWbUCgxC3NkjpFck9yq2pypaRqpxv8OJd+Fqd7nJ3bqWfTzTnLtUcmp8Uw21vrKydd3u5pFTx785JX9GMTx+CIiqqIsneg+h2OaG4g2xWvhqrnV8Mt0uKs2fVSonJE/JjbuqNb3bqq81VV8vae0adFb3aZ8+eXq9a9otHOprzPox/7DPbLZ7bj1oorDZ6VlNQ26njpaaFnSOJjUa1qfBEQrQDh5mZnMuniMcIAAYZAAAAAAAACivVntuQ2etsN4pW1NDcaeSlqYXdJIntVrmr8UVStBmJmJzDExnhKJLW/SW8aM6gV+IXJsklIjlnttW5uyVVK5V4H+HEm3C5O5zV7tjASWHXfQ/HNcsQdYrrw0tzpOKW13FG7vpZlTov5UbtkRze/ZFTmiKkYmoenOXaW5NUYpmVrfR1sC7sd1iqI9+UkT+j2L493NFRFRUTuNmbRp1tvdqnz45+v1uY1ujnTV5j0Z/9hjIAPUUQAAAAAAAAAu2J4nkOc5FQ4pilqmuN1uUqQ01PCm6ucvVVXo1qJuquXZERFVVREHIXnSjS/J9Yc5t2CYpTcdVWv3lmci+rpYEVOOaRe5rUX4qqoibqqITB6Xaa43pJg1swPFafgordFs6VyJ6yolXnJNIve5zt1Xw5ImyIiGC9mTs42Ls+4b7HvFW5LdGskvFxanJzk6Qxb80iZuu3e5d3LtuiJuUq1178t+QADQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaQ7TXZdxftBWFKmNYrXltviVtuunDyenNUgn25ujVd9l6sVVVN93NdFlnmAZdpnk1XiGbWWa2XOjX3o5E3a9q9HscnJ7F7nIqopN4a61s0HwHXfG1sWY0HDVQI5aC5wIiVNE9e9ju9q8uJi+6vkqIqSUXJp4dDGUM4Noa7dnfP9Ar/APY7KKT2q11L1S33inYvs9U1Oe3+CRE6sXmndxJs5aTBuz/qtqA2Kos2LT01DLsqV1f/AFeBWqm6Oarvee3zY1xte1VnT0eUvVxTT3zOG9qxdv1blqmZn1RlroHWeL9hdm0U2aZ05VVv2ymtdPts7ymk6p8Y0NjWjsg6JW2BsVbZrjdXp1lq7hK1y/8ARWNP3HP6jtfsyxOKapq8I+uHtWezWvuxmqIp8Z+mXAwJH6Ps86K0MaRQadWpyJ0WZr5l/W9yqpcqfRnSSlVHRaaYzu3mivtkL/8AzNUoVduNJHo26vh9ZW6eyWpn0rlPx+iN6yY7f8lq/YMdslfc6nbf1VHTvmeieKo1FVE8zofSXsQZrmFdFPn90p8aoEVHPpmPbPWyt8Gom8bOXerlVPyVOxaOiorfA2loKSGmhZybHDGjGp8ETkVDXOY5HscrXNXdFRdlRTytT221FycWLcUx45n+Ij3S9Gx2Ts0Rm7XNU+6Pr8YXrTfSzB9JrE3H8IskVFCuzp5l9+epen48si83LzXyTfZERORlpjtnyVr9qa5ORrujZeiL87w+JkXUht6qnVx5SJzPXv8Aa1u6arSz5OYxHTuAASIwAAAAAAAAAAAAAMT1I0twfViwux7OLJHXQIquglReCamft8uKRObV/cvRUVORlnQwTK9Q46bjt9ge2SXm19T1a3yb4r59Pj3Q39bRoI8rVViY5Y5+xY02hua+ryVunPf3e1w9rD2MMqwW5PXB73S5HRPVXMpnvbDWwt7kei7Ru5d6ORV/JQ5+u9hveP1Psd9tFbbp1TdI6qB0TlTxRHIm6eZI5LLJNI6aaR0kj1VznOXdVXxVTwqaWmrIXU9XTxTxP5OjkYjmr8UXkaaX/EDU26sX7UVU9MTifbzifdD0NR2EsV0RNm7NNXXMZj2cpj3yjcBIBNpbprOqrJgGPbr1Vtthav7mlBV6JaUVsaxTYLbGovVYmLEv62KioexR/iDop9O1VHun+YeVV2E1kejdp+MfxLg4HaNz7MWkdfAsVLaK23OX+1pa6Rzk/wCqr0/cYJkXY+iVJJcTzFzVRv2unuMCLu7zlj22T9Gp6Om7bbJ1E4qqmj9UfTKhqOx21LEZppiv9M/XDmkGd5hojqThTZKi547LU0cW6rWUK+vi4UTdXLw+8xvm9rS66E9njPtfcg+xuMUnstrpnolwvFQxfZqRvXb/AByKnRic16rwpu5OlsauxqqPK2K4qp74nPyc5f017TV+TvUTTPdMYYfgmA5bqXk1JiOFWWe53OsdsyKNPdY3fnI9y8mMTfm5VREJTezL2XMY7PtiWqldDdMtuESNuN04OTG8l9RBvzbGi7br1eqIq7bNa3K9E9B8B0IxtLFh1BxVU6NWvuc6ItTWvTve7uanPhYnup5qqquxTFdc1cOiPGAAEYAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWS/5ba7Aixyv9fVbcoI15py5cS/ip08/JTH8rz7gV9usMqKvyZKlOe3ijP/AOv1eJgL3vke6SRyuc5VVzlXdVVe9TjdsdqadPM2NFxq61dI8O+fh4ur2V2cqvxF7V8KekdZ8e75+C5ZPkFXljEpbrDA+jbI2VlMsaOYj2ru1y79XIqIqL3Km6bFsAOC1Gpvaqvyl6qap9btbGntaajcs0xEeoABClAAAAAAu1oyCa3qkNRvLT+H4zPh/wBi0nxLKyFiySLsiElq9XYq36Jw0uWab9O5VGWxqaqp6yBtTSytkjem7XNXkepqSzZBX2WpWamfxRvXeSJ3yXf9l8zZVmvtBfIPW0kmz2p9sid8pi/7p5nQaLaNvVxuzwq7vo8TaGy7minejjR393iuIAPReWAAAAAAAAHlU1VPRQPqaqZsUTE3c5y8kKO832gsdP62rfu9yfa4m/Kev+yeZrS+X6uvsyvqX8MSfc4mr7rf+6+Z52u2jb0kbscau76vU2fsu5rZ3p4Ud/0euWZ1V3pX0NvV0FDzRduT5fj4J5fr8sTPp7HRuVrk2VD5OMv6i5qa5ruzmXdabTWtLbi3ajEAAIE4AAAAAGR4Znd4wlnslsZA+gdI6V9I5iIxXOXdzkVObXKu6796ruqKY4CxptXf0dzyunrmmr1K+p0ljWUeT1FEVR63R+Jag2HLmJFTS+zVqJu6llVOLpzVq9HJ16c/FEMmOTIpZYJGzQyOjkYqOa9q7K1U6Kip0U29p/q0lQ6Ky5XM1si7MhrXckd4JJ4L/i/X4r9J2F2wo1Uxp9fimrpV0nx7p+Hg+cbc7IV6WJ1GgzVT1p6x4d8fHxbVAB3ThgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA17nOYOmdJZLVLtEm7aiVq/LXvYnl4+PTp1u+eZKtppEttFIraupburm9Y4+m/xXmifSvgawOI7T7bm3nQ6eeP5p/j6+7vdh2d2RFeNZfjh+WP5+nv7gAHAu1AAAAKeprYaZNnLxP7mp1MTMRxltTTNU4hUFPNX00HJ0nEvg3mpaqivqKjdFdws/JaUxDVd7lyjSda5XGS8PXlFCiebl3Kd9xrH/wBrt8ERCmBHNdU9Vimzbp5Q9VqqletRJ+0p8Oke/wCW9zviu58g1zMpIpiOQe1JV1NDOyqpJnRSsXdHNU8QImaZzBMRVGJ5Nk43mNNdkbSVytgq+idzZPh4L5GSmkunNDMMbzh9PwUN5er4ujZ+rm/O8U8+vxOi0G14qxb1Hv8Ar9XL7R2JNObumjh3fT6M9B8xyRzRtlie17Hpu1zV3RU8UU+joObm5jHCQA+ZJI4mOlle1jGpu5zl2RE8xyOb6MbyPMaa0o6kouGer6Lz3bH8fFfIs2SZw+fiorK9WR9Hz9HO+b4J59fgYeqqq7qeBr9rxTm3p/f9Pq6TZ2xJqxd1McO76/R61dXU11Q6qq5nSyvXdXOU8QDnJmapzLqIiKYxHJ+K1rvlNRfih+LFEvWNv6j6Bhl5LSwO/E2+Cnm6havyHqnxKkGJpiWd6YW99NLHzVu6eKHkXU85aeOXmqbL4oaTR3N4r71uB6S074uapu3xQ8zTGEkTkABgAABtbSzUh8T4cXv8+8TtmUdQ9ebF7o3L4eC93Tpttt85KN8aU5u7IrctnuUyuuNCxNnOXnNF0R3mqckX6F71PpXZHtBVdxs/VTx/LM/tn+Pd3Pm/a3s/TaztDSxw/NH/ANR/Pv72egA+gvn4AAAAAAAAAAAAAAAAAAAAAAAAAAB4V9bBbqOauqXbRwMV7vFdu5PNeiHuYNqZdljhp7NE/ZZft822/wAlF2anw33X/ShQ2prY2fpK9RPOI4eM8l3Z2knXamix0nn4dWD3K4VF1r5rhVLvJM7iVE6IncieSJsn0FMAfG666rlU11zmZ4y+rUUU26YopjEQAA1bABbrjXcG9PC73vxnJ3eRrVVFMZlvbtzcq3Yftdckj3hp1RXdFd4fAtSqrlVzlVVXqqn4CrVVNU8XqW7dNuMQAA1SAAAAAAAAAAAvWP5RW2KRI91mpXLu6JV6ebV7lNkWy60N3p0qaGZHt/Gb0c1fBU7jTp9xTSwP44ZXxu8WuVF/cepotqXNLG5V51Py8Hk6/ZFrWTv0+bV39/j9W37ndaG0U61NdOjG/it6ucvgid5rfIMorb69Y+cNK1fdiRevm7xUtEs0s7+OaV8jvFzlVf3nwNbtS5qo3KfNp+fiaDZFrRzv1edV393gAA8t6wAAAAAAAAAACoipsqboUdRS8O74k5d6eBWAxMRLMTMLUCqqqfbeVicu9ClIZjCaJyAAwyFfYrzV4/d6a8US/baZ6O2VeT29HNXyVN0+koAb27lVquLlE4mOMT64aXLdN2ibdcZieEx6nVdruVLeLdTXSifxQVUaSMXvRF7l806L5oVRq3Q/IXT0lXjU8iq6m/rNOi7/ACFXZ6eSI5UX/UptI+7bI18bT0dGpjnMcfGOE/H4Phe1tBOzNZXpp5RPDwnjHw+IAD0nnAAAAAAAAAAAAAAAAAAAAAAAABpnKLh9k7/W1SORWesWNiou6K1vuoqfHbf6TbtzqnUVtq6xiIroIHyoi96taq/7Gjjh+2eomKLWnjrmZ9nCPnLsOydiJquX56YiPbxn5QAA4J2oAfiqjUVyrsic1Apq+r9mi2avvv5N8vMsiqqruq7qp61U61M7pF6dGp4IeJUrq3perYteTp9YADRMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB1KCph9U/dE913Qrz4mjSWNWd/d8TWqMw2pnEraAqKi7KnNAQpgAAZDgF3WyZfbaxXo2N8yQS7rsnA/wB1VX4b7/QdKHJaKrVRUXZU5op1RZq5bnZ6G4uREWqpoplRPFzUX/c+k9g9VM272mnpMVR7eE/KHzft3poi5Z1MdYmmfZxj5yrAAfQnz8AAAAAAAAAAAAAAAAAAAAAAABZM2ldDi9e9q7KrWN+hXtRf4moDbed/epXfovrWmpD5t2xmft1Ef2R86nf9lIj7HVP90/KkABybpgorpP6un9Wi85F2+jvK0st0l9ZVK1F5MREI7k4pT6ejfuR6lGACq9QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABQ1kfDJxJ0d/E8Cvq2cUKr3tXcoCGuMSmonMAANWwdH6aTuqcGtMj13VInR/Q17mp+5DnA6I0p+8G1fp/rnna9hZn/ADC5H9k/upcX25iPsFE/3x+2ploAPqz5WAAAAAAAAAAAAAAAAAAAAAAAAsGefepXfovrWmpDbeefepXfovrWmpD5t2x/HUfoj51PoHZX8FV+qflSAA5N0oY5M/1kr5PynKpkEq8Mb3eDVUxwgvTyhe0cc5AAQLoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD8e3iY5vimxay6lremz3J4KpHcSW34ACNIHRGlH3gWr9P9c853OiNKPvAtX6f6552nYX+o1/on91LjO3P9Po/XH7amWgA+rvlQAAAAAAAAAAAAAAAAAAAAAAACwZ596ld+i+taakNt5596ld+i+taakPm3bH8dR+iPnU+gdlfwVX6p+VIADk3SvOo+4SfMX+BjpkVR9wk+Yv8AAx0r3ucL+j5SAAhXAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAtkv3V/zlLmWyX7q/wCcppcb0c3yACJKHRGlH3gWr9P9c853OiNKPvAtX6f6552nYX+o1/on91LjO3P9Po/XH7amWgA+rvlQAAAAAAAAAAAAAAAAAAAAAAACwZ596ld+i+taakN23q2MvFrqba93D65myO8HIu7V/WiGnLla6+01DqWvpnxPToqpycnii96Hzztjprv2ijUY83dxn1xMz/Luuyl+35Cuxnzt7OPViPopQAca6t51H3CT5i/wMdMiqPuEnzF/gY6V73OF/R8pAAQrgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWyX7q/5ylzLZL91f85TS43o5vkAESUOiNKPvAtX6f655oiyY/d8irG0VpopJ3uVOJyJ7jE8XO6Ih0ljdlix2x0dlifxpSx8LnflOVd3L9LlVTvewulu/armpmnzN3GfXMxPD3cXCdudVa+zW9NFXn72ceqImOPv4LkAD6c+ZAAAAAAAAAAA/9k=");
    //Uint8List bsonData = Uint8List.fromList(byteBuffer.asInt8List());
    //Map<String, dynamic> bson = BSON().deserialize(BsonBinary.from(bsonData));
    //String jsonString = jsonEncode(bson);
    //List<int> bytes = jsonString.codeUnits;
    /*var bsonData = BSON().deserialize(BsonBinary.from(bsonBytes));
    BsonBinary bsonBinary = BsonBinary.from(bsonData['data']);
    Uint8List bytes = Uint8List.fromList(bsonBinary.byteList!);
    //return MemoryImage(bytes);*/
    return bsonBytes;
  }
}

/*EmailAuth emailAuth = new EmailAuth(sessionName: "Sample session");
void sendOtp() async {
  bool result = await emailAuth.sendOtp(
      recipientMail: 'mira13.mc@gmail.com', otpLength: 4);
  // recipientMail: _emailcontroller.value.text, otpLength: 4);
}*/
/*static Future<String> sendingSMS(int otp, int nbr) async {
    //final db = await Mongo.Db.create(mongoDB_URL);
    //final coll = db.collection(personsCol);
    //await db.open();

    //final phoneNumber = (await getInfo())['phone_number'] as int;
    const phoneNumber = 96171119085;
    var random = new Random();
    int otpSend = random.nextInt(999999);
    String result = await sendSMS(otpSend, phoneNumber);
    return result;
  }*/

/*static void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }*/

/*static Future<void> sendOTP() async {
    final db = await Mongo.Db.create(mongoDB_URL);
    final coll = db.collection(personsCol);
    await db.open();

    final targetID = await coll.findOne(Mongo.where
            .eq("_id", StoreController.ID_controller.value.text.trim()))
        as Map<int, dynamic>;
    //final phoneNumber = targetID['phone_number'] as String;
    const phoneNumber = '96171119085';
    var random = new Random();
    int otpSend = random.nextInt(999999);

    SmsSender sender = new SmsSender();
    sender.sendSms(new SmsMessage(phoneNumber, 'Your OTP is: $otpSend'));
  }*/
//////////////////////////WORKS BUT CONSIDERS USER AS SENDER/////////////////////////
/*void sendingSMS() async {
  /*var url = Uri.parse("sms:96171119085");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }*/
  final emailAddress = 'mira13.mc@gmail.com';
  final subject = 'This is a test';
  var random = new Random();
  int otpSend = random.nextInt(999999);
  final body = otpSend.toString();

  final Uri mailToUri =
      Uri(scheme: 'mailto', path: 'mira13.mc@gmail.com', queryParameters: {
    'subject': "Your OTP is $otpSend",
    'body': "Test done",
    'from': 'overranter@gmail.com',
  });
  //print(mailToUri.toString());
  if (await canLaunchUrl(mailToUri)) {
    await launchUrl(mailToUri);
  } else {
    throw 'Could not launch $mailToUri';
  }
}*/
