//
//  ContentView.swift
//  Pokemon-iOS-Seri
//
//  Created by  瀬利純樹 on 2024/09/27.
//

import SwiftUI

/// メイン画面となるビューを表す構造体
/// ポケモン一覧を表示し、個別のポケモンを選択して詳細画面に遷移できる。
struct ContentView: View {
    
    // レイアウトを2列に設定
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    /// ポケモンのデータを保持する状態変数
    @State private var pokemons: [Pokemon] = []
    
    /// 初期化時にナビゲーションバーの外観をリセットしてオリジナルの内容を設定
    init() {
        // ナビゲーションバーの外観設定用インスタンス
        let appearance = UINavigationBarAppearance()
        // 背景を不透明に設定し、背景色を反映させる
        appearance.configureWithOpaqueBackground()
        // ナビゲーションバーの背景色を赤に設定
        appearance.backgroundColor = UIColor.red
        // タイトル文字色を白に設定
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        // オリジナルデザインを適用
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            // 縦方向にスクロールを設定
            ScrollView {
                // 2列で表示
                LazyVGrid(columns: columns) {
                    // 151個表示
                    ForEach(pokemons) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                            // ボールデザインを作成
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
                                        .foregroundColor(.black)
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
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            // ナビゲーションタイトル
            .navigationTitle("ポケモン一覧画面")
            // ナビゲーションのタイトルを中央表示
            .navigationBarTitleDisplayMode(.inline)
        }
        // ナビゲーションバーのリンクおよび戻るボタンの色を白に設定
        .tint(.white)
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
