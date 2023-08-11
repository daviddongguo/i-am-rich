//
//  DailyCalorieGraph.swift
//  I Am Rich
//
//  Created by david on 2023-08-11.
//
import DGCharts
import SwiftUI


struct DailyCalorieGraph: UIViewRepresentable  {
    typealias UIViewType = BarChartView
    
    let entries: [BarChartDataEntry]
    func makeUIView(context: Context) -> BarChartView {
     return BarChartView()
    }
    
    func updateUIView(_ uiView: BarChartView, context: Context) {
        let dataSet = BarChartDataSet(entries: entries)
        uiView.data = BarChartData(dataSet: dataSet)
    }
    
    
}

struct DailyCalorieGraph_Previews: PreviewProvider {
    static var previews: some View {
        DailyCalorieGraph(entries: DateTimeCalorie.dataEntries(DateTimeCalorie.allDailyCalorie))
    }
}
