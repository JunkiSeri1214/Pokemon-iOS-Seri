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
    
    // ポケモンAPIのURL
    let apiUrl = "https://pokeapi.co/api/v2/pokemon/"
    
    // 取得するポケモンの数
    let limit = 151
    
    // すべてのポケモンの詳細情報を格納する配列
    var allPokemons: [Pokemon] = []
    
    /// 全てのポケモンを取得して配列で返すメソッド
    func getAllPokemon(completion: @escaping ([Pokemon]) -> Void) {
        
        // 1番かリミットの数まで順番にAPIを呼び出す
        for index in 1...limit {
            // 各ポケモンのURL
            guard let url = URL(string: "\(apiUrl)\(index)") else { continue }
            
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
                    
                    // メインスレッドで配列を更新
                    DispatchQueue.main.async {
                        self.allPokemons.append(pokemon)
                        // すべてのポケモンが揃ったら呼び出し元に配列を返す
                        if self.allPokemons.count == self.limit {
                            // ID順にソートしてから呼び出し元へ返す
                            completion(self.allPokemons.sorted { $0.id < $1.id })
                        }
                    }
                } catch {
                    print("デコードエラー: \(error)")
                }
            }.resume()
        }
    }
}
