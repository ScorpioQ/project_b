//
//  Extensions.swift
//  project_b
//
//  Created by 米樵 on 2024/6/27.
//

import SwiftUI

extension View {
    func mainBtnStyle() -> some View {
        controlSize(.large) // 控制类组件的大小，比如按钮
            .buttonBorderShape(.capsule) // 按钮边缘类型，胶囊
    }

    func roundedRectBackground(radius: CGFloat = 8, fill: some ShapeStyle = Color.bg) -> some View {
        background(RoundedRectangle(cornerRadius: radius).foregroundStyle(fill))
    }
}

extension Animation {
    static let mySpring = Animation.spring(dampingFraction: 0.5)
    static let myEase = Animation.easeInOut(duration: 0.6)
}

extension Color {
    static let bg = Color(.systemBackground)
    static let bg2 = Color(.secondarySystemBackground)
}

extension AnyTransition {
    static let moveUpWithOpacity = AnyTransition.move(edge: .top).combined(with: .opacity)
    static let delayInsertionOpacity = AnyTransition.asymmetric( // 分别指定入场、出场动画
        insertion: .opacity.animation(.easeInOut(duration: 0.5).delay(0.2)),
        removal: .opacity.animation(.easeInOut(duration: 0.4))
    )
}
