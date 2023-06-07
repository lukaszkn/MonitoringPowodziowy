//
//  StationListView.swift
//  MonitoringPowodziowy
//
//  Created by Lukasz on 20/05/2023.
//

import SwiftUI

struct StationListView: View {
    
    @Binding var showingDetails: Bool
    @ObservedObject var mainViewModel: MainViewModel
    
    var body: some View {
        List {
            ForEach(mainViewModel.stations) { station in
                HStack {
                    VStack(alignment: .leading) {
                        Text(station.miejsce)
                            .font(.title3)
                            .onTapGesture {
                                mainViewModel.selectedStation = station
                                showingDetails = true
                            }
                        VStack {
                            Text("h = \(station.wartoscInt)cm (\(station.p_ostrzegawczy)cm / \(station.p_alarmowy)cm)")
                                .font(.subheadline)
                                .padding(.leading, 5)
                                .padding(.trailing, 5)
                                .background(
                                    station.isRedWarning ? .red
                                    : station.isYellowWarning ? .yellow
                                    : .white
                                )
                                .cornerRadius(15)
                        }
                    }
                    
                    Spacer()
                    
                    ZStack {
                        Rectangle()
                            .border(.blue.opacity(0.5))
                            .foregroundColor(.blue.opacity(0.15))
                            .frame(width: 20)
                        
                        Rectangle()
                            .scale(y: station.warningPercentage, anchor: .top)
                            .foregroundColor(Color(hue: 0.16, saturation: 0.07, brightness: 1))
                            .frame(width: 18)
                            .offset(y: 1)
                            
                        Rectangle()
                            .scale(y: station.levelPercentage, anchor: .bottom)
                            .foregroundColor(station.isRedWarning ? .red
                                             : station.isYellowWarning ? .yellow
                                             : .blue)
                            .frame(width: 18)
                            .offset(y: -1)
                    }
                }
            }
        }
    }
}

struct StationListView_Previews: PreviewProvider {
    static var previews: some View {
        
        @State var showingDetails = false
        let viewModel = MainViewModel()
        
        StationListView(showingDetails: $showingDetails, mainViewModel: viewModel)
            .onAppear() {
                viewModel.getStations()
            }
    }
}
