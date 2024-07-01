//
//  SuffixWrapper.swift
//  project_b
//
//  Created by 米樵 on 2024/6/27.
//

@propertyWrapper
struct Suffix: Equatable {
    var wrappedValue: Double // 固定写法，必须叫这个名字
    private let suffix: String

    init(wrappedValue: Double, _ suffix: String) {
        self.wrappedValue = wrappedValue
        self.suffix = suffix
    }

    var projectedValue: String {
        wrappedValue.formatted() + " \(suffix)"
    }
}
