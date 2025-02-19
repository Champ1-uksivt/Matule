//
//  LoginView.swift
//  Matule
//
//  Created by uksivt on 19.02.2025.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        NavigationStack{
            VStack {
                NavigationLink {
                    EmptyView()
                } label: {
                    Text("Пропустить")
                        
                }

            }
        }
    }
}

#Preview {
    LoginView()
}
