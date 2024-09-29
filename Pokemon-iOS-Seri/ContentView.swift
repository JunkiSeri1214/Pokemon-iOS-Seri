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
    }
    
}

#Preview {
    ContentView()
}
