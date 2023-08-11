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
        dataSet.label = "Intake Calories Daily"
        uiView.data = BarChartData(dataSet: dataSet)
        uiView.setScaleEnabled(false)
        uiView.rightAxis.enabled = false
        formatLeftAxis(leftAxis: uiView.leftAxis)
        formateXAxis(xAxis: uiView.xAxis)
        formateLegend(legend: uiView.legend)
        
    }
    
    func formateXAxis(xAxis: XAxis) {
      xAxis.labelPosition = .bottom
    }
    
    func formatLeftAxis(leftAxis: YAxis) {
        leftAxis.labelTextColor = .red
        leftAxis.axisMinimum = 0
    }
    
    func formateLegend(legend: Legend) {
        legend.textColor = .blue
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.drawInside = true
        legend.yOffset = 30.0
    }
    
    
}

struct DailyCalorieGraph_Previews: PreviewProvider {
    static var previews: some View {
        DailyCalorieGraph(entries: DateTimeCalorie.dataEntries(DateTimeCalorie.allDailyCalorie))
    }
}
