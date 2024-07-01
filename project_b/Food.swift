//
//  Food.swift
//  project_b
//
//  Created by 米樵 on 2024/6/18.
//

struct Food: Equatable {
    var name: String
    var image: String
    @Suffix("大卡") var calorie: Double = .zero
    @Suffix("g") var carb: Double = .zero
    @Suffix("g") var fat: Double = .zero
    @Suffix("g") var protein: Double = .zero

    static let examples = [
        Food(name: "汉堡", image: "🍔", calorie: 294, carb: 14, fat: 24, protein: 17),
        Food(name: "沙拉", image: "🥗", calorie: 89, carb: 20, fat: 0, protein: 1.8),
        Food(name: "披萨", image: "🍕", calorie: 266, carb: 33, fat: 10, protein: 11),
        Food(name: "意大利面", image: "🍝", calorie: 339, carb: 74, fat: 1.1, protein: 12),
        Food(name: "火锅", image: "🍲🌽", calorie: 233, carb: 26.5, fat: 17, protein: 22),
    ]
}
