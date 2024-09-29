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
    
    // ポケモンのデータを保持する状態変数
    @State private var pokemons: [Pokemon] = []
    
    var body: some View {
        // 縦方向にスクロールを設定
        ScrollView {
            // 2列で表示
            LazyVGrid(columns: columns) {
                // 151個表示
                ForEach(pokemons) { pokemon in
                    ZStack {
                        Circle()
                            .trim(from: 0.5, to: 1.0)
                            .fill(.red)
                            .frame(width: 185, height: 185)
                            .overlay(
                                Circle()
                                    .trim(from: 0.5, to: 1.0)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        Circle()
                            .trim(from: 0, to: 0.5)
                            .fill(.white)
                            .frame(width: 185, height: 185)
                            .overlay(
                                Circle()
                                    .trim(from: 0, to: 0.5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        Rectangle()
                            .fill(Color.black)
                            .frame(width: 185, height: 1)
                        
                        VStack(spacing: -5) {
                            Text("No.\(pokemon.id)")
                                .fontWeight(.bold)
                            AsyncImage(url: URL(string: pokemon.sprites.front_default)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 120)
                            } placeholder: {
                                ProgressView()
                            }
                            Text(pokemon.name)
                                .font(.subheadline)
                        }
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
                self.pokemons = allPokemons
            }
        }
    }
}

#Preview {
    ContentView()
}
