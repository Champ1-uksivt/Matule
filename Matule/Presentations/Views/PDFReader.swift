//
//  PDFReader.swift
//  Matule
//
//  Created by uksivt on 20.02.2025.
//

import SwiftUI
import PDFKit


struct PDFReader : UIViewRepresentable {
    let url: URL = Bundle.main.url(forResource: "политика", withExtension: "pdf")!
    
    
    func makeUIView(context: Context) -> some UIView {
        let pdf = PDFView()
        pdf.document = PDFDocument(url: url)
        pdf.autoScales = true
        return pdf
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

#Preview {
    PDFReader()
}
