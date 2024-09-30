//
//  PokemonListViewModel.swift
//  Pokemon-iOS-Seri
//
//  Created by  瀬利純樹 on 2024/09/30.
//

import SwiftUI
import Combine

/// ポケモンAPIを呼び出すクラス
class  PokemonListViewModel: ObservableObject {
    
    // ポケモンAPIのURL
    let apiUrl = "https://pokeapi.co/api/v2/pokemon/"
    
    // 取得するポケモンの数
    let limit = 151
    
    // すべてのポケモンの詳細情報を格納する配列
    @Published var allPokemons: [Pokemon] = []
    
    /// 全てのポケモンを取得して配列で返すメソッド
    func getAllPokemon() {
        // 一時的にポケモンを格納する配列
        var temporaryPokemonList: [Pokemon] = []
        
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
                        temporaryPokemonList.append(pokemon)
                        // すべてのポケモンが揃ったら呼び出し元に配列を返す
                        if temporaryPokemonList.count == self.limit {
                            // ID順にソートしてから呼び出し元へ返す
                            self.allPokemons = temporaryPokemonList.sorted { $0.id < $1.id }
                        }
                    }
                } catch {
                    print("デコードエラー: \(error)")
                }
            }.resume()
        }
    }
}
