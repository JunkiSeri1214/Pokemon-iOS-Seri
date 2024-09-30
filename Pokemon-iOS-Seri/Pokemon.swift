//
//  Pokemon.swift
//  Pokemon-iOS-Seri
//
//  Created by 瀬利純樹 on 2024/09/29.
//

import Foundation

/// ポケモンの基本情報を表す構造体
struct Pokemon: Codable, Identifiable {
    let id: Int         // ポケモンのID
    let name: String    // ポケモンの名前
    let sprites: Sprites // ポケモンの画像情報
}

/// ポケモンの画像情報を表す構造体
struct Sprites: Codable {
    let front_default: String  // ポケモンの正面画像URL
}
