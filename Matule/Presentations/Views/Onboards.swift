//
//  Onboards.swift
//  Matule
//
//  Created by Евгений Михайлов on 19.02.2025.
//  Представление с онбордами

import SwiftUI

struct Onboard1: View {
    var body: some View {
        VStack {
            Text("ДОБРО\nПОЖАЛОВАТЬ")
                .multilineTextAlignment(.center)
                .customFont(fontSize: 30, weight: .bold, foreground: .block)
                .padding(.top, 70)
                .padding(.bottom, 122)
            Image("onb1")
                .resizable()
                .scaledToFit()
                .padding(.bottom, 21)
        }
    }
}
struct Onboard2: View {
    var body: some View {
        VStack {
            Image("onb2")
                .resizable()
                .scaledToFit()
                .padding(.top, 80)
                .padding(.bottom, 60)
            Text("Начнем\nпутешествие")
                .customFont(fontSize: 30, weight: .regular, foreground: .block)
                .multilineTextAlignment(.center)
                .padding(.bottom, 12)
            Text("Умная, великолепная и модная\nколлекция Изучите сейчас")
                .customFont(fontSize: 16, weight: .regular, foreground: .subTextLight)
                .multilineTextAlignment(.center)
                .padding(.bottom, 35)
                .padding(.horizontal, 26)
            
            
            
        }
    }
}
struct Onboard3: View {
    var body: some View {
        VStack {
            Image("onb3")
                .resizable()
                .scaledToFit()
                .padding(.top, 80)
                .padding(.bottom, 60)
            Text("У Вас Есть Сила,\nЧтобы")
                .customFont(fontSize: 30, weight: .regular, foreground: .block)
                .multilineTextAlignment(.center)
                .padding(.bottom, 12)
            Text("В вашей комнате много красивых и\nпривлекательных растений")
                .customFont(fontSize: 16, weight: .regular, foreground: .subTextLight)
                .multilineTextAlignment(.center)
                .padding(.bottom, 35)
                .padding(.horizontal, 26)

        }
    }
}

struct Onboards: View {
    @AppStorage("currenOnboard") var currentOnboard = 0
    @AppStorage("navigateToSignInFromOnboard") var isNavigate = false
    var body: some View {
        NavigationStack {
            VStack {
                switch currentOnboard {
                case 0: Onboard1()
                case 1: Onboard2()
                case 2: Onboard3()
                default: Onboard1()
                }
                CustomPageIndicators(currentPage: $currentOnboard)
                Spacer()
                Button(action: {nextOnboard()}) {
                    Text(currentOnboard == 0 ? "Начать" : "Далее")
                }
                .buttonStyle(MainButtonStyle(background: .block, foreground: .text))
                .padding(.horizontal, 20)
                .padding(.bottom, 36)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all)
            .background(LinearGradient(colors: [.accent, .disable], startPoint: .top, endPoint: .bottom))
            .animation(.spring(duration: 0.9), value: currentOnboard)
            .gesture(DragGesture().onEnded({ value in
                nextOnboard(value.translation.width < 50 ? 1 : -1)
            }))
            .navigationDestination(isPresented: $isNavigate) {
                LoginView()
                    .navigationBarBackButtonHidden()
            }
        }
        
    }
    func nextOnboard(_ value: Int = 1) {
        if value == 1 {
            if currentOnboard + value == 3 {
                isNavigate = true
            }
            currentOnboard = currentOnboard + value == 3 ? currentOnboard : currentOnboard + value
        }
        else {
            currentOnboard = currentOnboard + value == -1 ? currentOnboard : currentOnboard + value
            
        }
    }
}

#Preview {
    Onboards()
}
