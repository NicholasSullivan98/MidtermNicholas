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
    @State var quantity : String = "1"
    @State var tip = false
    @State var showAlert  = false
    @State private var name: String = ""

    @State var coffeeOrder: Coffee = Coffee(name: "", size: "", type: "", tip: false, numOfCups: 0)
    
    
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
                    coffeeOrder.name = name
                    coffeeOrder.type = selectedCoffeeType.rawValue
                    coffeeOrder.size = selectedSize.rawValue
                    coffeeOrder.tip = tip
                    coffeeOrder.numOfCups = Int(quantity) ?? 0
                }
                
                
                NavigationLink(destination: CoffeeOrders(coffeeOrder: $coffeeOrder, price: 0, HST: 0, tip: 0, totalPrice: 0)){
                    Text("Place Order")
                }.padding(10)
                
            }
            .padding(10)
        }.alert("Data is not valid", isPresented: $showAlert){
            Button("Ok" , role: .cancel) {}
        }
    }
}

#Preview {
    ContentView()
}
