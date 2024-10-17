//
//  ContentView.swift
//  MidtermNicholas
//
//  Created by Nicholas Sullivan on 2024-10-17.
//

import SwiftUI

struct Coffee : Identifiable {
    var id = UUID()
    var name : String
    var size : String
    var type : String
    var tip : Bool
    var numOfCups : Int
}

struct ContentView: View {
    
    @State var selectedSize : Size = .Small
    @State var selectedCoffeeType : CoffeeType = .Original
    @State var quantity : String = ""
    @State var tip = false
    @State var showAlert  = false
    @State private var name: String = ""
    
    @State var coffeeOrder: Coffee = Coffee(name: "", size: "", type: "", tip: false, numOfCups: 0)
    
    @State var price : Double = 0
    @State var HST : Double = 0
    @State var tipPrice : Double = 0
    @State var totalPrice : Double = 0
    
    
    enum Size: String, CaseIterable, Identifiable {
        case Small, Medium, Large
        var id: Self { self }
    }
    
    enum CoffeeType: String, CaseIterable, Identifiable {
        case  Original, Dark, Vanilla
        var id: Self { self }
    }
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Coffee Ordering System")
                    .font(.title)
                TextField("Enter your Name", text: $name)
                //Spacer()
                
                Text("Select Coffee Type: ")
                    .padding(5)
                Picker("Coffee Type", selection: $selectedCoffeeType){
                    Text("Original Blend").tag(CoffeeType.Original)
                    Text("Dark Roast").tag(CoffeeType.Dark)
                    Text("Vanilla").tag(CoffeeType.Vanilla)
                }.pickerStyle(.segmented)
                
                Text("Selected Coffee Size: ")
                    .padding(5)
                Picker("Size", selection: $selectedSize){
                    Text("Small").tag(Size.Small)
                    Text("Medium").tag(Size.Medium)
                    Text("Large").tag(Size.Large)
                }.pickerStyle(.segmented)
                
                Text("Would you like to add a $2 Tip?")
                Toggle(isOn: $tip){
                    Text("Add Tip")
                }
                
                TextField("Number of Cups", text: $quantity)
                
                Button("Add Coffee"){
                    
                    // Validate Fields
                    if(name == nil){
                        showAlert = true
                    }else if(Int(quantity) == nil){
                        showAlert = true
                    }
                    
                    coffeeOrder.name = name
                    coffeeOrder.type = selectedCoffeeType.rawValue
                    coffeeOrder.size = selectedSize.rawValue
                    coffeeOrder.tip = tip
                    coffeeOrder.numOfCups = Int(quantity) ?? 0
                    
                    //Price Calculations
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
                        tipPrice = 2.00
                        totalPrice = price + HST + tipPrice
                    }else{
                        totalPrice = price + HST
                    }
                    
                    round(price)
                    round(HST)
                    round(tipPrice)
                    round(totalPrice)
                }
                
                
                NavigationLink(destination: CoffeeOrders(price: price, HST: HST, tip: tipPrice, totalPrice: totalPrice, coffeeOrder: $coffeeOrder)){
                    Text("Place Order")
                }.padding(10)
                
            }.padding(20)
        }.alert(isPresented: $showAlert){
            Alert(
                title: Text("Invalid Data"),
                message: Text("Please enter valid data"),
                primaryButton: .default(
                    Text("Ok")
                    
                ),
                secondaryButton: .cancel(
                    Text("Cancel")
                )
                
            )
        }
    }
}

#Preview {
    ContentView()
}
