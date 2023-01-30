//
//  AllExpensesView.swift
//  PathTest
//
//  Created by Kai Quan Tay on 30/1/23.
//

import SwiftUI

struct AllExpensesView: View {
    @State var totalSections: Int = 5

    let colours: [Color] = [
        .red,
        .orange,
//        .yellow, // NOTE: low contrast
        .green,
        .blue,
        .purple,
        .pink
    ]

    let categories: [String] = [
        "House",
        "Food",
        "Digital Products",
        "Social",
        "Hobby"
    ]

    let prices: [Int] = [
        829,
        829,
        829,
        829,
        829
    ]

    var body: some View {
        List {
            HStack {
                Spacer()
                overview
                    .padding(.top, 20)
                    .padding(.bottom, -110)
                Spacer()
            }
            .listRowSeparator(.hidden)

            ForEach(Array(categories.enumerated()), id: \.offset) { index, category in
                HStack {
                    ZStack {
                        colours[index%7]
                            .frame(width: 40, height: 40)
                            .cornerRadius(15)
                            .opacity(0.5)
                        Image(systemName: "house.fill")
                            .foregroundColor(colours[index%7])
                    }
                    .padding(.trailing, 10)

                    Text(category)
                        .bold()
                    Spacer()

                    Text("$\(prices[index])")
                }
                .padding(.vertical, 4)
            }
        }
        .listStyle(.inset)
        .navigationTitle("All Expenses")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {

                } label: {
                    Image(systemName: "line.3.horizontal")
                }
            }
        }
    }

    var overview: some View {
        ZStack {
            ForEach(0..<totalSections, id: \.self) { index in
                PathView(colour: colours[index%colours.count],
                         thickness: 15,
                         spacing: 3,
                         startAngle: .degrees(Double(180 / totalSections * index)),
                         trim: .constant(CGFloat(0.5)/CGFloat(totalSections)))
            }

            Circle()
                .trim(from: 0, to: 0.5)
                .stroke(Color.gray, style: .init(lineWidth: 2, dash: [2, 15]))
                .padding(25)
                .rotationEffect(.degrees(180))

            VStack {
                scope
                    .frame(width: 100)
                Text("$1243.95")
                    .font(.title)
            }
            .offset(y: -20)
        }
        .frame(width: 280, height: 280)
    }

    var scope: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Text("Weekly")
                Text("Monthly")
                Text("Yearly")
            }
        }
    }
}

struct AllExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AllExpensesView()
        }
    }
}
