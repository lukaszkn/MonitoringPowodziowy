//
//  StationDetailsView.swift
//  MonitoringPowodziowy
//
//  Created by Lukasz on 20/05/2023.
//

import SwiftUI

struct StationDetailsView: View {
    var station: StationData
    
    @StateObject var viewModel = StationDetailsViewModel()
    
    var body: some View {
        VStack() {
            Text(station.miejsce)
                .font(.largeTitle)
                .padding()
            Form {
                LabeledContent("Data pomiaru", value: "2020-06-26 14:49:26")
                LabeledContent("Stan lustra wody", value: "Poniżej stanu ostrzegawczego")
                LabeledContent("Wysokość lustra wody", value: "117 cm")
                LabeledContent("Przyrost od ostatniego pomiaru", value: "34 cm")
                LabeledContent("Wysokość nad poziomem morza", value: "239.13 m")
            }
            
        }
        
        .onAppear() {
            viewModel.getStationTableData(station: station)
        }
    }
}

struct StationDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleStation = StationData(id_ppwr: "GOML", dl_geo: "22.50528", szer_geo: "50.037")
        StationDetailsView(station: sampleStation)
    }
}
