//
//  Squiggle.swift
//  Set Game
//
//  Created by Bogdan Orzea on 8/11/20.
//  Copyright © 2020 Bogdan Orzea. All rights reserved.
//

import SwiftUI

struct Squiggle: Shape {
    func path(in rect: CGRect) -> Path {
        let offset = min(rect.width, rect.height) / 10

        var path = Path()

        path.move(to: CGPoint(x: rect.minX+3*offset, y: rect.minY+1.25*offset))
        path.addCurve(to: CGPoint(x: rect.maxX-2*offset, y: rect.maxY-3*offset),
                      control1: CGPoint(x: rect.maxX+8*offset, y: rect.minY+4*offset),
                      control2: CGPoint(x: rect.minX, y: rect.midY+2*offset))
        path.addQuadCurve(to: CGPoint(x: rect.maxX-3*offset, y: rect.maxY-1.25*offset),
                          control: CGPoint(x: rect.maxX-0.5*offset, y: rect.maxY-1.25*offset))

        path.addCurve(to: CGPoint(x: rect.minX+2*offset, y: rect.minY+3*offset),
                      control1: CGPoint(x: rect.minX-8*offset, y: rect.maxY-4*offset),
                      control2: CGPoint(x: rect.maxX, y: rect.midY-2*offset))
        path.addQuadCurve(to: CGPoint(x: rect.minX+3*offset, y: rect.minY+1.25*offset),
                          control: CGPoint(x: rect.minX+0.5*offset, y: rect.minY+1.25*offset))

        return path
    }
}

struct Squiggle_Previews: PreviewProvider {
    static var previews: some View {
        Squiggle()
    }
}
