//
//  ContentView.swift
//  MonitoringPowodziowy
//
//  Created by Lukasz on 20/05/2023.
//

import MapKit
import SwiftUI

struct MainView: View {
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50.037, longitude: 22.50528), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    @State private var selectedStation: StationData?
    @StateObject private var mainViewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            TabView {
                VStack {
                    Map(coordinateRegion: $mapRegion, annotationItems: mainViewModel.stations) { station in
                        MapAnnotation(coordinate: station.coordinate) {
                            VStack {
                                Circle()
                                    .frame(width: 35, height: 35)
                                    .overlay {
                                        Image(systemName: "mappin.circle.fill")
                                            .foregroundColor(.white)
                                            .font(.system(size: 30, weight: .bold))
                                    }
                                
                            }
                            .onTapGesture {
                                selectedStation = station
                            }
                        }
                    }
                }
                .tabItem {
                    Label("Mapa", systemImage: "map")
                }
                
                StationListView(selectedStation: $selectedStation,
                                mainViewModel: mainViewModel)
                    .tabItem {
                        Label("Lista stacji", systemImage: "list.bullet")
                    }
            }
            //.padding()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Ostatnia aktualizacja:").font(.subheadline)
                        Text("20-05-23 21:49").font(.subheadline)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Text("Rzeka 1")
                        Text("Rzeka 2")
                        Text("Rzeka 3")
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }

                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("refresh")
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }

                }
            }
            .navigationTitle(Text("Mleczka"))
            .sheet(item: $selectedStation) { station in
                StationDetailsView(station: station)
            }
            .onAppear() {
                mainViewModel.getStations()
            }
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
