//
//  ContentView.swift
//  Pokemon-iOS-Seri
//
//  Created by  瀬利純樹 on 2024/09/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
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
        .padding()
    }
}

#Preview {
    ContentView()
}
