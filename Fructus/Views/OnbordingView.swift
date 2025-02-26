//
//  OnbordingView.swift
//  Fructus
//
//  Created by Aref Shalchi on 2/26/25.
//

import SwiftUI

struct OnbordingView: View {
    //MARK: - PROPERTIES
    @State private var isAnimating: Bool = false
        
    //MARK: - BODY
    var body: some View {
       TabView {
           ForEach(fruitsData) { item in
               FruitCardView(fruit: item)
                  .onAppear {
                      withAnimation(.easeOut(duration: 0.5)) {
                          isAnimating = true
                      }
                  }
                  .onDisappear {
                      isAnimating = false
                  }
           }
       }//: TABVIEW
         .tabViewStyle(PageTabViewStyle())
         .padding(.vertical, 20)
         .animation(.easeInOut, value: isAnimating)
         .transition(.slide)
    }
}

#Preview {
    OnbordingView()
}
