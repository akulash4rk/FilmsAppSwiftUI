//
//  YouTubeTrailer.swift
//  SomeFilms
//
//  Created by Владислав Баранов on 11.07.2024.
//

import Foundation
import SwiftUI
import WebKit

struct YouTubeTrailer: UIViewRepresentable {
    let videoURL: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let youtubeURL = URL(string: videoURL) else { return }
        uiView.load(URLRequest(url: youtubeURL))
    }
}


struct YouTubeTrailer_Previews: PreviewProvider {
    static var previews: some View {
        YouTubeTrailer(videoURL: "https://www.youtube.com/embed/ZsJz2TJAPjw")
    }
}
