//
//  PathView.swift
//  PathTest
//
//  Created by Kai Quan Tay on 30/1/23.
//

import SwiftUI

struct PathView: View {
    @State var colour: Color
    @State var thickness: CGFloat
    @State var startAngle: Angle = .zero

    @Binding var trim: CGFloat

    var body: some View {
        GeometryReader { geom in
            ZStack(alignment: .center) {
                Circle()
                    .trim(from: startTrim(size: geom.size),
                          to: endTrim(size: geom.size))
                    .stroke(colour,
                            style: .init(lineWidth: thickness,
                                         lineCap: .round))
                Circle()
                    .trim(from: startTrim(size: geom.size),
                          to: endTrim(size: geom.size))
                    .stroke(gradient(size: geom.size),
                            style: .init(lineWidth: thickness * 2 / 3,
                                         lineCap: .round))
            }
            .rotationEffect(.degrees(180) + startAngle)
        }
    }

    func startTrim(size: CGSize) -> CGFloat {
        let cumf = size.width * .pi
        return thickness * 5/7 / cumf
    }

    func endTrim(size: CGSize) -> CGFloat {
        trim - startTrim(size: size)
    }

    func gradient(size: CGSize) -> some ShapeStyle {
        AngularGradient(colors: [colour, .white.opacity(0.5)],
                        center: .center,
                        startAngle: .zero,
                        endAngle: .degrees(Double(360) * (trim)))
    }
}

struct PathView_Previews: PreviewProvider {
    static let colours: [Color] = [
        .red,
        .orange,
        .yellow,
        .green,
        .blue,
        .purple,
        .pink
    ]

    static let totalSections: Int = 7

    static var previews: some View {
        VStack {
            ForEach(0..<4) { row in
                HStack {
                    ForEach(0..<3) { col in
                        ZStack {
                            PathView(colour: colours[(row * 3 + col)%7],
                                     thickness: 20,
                                     startAngle: .degrees(90),
                                     trim: .constant(CGFloat(row) * 0.3 +
                                                     CGFloat(col) * 0.1))
                            .frame(width: 100, height: 100)
                            Text("\(row * 30 + col * 10)")
                        }
                        .padding(10)
                    }
                }
            }
        }

        ZStack {
            ForEach(0..<totalSections, id: \.self) { index in
                PathView(colour: colours[index],
                         thickness: 20,
                         startAngle: .degrees(Double(360 / totalSections * index)),
                         trim: .constant(CGFloat(1)/CGFloat(totalSections)))
            }
        }.frame(width: 200, height: 200)
    }
}
