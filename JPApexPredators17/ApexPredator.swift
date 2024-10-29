//
//  ApexPredator.swift
//  JPApexPredators17
//
//  Created by Hartzed Story on 10/15/24.
//

import Foundation
import SwiftUI
import MapKit

struct ApexPredator: Decodable, Identifiable {
    var id: Int
    var name: String
    var type: PredatorType
    var latitude: Double
    var longitude: Double
    var movies: [String]
    var movieScenes: [MovieScene]
    var link: String
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    
    struct MovieScene: Decodable, Identifiable {
        var id: Int
        var movie: String
        var sceneDescription: String
    }
    enum PredatorType: String, Decodable, CaseIterable, Identifiable {
        var id: PredatorType {
            self
        }
        
        case all
        case land
        case air
        case sea
        
        var background: Color {
            switch self {
            case .land:
                    .brown
            case .air:
                    .teal
            case .sea:
                    .blue
            case .all:
                    .black
            }
        }
        
        var icon: String {
            switch self {
            case .all:
                "square.stack.3d.up.fill"
            case .land:
                "leaf.fill"
            case .air:
                "wind"
            case .sea:
                "drop.fill"
            }
        }
    }
}
