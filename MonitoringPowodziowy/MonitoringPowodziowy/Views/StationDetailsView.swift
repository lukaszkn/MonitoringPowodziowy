//
//  StationDetailsView.swift
//  MonitoringPowodziowy
//
//  Created by Lukasz on 20/05/2023.
//

import SwiftUI
import Charts

struct StationDetailsView: View {
    var station: StationData
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var viewModel = StationDetailsViewModel()
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                VStack() {
                    Text(station.miejsce)
                        .font(.title)
                        .padding(.top)
                    
                    AsyncImage(url: URL(string: "https://monitoring.prospect.pl/assets/images/stations/mleczka/\(station.id_ppwr).jpg"),
                               content: { image in
                                    image.resizable()
                                        .border(.black, width: 1)
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: 300, maxHeight: 150)
                                        
                               },
                               placeholder: {
                                    ProgressView()
                               }
                    )
                    
                    ZStack {
                        List {
                            LabeledContent("Data pomiaru", value: station.czas)
                            LabeledContent("Stan lustra wody", value: "Poniżej stanu ostrzegawczego")
                            LabeledContent("Wysokość lustra wody", value: "\(station.wartoscInt) cm")
                            LabeledContent("Przyrost od ostatniego pomiaru",
                                           value: "\(viewModel.lastDiff) cm")
                        }
                        .scrollDisabled(true)
                        .frame(height: 250)
                    }
                    
                    Text("Dobowy wykres historii pomiarów")
                        .font(.headline)
                        .offset(y: 20)
                    
                    if viewModel.chartData.count > 0 {
                        Chart() {
                            ForEach(viewModel.chartData) { point in
                                
                                LineMark(
                                    x: .value("Czas", point.czas),
                                    y: .value("Wysokość", point.scaledWartosc)
                                )
                                .foregroundStyle(.blue)
                            }
                            
//                            RuleMark(y: .value("ff", Int(viewModel.chartData[0].p_ostrzegawczy!)!))
//                                .foregroundStyle(.yellow)
//                            
//                            RuleMark(y: .value("ff", Int(viewModel.chartData[0].p_alarmowy!)!))
//                                .foregroundStyle(.red)
                            
                        }
                        .chartYScale(domain: [0, (Int(viewModel.chartData[0].p_alarmowy!)! + 50)])
                        .chartYAxis {
                            AxisMarks(values: .automatic(desiredCount: 5))
                        }
                        .padding(20)
                        .frame(height: 300)
                    } else {
                        ProgressView()
                    }
                    
                    Text("Tabela aktualnych pomiarów")
                        .font(.headline)
                        .offset(y: 20)
                        
                    Grid() {
                        GridRow(alignment: .center) {
                            Text("Data pomiaru")
                            Text("Wysokość\n(cm)")
                            Text("Przyrost\n(cm)")
                        }
                        Divider()
                        
                        if viewModel.tableData.count == 0 {
                            ProgressView()
                                .frame(height: 70)
                        } else {
                            ForEach(viewModel.tableData) { row in
                                GridRow {
                                    Text(row.czas)
                                    Text(row.wartosc)
                                    Text(String(describing: row.diff))
                                }
                                Divider()
                            }
                        }
                        
                    }
                    .background(.white)
                    .cornerRadius(10)
                    .padding(20)
                    
                    Spacer()
                }
                .background(Color(UIColor.systemGroupedBackground))
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Zamknij")
                    }

                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.refreshData(station: station)
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }

                }
            })
        }
        .onAppear() {
            viewModel.refreshData(station: station)
        }
    }
}

struct StationDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleStation = StationData(id_ppwr: "GOML", dl_geo: "22.50528", szer_geo: "50.037")
        StationDetailsView(station: sampleStation)
    }
}
