//
//  LineChart.swift
//  StocksApp
//
//  Created by TanjilaNur-00115 on 2/11/23.
//

import SwiftUI

/// SwiftUI Shape representing line chart of stock
struct LineChart: Shape {
    
    // values to be plotted on the chart
    var values: [Double]
    
    // Function to create the path for drawing the line chart
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Check if values array is not empty
        if !values.isEmpty {
            // Move to the starting point of the chart
            let start = CGPoint(x: rect.minX, y: rect.maxY - (CGFloat(values[0]) * rect.maxY))
            path.move(to: start)
            
            // Iterate through the values to create line segments
            for index in values.indices.dropFirst() {
                let value = CGFloat(values[index])
                let x = (CGFloat(index) / CGFloat(values.count - 2)) * rect.maxX
                let y = rect.maxY - (CGFloat(value) * rect.maxY)
                let point = CGPoint(x: x, y: y)
                
                // Add a line segment to the path
                path.addLine(to: point)
            }
            
            // Close the path by connecting the last point to the start point
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: start)
        }
        
        // Return the completed path
        return path
    }
}

