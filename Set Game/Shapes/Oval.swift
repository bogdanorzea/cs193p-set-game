//
//  Oval.swift
//  Set Game
//
//  Created by Bogdan Orzea on 8/11/20.
//  Copyright © 2020 Bogdan Orzea. All rights reserved.
//

import SwiftUI

struct Oval: Shape {
    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height) / 2

        var path = Path()

        path.addArc(center: CGPoint(x: rect.midX, y: rect.minY + radius), radius: radius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 0), clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - radius))
        path.addArc(center: CGPoint(x: rect.midX, y: rect.maxY - radius), radius: radius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 180), clockwise: false)
        path.closeSubpath()

        return path
    }
}

struct Oval_Previews: PreviewProvider {
    static var previews: some View {
        Oval()
    }
}
