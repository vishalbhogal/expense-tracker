//
//  TransactionModel.swift
//  expense-tracker-ios
//
//  Created by Vishal Bhogal on 30/04/23.
//

import Foundation
import UIKit

struct Transaction: Identifiable {
    var id = UUID()
    let merchantName: MerchantName
    let amount: Int
    var category: Category
    let color: ColorsForCategory
}

enum MerchantName: String {
    case upi
    case creditCard
    case debitCard
    case sodexo
    case others
}

enum Category: String {
    case travel
    case food
    case onlineShopping = "shopping"
    case drinks
}

enum ColorsForCategory: String {
    case red = "Red"
    case blue = "Blue"
    case pink = "Pink"
    case orange = "Orange"
    case green = "Green"
}

struct Resources {
    func findImage(category: Category) -> UIImage {
        switch category {
        case .travel:
            return UIImage(named: "rickshaw")!
        case .food:
            return UIImage(named: "fast-food")!
        case .onlineShopping:
           
            return UIImage(named: "online-shop")!
        case .drinks:
            return UIImage(named: "beer")!
        }
    }
}

let transactions: [Transaction] = [.init(merchantName: .creditCard, amount: 1000, category: .drinks, color: .blue),
                                   .init(merchantName: .debitCard, amount: 2000, category: .onlineShopping, color: .pink),
                                   .init(merchantName: .others, amount: 2000, category: .food, color: .green),
                                   .init(merchantName: .upi, amount: 300, category: .travel, color: .orange),
                                   .init(merchantName: .debitCard, amount: 300, category: .food, color: .green),
                                   .init(merchantName: .creditCard, amount: 4200, category: .onlineShopping, color: .pink)] + transaction2 + transaction3

let transaction2: [Transaction] = [.init(merchantName: .sodexo, amount: 3200, category: .travel, color: .orange),
                                    
                                    .init(merchantName: .others, amount: 2110, category: .onlineShopping, color: .pink),
                                    .init(merchantName: .sodexo, amount: 280, category: .food, color: .green),
                                    .init(merchantName: .upi, amount: 1440, category: .travel, color: .orange),
                                    .init(merchantName: .debitCard, amount: 2100, category: .drinks, color: .blue),
                                    .init(merchantName: .creditCard, amount: 450, category: .onlineShopping, color: .pink)]
let transaction3: [Transaction] = [.init(merchantName: .upi, amount: 500, category: .food, color: .green),
                                    .init(merchantName: .creditCard, amount: 800, category: .drinks, color: .blue),
                                    .init(merchantName: .debitCard, amount: 2500, category: .onlineShopping, color: .pink),
                                    
                                    .init(merchantName: .others, amount: 1000, category: .travel, color: .orange),
                                    .init(merchantName: .upi, amount: 1500, category: .onlineShopping, color: .pink),
                                    .init(merchantName: .creditCard, amount: 600, category: .food, color: .green)]

struct TotalSpends: Identifiable {
    var id = UUID()
    let totalMoney: Int
    let category: Category
    
    static func calculate() -> [TotalSpends] {
        var totalSpends = [TotalSpends]()
        var drinksTotal = 0
        var travelTotal = 0
        var foodTotal = 0
        var osTotal = 0
        transactions.forEach { transaction in
            switch transaction.category {
            case .drinks:
                drinksTotal += transaction.amount
                
            case .travel:
                travelTotal += transaction.amount
                
            case .food:
                foodTotal += transaction.amount
                
            case .onlineShopping:
                osTotal += transaction.amount
            }
        }
            totalSpends.append(TotalSpends(totalMoney: drinksTotal, category: .drinks))
            totalSpends.append(TotalSpends(totalMoney: travelTotal, category: .travel))
            totalSpends.append(TotalSpends(totalMoney: foodTotal, category: .food))
            totalSpends.append(TotalSpends(totalMoney: osTotal, category: .onlineShopping))
            return totalSpends
        
    }
    
}

struct TransactionOverMonths: Identifiable {
    var id = UUID()
    let month: String
    let amount: Int
}

let testDataOverMonths: [TransactionOverMonths] = [
    TransactionOverMonths(month: "Jan", amount: 1000),
    TransactionOverMonths(month: "Feb", amount: 1500),
    TransactionOverMonths(month: "Mar", amount: 2000),
    TransactionOverMonths(month: "Apr", amount: 1200),
    TransactionOverMonths(month: "May", amount: 1800),
    TransactionOverMonths(month: "Jun", amount: 2200),
    TransactionOverMonths(month: "Jul", amount: 1300),
    TransactionOverMonths(month: "Aug", amount: 1700),
    TransactionOverMonths(month: "Sep", amount: 1900),
    TransactionOverMonths(month: "Oct", amount: 1400),
    TransactionOverMonths(month: "Nov", amount: 1600),
    TransactionOverMonths(month: "Dec", amount: 2100)
]
