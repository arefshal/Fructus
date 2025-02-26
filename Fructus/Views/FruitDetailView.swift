//
//  FruitDetailView.swift
//  Fructus
//
//  Created by Aref Shalchi on 2/26/25.
//

import SwiftUI

struct FruitDetailView: View {
    // MARK: - PROPERTIES
    var fruit: Fruit
    @State private var scrollOffset: CGFloat = 0
    @State private var showNavBarTitle: Bool = false
    @State private var imageScale: CGFloat = 1.0
    @Environment(\.presentationMode) var presentationMode
    @GestureState private var dragOffset = CGSize.zero
    @State private var isAnimatingDismiss: Bool = false
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            // Main content
            ScrollView(.vertical, showsIndicators: false) {
                GeometryReader { geometry in
                    let scrollY = geometry.frame(in: .global).minY
                    
                    ZStack {
                        // HEADER
                        LinearGradient(
                            gradient: Gradient(colors: fruit.gradientColors),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    }
                    .frame(width: geometry.size.width, height: max(310 + scrollY, 310))
                    .onAppear {
                        scrollOffset = scrollY
                    }
                    .onChange(of: scrollY) { newValue in
                        scrollOffset = newValue
                        
                        // Show nav bar title when scrolled down
                        withAnimation(.easeInOut) {
                            showNavBarTitle = scrollY < -100
                            
                            // Scale image based on scroll
                            if scrollY < 0 {
                                // When scrolling down, slightly shrink the image
                                imageScale = max(0.8, 1.0 + scrollY / 500)
                            } else {
                                // When pulling down, slightly enlarge the image
                                imageScale = min(1.2, 1.0 + scrollY / 500)
                            }
                        }
                        
                        // If pulled down more than 100 points, go back
                        if scrollY > 100 {
                            dismissWithAnimation()
                        }
                    }
                    
                    // Sticky fruit image
                    Image(fruit.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: min(geometry.size.width * 0.7, 300))
                        .scaleEffect(imageScale)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
                        .position(x: geometry.size.width / 2, y: max(geometry.size.height / 2, 155 - min(0, scrollY / 2)))
                }
                .frame(height: 310)
                
                VStack(alignment: .leading, spacing: 20) {
                    // TITLE
                    Text(fruit.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(fruit.gradientColors[1])
                        .padding(.horizontal)
                    
                    // HEADLINE
                    Text(fruit.headline)
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                    
                    // NUTRIENTS
                    GroupBox {
                        DisclosureGroup("Nutritional value per 100g") {
                            Divider().padding(.vertical, 2)
                            
                            VStack(alignment: .leading, spacing: 10) {
                                ForEach(0..<fruit.nutrition.count, id: \.self) { item in
                                    HStack {
                                        Group {
                                            Image(systemName: "info.circle")
                                            Text(fruit.nutrition[item])
                                        }
                                        .foregroundColor(fruit.gradientColors[1])
                                        .font(.system(.body).bold())
                                        
                                        Spacer(minLength: 25)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // SUBHEADLINE
                    Text("LEARN MORE ABOUT \(fruit.title.uppercased())")
                        .fontWeight(.bold)
                        .foregroundColor(fruit.gradientColors[1])
                        .padding(.horizontal)
                    
                    // DESCRIPTION
                    Text(fruit.description)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                    
                    // LINK
                    SourceLinkView()
                        .padding(.top, 10)
                        .padding(.bottom, 40)
                        .padding(.horizontal)
                } //: VSTACK
                .background(Color.white)
                .cornerRadius(20)
                .offset(y: -20)
            } //: SCROLL
            .edgesIgnoringSafeArea(.top)
            .background(Color.white)
            .navigationBarHidden(!showNavBarTitle)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    if showNavBarTitle {
                        HStack {
                            Image(fruit.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .cornerRadius(5)
                            
                            Text(fruit.title)
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        // Only respond to downward drags at the top of the screen
                        if value.startLocation.y < 100 && value.translation.height > 0 {
                            state = value.translation
                        }
                    }
                    .onEnded { value in
                        // If pulled down more than 80 points from the top, go back
                        if value.startLocation.y < 100 && value.translation.height > 80 {
                            dismissWithAnimation()
                        }
                    }
            )
            .overlay(
                // Visual indicator when pulling down
                Rectangle()
                    .frame(width: 40, height: 5)
                    .cornerRadius(3)
                    .foregroundColor(Color.gray.opacity(0.5))
                    .padding(.top, 8)
                    .opacity(dragOffset.height > 0 ? 1 : 0)
                    .animation(.easeInOut, value: dragOffset.height > 0)
                , alignment: .top
            )
            
            // Full-screen dismiss animation overlay
            if isAnimatingDismiss {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                    .opacity(isAnimatingDismiss ? 1 : 0)
                    .animation(.easeInOut(duration: 0.35), value: isAnimatingDismiss)
            }
        }
    }
    
    // MARK: - FUNCTIONS
    func dismissWithAnimation() {
        withAnimation(.easeInOut(duration: 0.2)) {
            isAnimatingDismiss = true
        }
        
        // Delay the actual dismiss to allow animation to play
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

// MARK: - PREVIEW
#Preview {
    NavigationView {
        FruitDetailView(fruit: fruitsData[0])
    }
}
