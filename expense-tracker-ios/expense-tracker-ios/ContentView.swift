//
//  ContentView.swift
//  expense-tracker-ios
//
//  Created by Vishal Bhogal on 22/04/23.
//

import Charts
import SwiftUI

@available(iOS 17.0, *)
struct ContentView: View {
    var body: some View {
        NavigationView {
                ScrollView {
                    YourBalance()
                    VStack(alignment: .leading, spacing: 18) {
                        HStack {
                            SpentThisWeekWidget()
                                .padding(.horizontal, 5.0)
                            
                            StackedBarChat()
                                .padding(.horizontal, 5.0)
                        }
                        TotalSpendingsOverMonths()
                            .padding(.horizontal, 5.0)
                        
                        Rectangle()
                            .frame(height: 1)
                            .padding([.top, .leading, .trailing], 10.0)
                            .foregroundColor(.black.opacity(0.2))
                        
                        HStack(spacing: 5) {
                            Image(uiImage: UIImage(named: "exam")!)
                                .resizable()
                                .frame(width: 18, height: 18)
                            
                            
                            Text("Recent transactions:")
                                .foregroundColor(.black.opacity(0.9))
                                .font(.system(size: 16))
                                .fontDesign(.rounded)
                                .foregroundColor(.black)
                                .fontWeight(.regular)
                            
                        }
                        .padding(.leading, 15.0)
                        
                        List(transactions) { expense in
                            let image = Resources().findImage(category: expense.category)
                            let expenseModel = ExpenseItemCellModel(category: expense.category,
                                                                    image: image,
                                                                    amount: expense.amount)
                            ExpenseItemCell(model: expenseModel)
                                .listRowBackground(Color(red: 0.4745098039215686, green: 0.5294117647058824, blue: 0.4666666666666667))
                                .listRowSeparator(.visible)
                                .listRowSeparatorTint(Color(UIColor.white).opacity(0.5))
                                .listSectionSeparator(.hidden)
                                .listRowInsets(EdgeInsets(top: 7, leading: 3, bottom: 8, trailing: 7))
                            
                            
                        }
                        .cornerRadius(20)
                        .listStyle(.inset)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black.gradient, lineWidth: 1.5)
                        )
                        .frame(height: 900)
                    }
                    
                }
                .background(Color(red: 0.7450980392156863, green: 0.8588235294117647, blue: 0.7333333333333333))
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack {
                            
                            Image(uiImage: UIImage(named: "memoji")!)
                                .resizable()
                                .frame(width: 34, height: 34)
                                .cornerRadius(19)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.cyan.opacity(0.5).gradient, lineWidth: 1)
                                    
                                }
                            
                            
                            Text("Howdy, Vishal")
                                .foregroundColor(.black.opacity(0.65))
                                .fontDesign(.rounded)
                                .fontWeight(.medium)
                                .font(.title3)
                            
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image("love")
                            .resizable()
                    }
                }
            }
        }
    }

@available(iOS 17.0, *)
struct PieChart: View {
    @available(iOS 17.0, *)
    var body: some View {
        Chart(TotalSpends.calculate()) { transaction in
            BarMark(y: .value("Expenses", transaction.totalMoney), stacking: .normalized)
                .foregroundStyle(by: .value("Categories", transaction.category.rawValue))
                .cornerRadius(5)
        }
        .padding(.bottom, 8.0)
        .padding(.top, 5.0)
        .chartYAxis(.hidden)
        .chartXAxis(.hidden)
        .frame(width: 20, height: 120)
        .chartLegend(.hidden)
    }
}
struct ExpenseItemCell: View {
    var model: ExpenseItemCellModel = .init(category: .drinks, image: Resources().findImage(category: .drinks), amount: 200)
    
