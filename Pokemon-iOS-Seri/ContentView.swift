//
//  ContentView.swift
//  Pokemon-iOS-Seri
//
//  Created by  瀬利純樹 on 2024/09/27.
//

import SwiftUI

struct ContentView: View {
    
    // レイアウトを2列に設定
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        
        // 縦方向にスクロールを設定
        ScrollView {
            // 2列で表示
            LazyVGrid(columns: columns) {
                // 151個表示
                ForEach(1..<152) { index in
                    ZStack {
                        Circle()
                            .trim(from: 0.5, to: 1.0)
                            .fill(.red)
                            .overlay(
                                Circle()
                                    .trim(from: 0.5, to: 1.0)
                                    .stroke(.black, lineWidth: 1)
                            )
                        Circle()
                            .trim(from: 0, to: 0.5)
                            .fill(.white)
                            .overlay(
                                Circle()
                                    .trim(from: 0, to: 0.5)
                                    .stroke(.black, lineWidth: 1)
                            )
                    }
                }
                .padding()
            }
        }
        // 画面が表示されたときに実行される
        .onAppear {
            // PokemonAPIのインスタンスを生成
            let api = PokemonAPI()
            // APIを使って全てのポケモンデータを取得
            api.getAllPokemon { allPokemons in
                // 取得した各ポケモンの情報を1件ずつループしてコンソールに出力
                for pokemon in allPokemons {
                    print("ID: \(pokemon.id), 名前: \(pokemon.name), 画像URL: \(pokemon.sprites.front_default)")
                }
                // 取得できたポケモンの件数をコンソールに表示
                print(allPokemons.count)
            }
        }
    }
}

#Preview {
    ContentView()
}
