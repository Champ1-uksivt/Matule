//
//  ContactField.swift
//  Matule
//
//  Created by uksivt on 20.02.2025.
//

import SwiftUI

struct ContactField: View {
    @Binding var text: String
    var label: String
    var image: String
    var placeholder: String
    init(text: Binding<String>, label: String, image: String, placeholder: String) {
        self._text = text
        self.label = label
        self.image = image
        self.placeholder = placeholder
    }
    @State var isEdit = false
    @FocusState var isFocused :Bool
    var body: some View {
        HStack(spacing: 12) {
            Group {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color.background)
                    .overlay {
                        Image(image)
                    }
                    .frame(maxWidth: 40, maxHeight: 40)
                VStack(alignment: .leading, spacing: 4) {
                    ZStack(alignment: .leading) {
                        
                        if isEdit {
                            TextField("", text: $text)
                                .customFont(fontSize: 14, weight: .regular, foreground: .text)

                        }
                        else {
                            Text(text.isEmpty ? placeholder : text)
                                .customFont(fontSize: 14, weight: .regular, foreground: .text)
                        }
                        
                    }
                    Text(label)
                        .customFont(fontSize: 12, weight: .regular, foreground: .hint)
                }
                Spacer()
                Button {
                    isEdit.toggle()
                    isFocused = true
                } label: {
                    Image("edit")
                }
            }
            .focused($isFocused)

        }
        .frame(height: 40)
    }
}

