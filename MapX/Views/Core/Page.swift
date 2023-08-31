//
//  Page.swift
//  MapX
//
//  Created by Tokyo on 31/08/23.
//

import SwiftUI

struct Page<Content: View>: View {
    private let content: Content
    
    init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
    }
}

struct Page_Previews: PreviewProvider {
    static var previews: some View {
        Page {
            Text("Page")
        }
    }
}
