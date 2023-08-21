//
//  ShoppingCartView.swift
//  RestaurantFoodApp
//
//  Created by macOS on 15/08/23.
//

import SwiftUI

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
}

struct CartItem: Identifiable {
    let id = UUID()
    let product: TrendingCard
    var quantity: Int
}

struct Item: Identifiable {
    var id = UUID().uuidString
    var name : String
    var details: String
    var image: String
    var price: Float
    var quantity: Int
    var offset: CGFloat
    var isSwiped: Bool
}

class CartViewModel: ObservableObject {
    @Published var items = [
        Item(name: "Tek Product 1", details: "Gift", image: "tek1", price: 10.00, quantity: 1, offset: 0, isSwiped: false),
        Item(name: "Tek Product 2", details: "Gift", image: "tek2", price: 90.99, quantity: 2, offset: 0, isSwiped: false),
        Item(name: "Tek Product 3", details: "Gift", image: "tek3", price: 100.00, quantity: 1, offset: 0, isSwiped: false),
        Item(name: "Tek Product 4", details: "Royal", image: "tek4", price: 50.00, quantity: 1, offset: 0, isSwiped: false),
        Item(name: "Tek Product 5", details: "Royal", image: "tek5", price: 100.00, quantity: 1, offset: 0, isSwiped: false)
    ]
}

struct ShoppingCartView: View {
    
    @EnvironmentObject var cart: CartManager
//    @StateObject private var cart = CartManager()
    @State private var quantity = 0
    @State private var stepperValue = 1
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedModel: CartItem? = nil
//    @State private var shouldHide : Bool = false
    @Binding var show: Bool

    var body: some View {
        
//        if cart.cartItems.count > 0 {
            VStack {
                HStack(spacing: 20) {
                    
                    if show {
                        Button(action: {presentationMode.wrappedValue.dismiss()}) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 26, weight: .heavy))
                                .foregroundColor(.black)
                        }
                    } else {
                        Spacer()
                    }
                    
                    Text("My cart")
                        .fontWeight(.heavy)
                        .font(.custom("Jost-Bold", size: 28))
                    
                    Spacer()
                }
                .padding()
                
                List {
                    ForEach(cart.cartItems) { product in
                        ItemView(items: product) //Items view
                    }
                    .onDelete { indexSet in
                        let indexPath = IndexPath(indexes: indexSet)
                        print(indexPath)
                        print(indexPath[0])
                        
                        //Delete selected cartitem data
                        cart.removeFromCart(cartItem: cart.cartItems[indexPath[0]])
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .shadow(radius: 3)
                
                // Bottom View
                VStack {
                    HStack {
                        Text("Total")
                            .fontWeight(.heavy)
                            .font(.custom("Jost-Bold", size: 28))
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        // Calculating Total Price
                        Text("Total: $\(String(format: "%.2f", cart.totalCost()))")
                            .fontWeight(.heavy)
                            .font(.custom("Jost-Bold", size: 28))
                            .foregroundColor(.black)
                    }
                    .padding([.top, .horizontal])
                    
                    Button(action: {}) {
                        Text("Check out")
                            .fontWeight(.heavy)
                            .font(.custom("Jost-Bold", size: 28))
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .background(Color.blue)
                            .cornerRadius(15)
                            .padding()
                    }
                }
            }
            .background(Color.white.ignoresSafeArea())
            .navigationBarHidden(true)
            
//        } else {
//            Text("Please add your items")
//        }
    }
}

struct ShoppingCartView_Previews: PreviewProvider {
    
    // we show the simulated view, not the BoolButtonView itself
    static var previews: some View {
        OtherView()
            .preferredColorScheme(.light)
    }
    
    // nested OTHER VIEW providing the one value for binding makes the trick
    private struct OtherView : View {
        
        @State var show : Bool = false
        
        var body: some View {
            ShoppingCartView(show: $show)
        }
    }
}
