//
//  ContentView.swift
//  project_b
//
//  Created by 米樵 on 2024/5/11.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var target: Food?
    @State private var isShowInfo: Bool = false

    let foodList = Food.examples

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                foodImage

                Text("今天吃啥？").bold()

                selectedFoodInfoView

                Spacer().layoutPriority(1)

                randomBtn
                resetBtn
            }
            .padding() // 各组件保持一定间距
            .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height - 100) // , maxHeight: .infinity) // 框架高度无限，可以让背景色盖满
            .font(.title)
            .mainBtnStyle()
            .animation(.mySpring, value: isShowInfo) // 监听showInfo变量的变化，
            .animation(.myEase, value: target) // 监听target变量的变化，
        }
        .background(Color.bg2) // 背景指定颜色
    }
}

// MARK: - -- SubView ---

private extension ContentView {
    var foodImage: some View {
        Group {
            if target != .none {
                Text(target?.image ?? "")
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.1)
                    .lineLimit(1)
            } else {
                Image("finder")
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/ .fit/*@END_MENU_TOKEN@*/)
                    .padding(.all, 30.0)
            }
        }
        .frame(height: 250)
        // .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
    }

    var foodNameView: some View {
        HStack {
            Text(target?.name ?? "")
                .font(.largeTitle)
                .bold() // 粗体
                .foregroundStyle(.green) // 字体颜色
                .id(target?.name) // 让每次变化之后的id不同，系统自动引入转场动画，否则某些系统版本下相同View的改变动画会有些奇怪,转场动画会让这个Text有被换的感觉
                // .transition(.scale.combined(with: .slide)) // 指定转场效果 .scale 缩放效果 .combined 结合其他效果 .slide滑动
                .transition(.delayInsertionOpacity)

            Button(action: {
                isShowInfo.toggle()
            }, label: {
                Image(systemName: "info.circle.fill")
                    .foregroundStyle(.secondary)

            }).buttonStyle(.plain)
        }
    }

    var foodDetailView: some View {
        VStack {
            if isShowInfo {
//                HStack {
//                    VStack(spacing: 12) {
//                        Text("蛋白质")
//                        Text(target!.protein.formatted() + "g")
//                    }
//
//                    Divider().frame(width: 1).padding(.horizontal)
//
//                    VStack(spacing: 12) {
//                        Text("脂肪")
//                        Text(target!.fat.formatted() + "g")
//                    }
//
//                    Divider().frame(width: 1).padding(.horizontal)
//
//                    VStack(spacing: 12) {
//                        Text("碳水")
//                        Text(target!.carb.formatted() + "g")
//                    }
//                }
//                .font(.title3)
//                .padding()
//                .padding(.horizontal)
//                .background(RoundedRectangle(cornerRadius: 8).foregroundStyle(Color(.systemBackground)))

                Grid(horizontalSpacing: 12, verticalSpacing: 12) {
                    GridRow {
                        Text("蛋白质")
                        Text("脂肪")
                        Text("碳水")
                    }.frame(minWidth: 60)

                    Divider()
                        .gridCellUnsizedAxes(.horizontal)
                        .padding(.horizontal, -10)

                    GridRow {
                        Text(target!.$protein)
                        Text(target!.$fat)
                        Text(target!.$carb)
                    }
                }
                .font(.title3)
                .padding()
                .padding(.horizontal)
                .roundedRectBackground()
                .transition(.moveUpWithOpacity)
            }
        }
        .frame(maxWidth: .infinity)
        .clipped()
    }

    @ViewBuilder var selectedFoodInfoView: some View {
        if target != .none {
            foodNameView

            Text("热量 \(target!.$calorie)").font(.title2)

            foodDetailView
        }
    }

    var randomBtn: some View {
        Button(role: .none) {
            target = foodList.shuffled().filter { $0 != target }.first
        } label: {
            Text(target == .none ? "随机一个" : "换一个")
                .frame(width: 200) // 指定文字宽度200
                .animation(.none, value: target) // 无动画，秒变
                .transformEffect(/*@START_MENU_TOKEN@*/ .identity/*@END_MENU_TOKEN@*/) // 显示指定位置，在变化时跟随按钮
        }
        .buttonStyle(.borderedProminent)
        .padding(.bottom, -15) // 指定底部间距减15
    }

    var resetBtn: some View {
        Button(role: .none) {
            target = .none
            isShowInfo = false
        } label: {
            Text("重置")
                .frame(width: 200) // 指定文字宽度200
        }
        .buttonStyle(.bordered)
    }
}

// --- Debug Init ---
extension ContentView {
    init(target: Food) {
        _target = State(wrappedValue: target)
    }
}

#Preview {
    ContentView(target: Food.examples.first!)
        .modelContainer(for: Item.self, inMemory: true)
}
