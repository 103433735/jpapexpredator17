//
//  ContentView.swift
//  JPApexPredators17
//
//  Created by Hartzed Story on 10/15/24.
//

import SwiftUI

struct ContentView: View {
    let predators = Predators()
    @State var searchText = ""
    @State var alphabetical = false
    @State var currentSelection = ApexPredator.PredatorType.all
    var filteredDinos: [ApexPredator] {
        predators.filter(by: currentSelection)
        predators.sort(by: alphabetical)
        return predators.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack {
            List(filteredDinos) { predators in
                NavigationLink {
                    Image(predators.image)
                        .resizable()
                        .scaledToFit()
                } label: {
                    HStack {
                        // Dinasor Image
                        Image(predators.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1)
                        VStack(alignment: .leading) {
                            // Name
                            Text(predators.name)
                                .fontWeight(.bold)
                            // Type
                            Text(predators.type.rawValue.capitalized)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predators.type.background)
                                .clipShape(.rect(cornerRadius: 8))
                        }
                    }
                }
            }
            .navigationTitle("Apex Predator")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            alphabetical.toggle()
                        }
                    } label: {
                        if alphabetical {
                            Image(systemName: "film")
                                .symbolEffect(.bounce, value: true)
                        } else {
                            Image(systemName: "textformat")
                                .symbolEffect(.bounce, value: true)
                        }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $currentSelection.animation()) {
                            ForEach(ApexPredator.PredatorType.allCases) { type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
