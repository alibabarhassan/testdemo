//
//  ContentView.swift
//  TestDemo
//
//  Created by Apple on 23/04/2026.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var appEnvironment: AppEnvironment
    
    var body: some View {
        TVShowDetailView(viewModel: appEnvironment.container.makeTVShowDetailViewModel(tvShowId: appEnvironment.container.configuration.defaultTVShowId))
            .environmentObject(appEnvironment)
    }
}

#Preview {
    ContentView()
        .environmentObject(AppEnvironment())
}
