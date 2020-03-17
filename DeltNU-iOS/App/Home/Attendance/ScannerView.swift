//
//  ScannerView.swift
//  DeltNU
//
//  Created by Canon Sawrey on 3/17/20.
//  Copyright © 2020 Canon Sawrey. All rights reserved.
//

import SwiftUI
import CodeScanner
 

struct ScannerView: View {
    let handleScan: (Result<String, CodeScannerView.ScanError>) -> Void
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: self.handleScan)
                    .frame(maxWidth: geo.size.width * 2 / 3, maxHeight: geo.size.width * 2 / 3)
                Spacer()
                Image(systemName: "qrcode.viewfinder").font(.system(size: 80))
                        .padding()
                Text("Aim your camera at the code")
                Spacer()
            }
        }
    }
    
    init(_ handler: @escaping (Result<String, CodeScannerView.ScanError>) -> Void) {
        self.handleScan = handler
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView({ _ in
            print("Scanned")
        })
    }
}
