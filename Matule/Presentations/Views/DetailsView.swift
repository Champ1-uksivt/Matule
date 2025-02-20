//
//  DetailsView.swift
//  Matule
//
//  Created by Михайлов Евгений on 20.02.2025.
//  Представление для отображения подробной информации о кроссовке

import SwiftUI
import Kingfisher

struct DetailsView: View {
    @StateObject var model: MainViewModel
    @Environment(\.presentationMode) var pm
    @State var showFullDescribe = false
    var body: some View {
            VStack {
                HStack {
                    Button {
                        pm.wrappedValue.dismiss()
                    } label: {
                        ZStack {
                            Circle()
                                .foregroundColor(Color.block)
                            Image("arrow.left")
                            
                        }
                    }
                    Spacer()
                    Text("Sneaker Shop")
                        .customFont(fontSize: 16, weight: .regular, foreground: .text)
                    Spacer()
                    Button(action: {
                        print("cart")
                    }) {
                        ZStack {
                            Circle()
                                .foregroundColor(Color.block)
                                .overlay {
                                    Circle()
                                        .frame(maxWidth: 8, maxHeight: 8)
                                        .foregroundColor(Color.customRed)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                        .offset(x: -3, y: 3)
                                }
                            Image("bag.black")
                            
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 44)
                .padding(.bottom, 26)
                .padding(.horizontal, 20)
                ScrollView {
                    VStack {
                        ForEach(model.sneakers.indices, id: \.self) { index in
                            if index == model.selectedSneaker {
                                Text(model.sneakers[index].fullname)
                                    .customFont(fontSize: 26, weight: .regular, foreground: .text)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading, 20)
                                    .padding(.bottom, 7)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        Text("Men’s Shoes")
                            .customFont(fontSize: 16, weight: .regular, foreground: .hint)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 11)
                        ForEach(model.sneakers.indices, id: \.self) { index in
                            if index == model.selectedSneaker {
                                Text(model.sneakers[index].price.price())
                                    .customFont(fontSize: 24, weight: .regular, foreground: .text)
                                    .padding(.leading, 20)
                                    .padding(.bottom,22)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        TabView(selection: $model.selectedSneaker) {
                            ForEach(model.sneakers.indices, id: \.self) { index in
                                    KFImage(model.sneakers[index].imageULR)
                                        .resizable()
                                        .scaledToFit()
                                        .padding(.horizontal, 67)
                                        .tag(index)
                                
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .animation(.spring, value: model.selectedSneaker)
                        .frame(maxWidth: .infinity, minHeight: 125)
                        .shadow(color: .gray.opacity(0.5), radius: 30, y: 30)
                        Image("podium")
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 12)
                            .padding(.bottom, 37)
                        ScrollView(.horizontal) {
                            HStack(spacing: 14) {
                                Spacer()
                                    .frame(width: 10)
                                ForEach(model.sneakers.indices, id: \.self) { index in
                                    Button(action: {
                                        model.selectedSneaker = index
                                    }) {
                                        RoundedRectangle(cornerRadius: 16)
                                            .frame(width: 56, height: 56)
                                            .foregroundColor(Color.block)
                                            .overlay {
                                                KFImage(model.sneakers[index].imageULR)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .scaleEffect(0.75)
                                            }
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 16)
                                                    .stroke(model.selectedSneaker == index ? .accent : .block, lineWidth: 3)
                                                    .padding(1.5)
                                            }
                                    }
                                }
                                Spacer()
                                    .frame(width: 10)
                                
                            }
                        }
                        .scrollIndicators(.never)
                        .padding(.bottom, 33)
                        ForEach(model.sneakers.indices, id: \.self) { index in
                            if index == model.selectedSneaker {
                                Text(model.sneakers[index].description)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(showFullDescribe ? nil : 3)
                                    .customFont(fontSize: 14, weight: .regular, foreground: .hint)
                                    .padding(.horizontal, 20)
                                    .lineSpacing(4)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        Button(action: {
                            showFullDescribe.toggle()
                        }) {
                            Text(showFullDescribe ? "Меньше" : "Подробнее")
                                .customFont(fontSize: 14, weight: .regular, foreground: .accent)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal, 20)
                        .padding(.top, 5)
                    }
                    
                }
                HStack(spacing: 18) {
                    Button {
                        
                    } label: {
                        ZStack {
                            Circle()
                                .foregroundColor(Color.colorGray.opacity(0.4))
                            Image("heart.unfill.big")
                        }
                    }
                    Button {
                        
                    } label: {
                        Text("В Корзину")
                            .customFont(fontSize: 14, weight: .regular, foreground: .block)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .overlay {
                                Image("bag.white")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 12)
                            }
                            .background(Color.accent)
                            .cornerRadius(14)
                    }

                }
                .frame(maxWidth: .infinity, maxHeight: 52)
                .padding(.horizontal, 20)

        }
        .background(Color.background)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    DetailsView(model: MainViewModel())
}