    var body: some View {
        HStack(spacing: 10) {
            HStack {
                Image(uiImage: model.image)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .padding(5)
                
                Text(model.category.rawValue)
                    .font(.system(size: 16))
                    .fontDesign(.rounded)
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                
            }
            
            Spacer()
            Text("\u{20B9}\(Int(model.amount))")
                .font(.system(size: 14))
                .fontDesign(.rounded)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
        .padding([.all], 10.0)
        .shadow(radius: 5)
    }
}



@available(iOS 17.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TotalSpendingsOverMonths: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Your Monthly Spendings")
                .fontDesign(.rounded)
                .fontWeight(.regular)
                .foregroundColor(.black.opacity(0.7))
            
            Chart(testDataOverMonths) { expense in
                AreaMark(x: .value("months", expense.month),
                         y: .value("spent", expense.amount))
                .interpolationMethod(.linear)
                .foregroundStyle(LinearGradient(colors: [Color(red: 0.498, green: 0.306, blue: 0.871), Color.green], startPoint: .top, endPoint: .bottom ))
            }
            .chartXAxis {
                AxisMarks(values: .automatic) { value in
                    AxisValueLabel() { // construct Text here
                        if let intValue = value.as(String.self) {
                            Text("\(intValue)")
                                .font(.system(size: 9))
                                .fontWeight(.light)
                                .foregroundColor(Color(UIColor.black))
                        }
                    }
                    AxisGridLine(centered: true)
                        .foregroundStyle(.brown)
                }
            }
            .chartYAxis {
                AxisMarks(values: .automatic) { value in
                    AxisValueLabel() { // construct Text here
                        if let intValue = value.as(Int.self) {
                            Text("\u{20B9}\(intValue)")
                                .font(.system(size: 11))
                                .fontDesign(.rounded)
                                .fontWeight(.regular)
                                .foregroundColor(Color(UIColor.black).opacity(0.8))
                        }
                    }
                }
            }
        }
        .padding(.all, 17.0)
        .background(Color(red: 0.8274509803921568, green: 0.8588235294117647, blue: 1.0))
        .cornerRadius(20)
//        .overlay(
//            RoundedRectangle(cornerRadius: 20)
//                .stroke(Color.black.gradient, lineWidth: 1.5)
//        )
        .shadow(radius: 2)
        .frame(height: 160)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    let radius: CGFloat
    let corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct StackedBarChat: View {
    let totalSpends = TotalSpends.calculate()
    var body: some View {
        Chart(totalSpends) { expense in
            BarMark(x: .value("spent", expense.totalMoney),
                    y: .value("category", expense.category.rawValue))
            .cornerRadius(5)
            .annotation(position: .overlay) {
                Text("\u{20B9}\(expense.totalMoney)")
                    .foregroundColor(.white)
                    .font(.system(size: 7))
            }
        }
        .chartYAxis {
            AxisMarks(preset: .extended, position: .trailing, values: .automatic) { value in
                AxisValueLabel() { // construct Text here
                    if let intValue = value.as(String.self) {
                        Text("\(intValue)")
                            .font(.system(size: 8))
                            .fontWeight(.regular)
                            .foregroundColor(.black.opacity(0.8))
                    }
                }
                
            }
        }
        .chartXAxis(.hidden)
        .chartYAxisLabel(position: .top, alignment: .leading, content: {
            Text("Total Spendings")
                .font(.subheadline)
                .fontDesign(.rounded)
                .fontWeight(.light)
                .foregroundColor(.black)
        })
        .foregroundStyle(Color.black.opacity(0.45).gradient)
        
        .padding(.all, 15)
        .frame(height: 145)
        .background(Color(red: 1.0, green: 0.6980392156862745, blue: 0.6509803921568628))
        .cornerRadius(20)
//        .overlay(
//            RoundedRectangle(cornerRadius: 20)
//                .stroke(Color.black.gradient, lineWidth: 1)
//        )
        .shadow(radius: 2)
    }
}

@available(iOS 17.0, *)
struct SpentThisWeekWidget: View {
    @State private var isAnimating = false
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Spent this week")
                    .font(.subheadline)
                    .foregroundStyle(Color.black.opacity(0.65))
                    .fontWeight(.light)
                    .padding(.bottom, 15)
                    .padding(.top, 17)
                
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("\u{20B9}19,128")
                        .font(.title2)
                        .fontDesign(.serif)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Spacer()
                    HStack(spacing: 5.0) {
                        Image(systemName: "arrow.up")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color(hue: 0.354, saturation: 0.912, brightness: 0.465))
                            .frame(width: 10, height: 13)

                        
                        Text("3% higher 🔥")
                            .font(.caption)
                            .fontWeight(.regular)
                            .foregroundColor(Color(hue: 0.354, saturation: 0.912, brightness: 0.465))
                    }
                    .offset(y: isAnimating ? -30 : 6)
                    .animation(.spring(duration: 1.5, bounce: 0.6, blendDuration: 2.0))
                    .onAppear {
                        isAnimating = true
                    }
                    
                }
                Spacer()
            }
            
            PieChart()
                .padding(.horizontal, 5.0)
        }
        .padding(.horizontal, 15)
        .frame(height: 145)
        .background(Color(red: 0.9333333333333333, green: 0.9294117647058824, blue: 0.9294117647058824))
        .cornerRadius(20)
        .shadow(radius: 2)
        
    }
}

struct YourBalance: View {
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text("Your balance 👀")
                .foregroundColor(.gray.opacity(0.9))
                .font(.title2)
                .fontWeight(.light)
                .fontDesign(.rounded)
            
            HStack(spacing: 2) {
                Text("\u{20B9}")
                    .foregroundColor(.black.opacity(0.5))
                    .font(.title)
                    .padding(.bottom)
                
                
                Text("51,430")
                    .foregroundColor(.black)
                    .font(.system(size: 54))
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                
                
                Text(".37")
                    .foregroundColor(.black)
                    .font(.title)
                    .padding(.bottom)
            }.padding(.leading)
        }
        .padding(.vertical, 25)
    }
}

@available(iOS 17.0, *)
struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }

            ContentView()
                .tabItem {
                    Label("Order", systemImage: "square.and.pencil")
                }
        }
    }
}
