//
//  PredatorDetail.swift
//  JPApexPredators17
//
//  Created by Hartzed Story on 10/26/24.
//

import SwiftUI
import MapKit

struct PredatorDetail: View {
    let predator: ApexPredator
    @State var position : MapCameraPosition
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    //Background
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay(content: {
                            LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0),
                                                   Gradient.Stop(color: .black, location: 1)],
                                           startPoint: .top, endPoint: .bottom)
                        })
                    //Dinasor image
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width / 1.5, height: geo.size.height / 3)
                        .scaleEffect(x: -1)
                        .shadow(color: .black, radius: 7)
                        .offset(y: 20)
                }
                
                //Dino name
                VStack(alignment: .leading) {
                    Text(predator.name)
                        .font(.largeTitle)
                    
                    
                    NavigationLink {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                    } label: {
                        // Current location
                        Map(position: $position) {
                            Annotation(predator.name, coordinate: predator.location) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.title)
                                    .imageScale(.large)
                                    .symbolEffect(.variableColor)
                            }
                            .annotationTitles(.hidden)
                        }
                        .frame(height: 125)
                        .clipShape(.rect(cornerRadius: 15))
                        .overlay(alignment: .trailing, content: {
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing, 5)
                        })
                        .overlay(alignment: .topLeading) {
                            Text("Current Location")
                                .padding([.leading, .bottom],5)
                                .padding(.trailing, 8)
                                .background(.black.opacity(0.33))
                                .clipShape(.rect(bottomTrailingRadius: 15))
                        }
                    }

                    //Appear in
                    Text("Appears In:")
                        .padding(.top)
                        .font(.title)
                    ForEach(predator.movies, id: \.self) { movie in
                        Text(movie)
                            .font(.subheadline)
                    }
                    //Movie name
                    Text("Movie moments")
                        .font(.title)
                        .padding(.top, 15)
                    ForEach(predator.movieScenes) { scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical, 1)
                        
                        Text(scene.sceneDescription)
                            .padding(.bottom, 15)
                    }
                    
                    // link to webpage
                    Text("Read more:")
                        .font(.caption)
                    Link(predator.link, destination: URL(string: predator.link) ?? URL(fileURLWithPath: ""))
                        .font(.caption)
               }
                .padding()
                .padding(.bottom)
                .frame(width: geo.size.width, alignment: .leading)

            }
            .ignoresSafeArea()
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    PredatorDetail(predator: Predators().apexPredators[0], position: .camera(MapCamera(centerCoordinate: Predators().apexPredators[0].location, distance: 30000)))
        .preferredColorScheme(.dark)
}
