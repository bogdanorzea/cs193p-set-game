//
//  CardView.swift
//  Set Game
//
//  Created by Bogdan Orzea on 8/10/20.
//  Copyright © 2020 Bogdan Orzea. All rights reserved.
//

import SwiftUI

struct CardView: View {
    let card: Card

    var body: some View {
        return HStack {
            ForEach(0..<card.number) { _ in
                GeometryReader { geometry in
                    self.body(for: geometry.frame(in: .local))
                }.frame(width: 25, height: 50)
            }
        }
    }

    func body(for rect: CGRect) -> some View {
        let shape = self.cardShape(for: rect)
        let color = self.cardColor
        let shading = self.cardShading

        return ZStack {
            shape.fill(color).opacity(shading)
            shape.stroke(color, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
        }
    }

    func cardShape(for rect: CGRect) -> Path {
        switch self.card.shape {
            case .diamond: return CardView.diamond(in: rect)
            case .oval: return CardView.oval(in: rect)
            case .squiggle: return CardView.squiggle(in: rect)
        }
    }

    var cardColor: Color {
        switch card.color {
            case .red: return Color.red
            case .purple: return Color.purple
            case .green: return Color.green
        }
    }

    var cardShading: Double {
        switch card.shading {
            case .solid: return 1.0
            case .striped: return 0.3
            case .outlined: return 0.0
        }
    }

    static func diamond(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }

    static func oval(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height) / 2

        var path = Path()

        path.addArc(center: CGPoint(x: rect.midX, y: rect.minY + radius), radius: radius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 0), clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - radius))
        path.addArc(center: CGPoint(x: rect.midX, y: rect.maxY - radius), radius: radius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 180), clockwise: false)
        path.closeSubpath()

        return path
    }

    static func squiggle(in rect: CGRect) -> Path {
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

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let card = Card(shape: .squiggle, number: 3, color: .red, shading: .solid)

        return CardView(card: card)
    }
}
