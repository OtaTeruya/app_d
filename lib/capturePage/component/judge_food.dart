import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class JudgeFood {
  String prompt = '''
          この画像にあるものが、料理かどうかを判定して下さい。
          答え方について、以下に従って下さい。
          - 1つ目
            - 料理の場合: Yes
            - 料理でない場合: No
          - 2つ目
            - 料理である信頼度を0~100で記入して下さい。
          - 3つ目
            - 画像にある料理の名前を考えて下さい。ただし以下のルールに従って下さい。
              - 以下のルールは、上位にあるほど優先順位が高いです。また、全てのルールを満たして下さい。
              - 料理であると判断した場合のみ料理名を考えて下さい。料理でないものは"Not_Food"と記入して下さい。
              - 公序良俗に反するものや、不適切なものは考えないで下さい。
              - 料理名は日本語であること。
              - 料理名は1つだけであること
              - 料理名は、必ず画像の料理の特徴を捉えること
              - 料理名は、遠回しな言い方にすること
              - 料理名は、見た目を生かしたユニークな名前にすること
              - 料理名から、料理を想像できること
              - 料理名は、以下のような形式で考えて下さい。ただし、以下は例であり、必ずしもこの形式である必要はありません。また、料理名は、画像にある料理の特徴を捉えたものである必要があります。
                例：
                - おにぎり → 白銀の結晶
                - 味噌汁 → 黄金の雫
                - カップ麺 → 湯気に包まれた至極の瞬間
                - サラダ → 緑のオアシス
                - オムレツ → 黄金のひだまり
                - チーズフォンデュ → 黄金の滝
                - ハンバーガー → 至高の重なる栄光
              - 以前送信された画像と同じでも、上記を守った上で、できる限り違う料理名を考えて下さい。
          答える時は、各要素を","で区切って下さい。
          以下に解答例を示します。
          - Yes,100,湯気に包まれた至極の瞬間
          - No,0,Not_Food
        ''';

  Future<String> judge(String imgPath) async {
    try {
      var apiKey = dotenv.get('GEMINI_API_KEY', fallback: '');
      if (apiKey.isEmpty) {
        print('API Key取得失敗');
        exit(1);
      }

      File imageFile = File(imgPath);
      final bytes = await imageFile.readAsBytes();

      final genModel = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
      );
      final content = [
        Content.multi([
          TextPart(prompt),
          DataPart(getMimeType(imgPath), bytes),
        ]),
      ];

      final response = await genModel.generateContent(content);
      String resText = response.text ?? 'Gemini返答失敗';
      return resText;
    } catch (e) {
      print('エラー: $e');
      return 'Gemini返答失敗';
    }
  }

  String getMimeType(String filePath) {
    if (filePath.endsWith('.jpg') || filePath.endsWith('.jpeg')) {
      return 'image/jpeg';
    } else if (filePath.endsWith('.png')) {
      return 'image/png';
    } else {
      throw UnsupportedError('サポートされていないファイル形式です: $filePath');
    }
  }
}
