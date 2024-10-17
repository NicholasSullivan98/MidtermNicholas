//
//  CoffeeOrders.swift
//  MidtermNicholas
//
//  Created by Nicholas Sullivan on 2024-10-17.
//

import SwiftUI

struct CoffeeOrders: View {
    
    var price : Double = 0
    var HST : Double = 0
    var tip : Double = 0
    var totalPrice : Double = 0
    
    @Binding var coffeeOrder : Coffee
    
    var body: some View {
        
        Text("Hi \(coffeeOrder.name) ")
        Text("Your Order Details:")
        Text("\(coffeeOrder.size) \(coffeeOrder.type)")
        Text("Quantity: \(coffeeOrder.numOfCups)")
        Text("Base Price: $\(price)")
        Text("HST: $\(HST)")
        Text("Tip $\(tip)")
        Text("Total Price: $\(totalPrice)")
                
    }
    
    mutating func priceCalc(){
        
        if(coffeeOrder.type == "Original"){
            price = 3.50
        }else if(coffeeOrder.type == "Dark"){
            price = 4.00
        }else{
            price = 4.50
        }
        
        if(coffeeOrder.size == "Medium"){
            price = price + 0.50
        }else if(coffeeOrder.size == "Large"){
            price = price + 1.00
        }
        
        HST = price * 0.13
        
        if(coffeeOrder.tip == true){
            tip = 2.00
            totalPrice = price + HST + tip
        }else{
            totalPrice = price + HST
        }
    }
}

/*
 #Preview {
    CoffeeOrders()
 }
 */
 
