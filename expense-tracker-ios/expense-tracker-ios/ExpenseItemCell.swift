//
//  ExpenseItemCell.swift
//  expense-tracker-ios
//
//  Created by Vishal Bhogal on 30/04/23.
//

import Foundation
import SwiftUI



struct ExpenseItemCellModel {
    let category: Category
    let image: UIImage
    let amount: Int
}





struct ContentView1_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseItemCell()
    }
}

