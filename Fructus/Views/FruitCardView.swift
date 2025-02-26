//
//  FruitCardView.swift
//  Fructus
//
//  Created by Aref Shalchi on 2/25/25.
//

import SwiftUI

struct FruitCardView: View {
    
    // MARK: - PROPERTIES
    var fruit: Fruit
    @State private var isAnimating: Bool = false
  
    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Image(fruit.image)
                    .resizable()
                    .scaledToFit()
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
                    .scaleEffect(isAnimating ? 1.0 : 0.6)
                    .offset(y: isAnimating ? 0 : -50)
                    .animation(
                        .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6), value: isAnimating)
                Text(fruit.title)
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
                
                Text(fruit.headline)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .frame(maxWidth: 480)
                StartButtonView()
                
            }  //: VSTACK
        }  //: ZSTACK
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(
            LinearGradient(
                gradient: Gradient(colors: fruit.gradientColors),
                startPoint: .top, endPoint: .bottom)
        )
        
        .cornerRadius(20)
        
        .onAppear {
            isAnimating = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeOut(duration: 0.8)) {
                    isAnimating = true
                }
            }
        }
        .onDisappear {
            isAnimating = false 
        }
        .padding(.horizontal, 20)
        
    }
}

#Preview{
    FruitCardView(fruit: fruitsData[0])
    
}
