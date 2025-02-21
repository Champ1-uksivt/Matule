//
//  ProfileView.swift
//  Matule
//
//  Created by Михайлов Евгений on 21.02.2025.
//  Экран профиля

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @StateObject var model: MainViewModel
    @State var item: PhotosPickerItem?
    @State var image: UIImage?
    var body: some View {
        ScrollView {
            VStack {
                if !model.profileIsEditable {
                    HStack {
                        Button(action: {
                            model.showSideMenu = true
                        }) {
                            Image("hamb")
                        }
                        Spacer()
                        Text("Профиль")
                            .customFont(fontSize: 16, weight: .regular, foreground: .text)
                        Spacer()
                        Button(action: {
                            model.profileIsEditable = true
                        }) {
                            ZStack {
                                Circle()
                                    .foregroundColor(Color.accent)
                                Image("pencil")
                                
                            }
                        }
                        .frame(maxWidth: 25, maxHeight: 25)
                    }
                    .padding(.top, 55)
                    if let image = self.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 96)
                            .clipShape(Circle())
                            .padding(.top, 43)
                    }
                    else {
                        Image("ava")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 96)
                            .clipShape(Circle())
                            .padding(.top, 43)
                    }
                    Text("\(model.user?.userMetadata["name"]?.stringValue ?? "Emmanuel") \(model.user?.userMetadata["lastname"]?.stringValue ?? "Oyiboke")")
                        .customFont(fontSize: 20, weight: .regular, foreground: .text)
                        .padding(.top,8)
                        .padding(.bottom, 35)
                    NavigationLink(destination: BarCodeView(image: "barcode")) {
                        Image("barcode")
                            .resizable()
                            .scaledToFit()
                            .padding(.bottom ,21)
                    }
                    CustomTextField(label: "Имя", placeholder: "", text: Binding(get: {
                        model.user?.userMetadata["name"]?.stringValue ?? ""
                    }, set: { value in
                        model.user?.userMetadata["name"] = .string(value)
                    }), space: 16)
                    .padding(.bottom, 17)
                    .disabled(!model.profileIsEditable)
                    
                    CustomTextField(label: "Фамилия", placeholder: "", text: Binding(get: {
                        model.user?.userMetadata["lastname"]?.stringValue ?? ""
                    }, set: { value in
                        model.user?.userMetadata["lastname"] = .string(value)
                    }), space: 16)
                    .padding(.bottom, 17)
                    .disabled(!model.profileIsEditable)
                    
                    CustomTextField(label: "Адрес", placeholder: "", text: Binding(get: {
                        model.user?.userMetadata["address"]?.stringValue ?? ""
                    }, set: { value in
                        model.user?.userMetadata["address"] = .string(value)
                    }), space: 16)
                    .padding(.bottom, 17)
                    .disabled(!model.profileIsEditable)
                    CustomTextField(label: "Телефон", placeholder: "", text: Binding(get: {
                        model.user?.userMetadata["phone"]?.stringValue ?? ""
                    }, set: { value in
                        model.user?.userMetadata["phone"] = .string(value)
                    }), space: 16)
                    .padding(.bottom, 17)
                    .disabled(!model.profileIsEditable)
                }
                else {
                    Button(action: {
                        model.profileIsEditable = false
                        model.updateUserProfile()
                    }) {
                        Text("Сохранить")
                    }
                    .buttonStyle(MainButtonStyle(background: .accent, foreground: .block))
                    .frame(maxWidth: 212, minHeight: 32,maxHeight: 32)
                    .padding(.top, 55)
                    if let image = self.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 96)
                            .clipShape(Circle())
                            .padding(.top, 43)
                    }
                    else {
                        Image("ava")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 96)
                            .clipShape(Circle())
                            .padding(.top, 43)
                    }
                    
                    Text("\(model.user?.userMetadata["name"]?.stringValue ?? "Emmanuel") \(model.user?.userMetadata["lastname"]?.stringValue ?? "Oyiboke")")
                        .customFont(fontSize: 20, weight: .regular, foreground: .text)
                        .padding(.top,8)
                    PhotosPicker(selection: $item,matching: .images ,photoLibrary: .shared()) {
                        Text("Изменить фото профиль")
                            .customFont(fontSize: 12, weight: .regular, foreground: .accent)
                            .padding(.top,8)
                            .padding(.bottom, 21)
                    }
                    .onChange(of: item) { newValue in
                        if let newValue = newValue {
                            Task {
                                if let data = try? await newValue.loadTransferable(type: Data.self), let image = UIImage(data: data) {
                                    self.image = image
                                }
                            }
                        }
                    }
                    CustomTextField(label: "Имя", placeholder: "", text: Binding(get: {
                        model.user?.userMetadata["name"]?.stringValue ?? ""
                    }, set: { value in
                        model.user?.userMetadata["name"] = .string(value)
                    }), space: 16)
                    .padding(.bottom, 17)
                    .disabled(!model.profileIsEditable)
                    
                    CustomTextField(label: "Фамилия", placeholder: "", text: Binding(get: {
                        model.user?.userMetadata["lastname"]?.stringValue ?? ""
                    }, set: { value in
                        model.user?.userMetadata["lastname"] = .string(value)
                    }), space: 16)
                    .padding(.bottom, 17)
                    .disabled(!model.profileIsEditable)
                    
                    CustomTextField(label: "Адрес", placeholder: "", text: Binding(get: {
                        model.user?.userMetadata["address"]?.stringValue ?? ""
                    }, set: { value in
                        model.user?.userMetadata["address"] = .string(value)
                    }), space: 16)
                    .padding(.bottom, 17)
                    .disabled(!model.profileIsEditable)
                    CustomTextField(label: "Телефон", placeholder: "", text: Binding(get: {
                        model.user?.userMetadata["phone"]?.stringValue ?? ""
                    }, set: { value in
                        model.user?.userMetadata["phone"] = .string(value)
                    }), space: 16)
                    .padding(.bottom, 17)
                    .disabled(!model.profileIsEditable)
                }
            }
            .padding(.horizontal, 20)

            .onAppear {
                UIScreen.main.brightness = model.light
            }
        }
        .ignoresSafeArea(.all)
        .background(Color.block)

    }
}

#Preview {
    ProfileView(model: MainViewModel())
}
