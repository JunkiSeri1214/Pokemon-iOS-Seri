//
//  PokemonDetailView.swift
//  Pokemon-iOS-Seri
//
//  Created by  瀬利純樹 on 2024/09/30.
//

import SwiftUI

struct PokemonDetailView: View {    
    
    var pokemon: Pokemon
    
    var body: some View {
        VStack {
             // ポケモンの画像を中央に表示
             AsyncImage(url: URL(string: pokemon.sprites.front_default)) { image in
                 image
                     .resizable()
                     .scaledToFit()
                     .frame(width: 200, height: 200)
                     .padding()
             } placeholder: {
                 ProgressView()
             }
             
             // ポケモンのIDを表示
             Text("No.\(pokemon.id)")
                 .font(.title)
                 .fontWeight(.bold)
                 .padding(.top, 10)
             
             // ポケモン名を表示
             Text(pokemon.name.capitalized)
                 .font(.title)
                 .fontWeight(.medium)
                 .padding(.bottom, 10)
         }
    }
}
