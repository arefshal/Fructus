//
//  FruitHeaderView.swift
//  Fructus
//
//  Created by Aref Shalchi on 2/26/25.
//

import SwiftUI

struct FruitHeaderView: View {
    // MARK: - PROPERTIES
    var fruit: Fruit
    @State private var isAnimatingImage: Bool = false
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: fruit.gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing)
            
            Image(fruit.image)
                .resizable()
                .scaledToFit()
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
                .padding(.vertical, 20)
                .scaleEffect(isAnimatingImage ? 1.0 : 0.6)
                .animation(.easeOut(duration: 0.5), value: isAnimatingImage)
        } //: ZSTACK
        .onAppear() {
            isAnimatingImage = true
        }
        .onDisappear {
            isAnimatingImage = false
        }
    }
}

// MARK: - PREVIEW
#Preview {
    FruitHeaderView(fruit: fruitsData[0])
}
