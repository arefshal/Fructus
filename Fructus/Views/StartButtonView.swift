//
//  StartButtonView.swift
//  Fructus
//
//  Created by Aref Shalchi on 2/25/25.
//

import SwiftUI

struct StartButtonView: View {
    //MARK: - PROPERTIES
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    //MARK: - BODY
    var body: some View {
        Button(action: {
            isOnboarding = false
        }) {
            HStack(spacing: 8) {
                Text("Start")
                    .font(.title)
                    .accentColor(.white)
                Image(systemName: "arrow.right.circle")
                    .imageScale(.large)
                    .accentColor(.white)
            }
            .padding(.horizontal, 16)
            
            
        } //: BUTTON
        .padding()
        .background(
            Capsule().strokeBorder(Color.white, lineWidth: 1.25)
            )}
        
    }


#Preview {
    StartButtonView()
}
