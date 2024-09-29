//
//  Pokemon.swift
//  Pokemon-iOS-Seri
//
//  Created by 瀬利純樹 on 2024/09/29.
//

import Foundation

/// ポケモンの基本情報を表す構造体
struct Pokemon: Codable {
    let id: Int         // ポケモンのID
    let name: String    // ポケモンの名前
    let sprites: Sprites // ポケモンの画像情報
}

/// ポケモンの画像情報を表す構造体
struct Sprites: Codable {
    let front_default: String  // ポケモンの正面画像URL
}

/// ポケモンAPIを呼び出すクラス
class PokemonAPI {
    func getPokemon(from url: String) {
        
        // URLが無効な場合は終了
        guard let url = URL(string: url) else {
            return
        }
        
        // データ取得を非同期で実行する
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            // エラー発生した場合は終了
            if let error = error {
                return
            }

            //　データがnilの場合は終了
            guard let data = data else {
                return
            }

            do {
                // 取得したJSONを構造体へ変換
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                print("ID: \(pokemon.id)")
                print("名前: \(pokemon.name)")
                print("画像URL: \(pokemon.sprites.front_default)")
            } catch {
                print("デコードエラー: \(error)")
            }
        }.resume()
    }
}
