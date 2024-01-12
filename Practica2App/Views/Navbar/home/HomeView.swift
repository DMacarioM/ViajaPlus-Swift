//
//  MainActivityView.swift
//  Practica2App
//
//  Created by RonaldRis on 9/1/24.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @Binding var userLogged: User

    let cities = ["Murcia", "Alicante", "Valencia", "Granada"]
    @State private var selectedStartCity = "Murcia"
    @State private var selectedEndCity = "Valencia"
    
    @State private var selectedRoute1: String = ""
    @State private var selectedRoute2: String = ""
    
    @State private var isRoundTrip = false
    @State private var selectedDate1 = Date()
    @State private var selectedDate2 = Date()
    @State private var showAlert = false
    @State private var errorText = ""
    
    
    @State var ticketsBuy : [Ticket] = []
    
    //SORTING VARIABLE
    var sorterCheaper = "Earlier"
    var sorterString = ["Earlier", "Cheaper"]
    @State var selectedSorter = "Earlier"
    
    //NAVIGATE
    @State private var navigateToConfirmation = false

    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Cities")) {
                    Picker("Origin city", selection: $selectedStartCity) {
                        ForEach(cities, id: \.self) { city in
                            Text(city)
                        }
                    }
                    .pickerStyle(.navigationLink)

                    Picker("Destination city", selection: $selectedEndCity) {
                        ForEach(cities, id: \.self) { city in
                            Text(city)
                        }
                    }
                    .pickerStyle(.navigationLink)

                }
                
                Section(header: Text("Dates")) {
                    Toggle("Round Trip", isOn: $isRoundTrip)

                   
                    
                    if isRoundTrip {
                                            DatePicker("Select first Date", selection: $selectedDate1, in: Date()..., displayedComponents: [.date])
                                            DatePicker("Select back Date", selection: $selectedDate2, in: selectedDate1..., displayedComponents: [.date])
                                        } else {
                                            DatePicker("Select going Date", selection: $selectedDate1, in: Date()..., displayedComponents: [.date])
                                        }
                    
                    
                    
                }
                
                
                Section(header: Text(isRoundTrip ? "Departure and Arrival Time" : "Departure Time")) {
                    
                    Picker("Order by", selection: $selectedSorter) {
                                        ForEach(sorterString, id: \.self) {
                                            sorter in
                                            Text(sorter)
                                        }
                                    }
                                    .pickerStyle(.segmented)

                    
                    
                            Picker("Going", selection: $selectedRoute1) {
                                Text("").tag("") // This line adds an empty tag for the nil case
                                ForEach(
                                        RoutesService.shared.getRoutes(sorterType: selectedSorter, startCity: selectedStartCity, endCity: selectedEndCity)
                                        , id: \.self) {
                                    route in
                                    Text(route.textTimeAndprice()).tag(route.textTimeAndprice())
                                }
                            }
                            .pickerStyle(.navigationLink)
                            .onChange(of: selectedStartCity) { oldValue, newValue in
                                selectedRoute1 = ""
                            }
                            .onChange(of: selectedEndCity) { oldValue, newValue in
                                selectedRoute1 = ""
                            }
                            .onChange(of: selectedSorter) { oldValue, newValue in
                                selectedRoute1 = ""
                            }
                     

                            if isRoundTrip {
                                Picker("Return", selection: $selectedRoute2) {
                                    Text("").tag("") // This line adds an empty tag for the nil case
                                    ForEach(
                                            RoutesService.shared.getRoutes(sorterType: selectedSorter, startCity: selectedEndCity , endCity: selectedStartCity)
                                            , id: \.self) {
                                        route in
                                        Text(route.textTimeAndprice()).tag(route.textTimeAndprice())
                                    }
                                }
                                .pickerStyle(.navigationLink)
                                .onChange(of: selectedStartCity) { oldStartCity, newStartCity in
                                    selectedRoute2 = ""
                                }
                                .onChange(of: selectedEndCity) { oldValue, newValue in
                                    selectedRoute2 = ""
                                }
                                .onChange(of: selectedSorter) { oldValue, newValue in
                                    selectedRoute2 = ""
                                }
                                 
                            }
                        }
                
            
                Button("Buscar el mejor precio !!") {
                    
                    // Primero, realiza la validación de las ciudades
                    if selectedStartCity == selectedEndCity {
                        errorText = "Por favor, elige ciudades de origen y destino diferentes."
                        showAlert = true
                    } else {
                        // Luego, si pasa la validación, crea los tickets
                        navigateToConfirmation = createTickets()
                    }
                    
                }
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
                   
                
            }
            .navigationBarTitle("ViajaPlus")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(errorText), dismissButton: .default(Text("OK")))
            }
        }// Utiliza onReceive para escuchar los cambios en selectedDate1 y actualizar selectedDate2 si es necesario.
        .onReceive([self.selectedDate1].publisher.first()) { (value) in
            if selectedDate2 < value {
                selectedDate2 = value
            }
        }
        .alert(isPresented: $showAlert) {
           Alert(title: Text("Error"), message: Text(errorText), dismissButton: .default(Text("OK")))
        }
        .navigationDestination(isPresented: $navigateToConfirmation) {
            BuyTicketsView(tickets: ticketsBuy)
        }
              
    }
    
    
    
    
    
    func createTickets() -> Bool{

        ticketsBuy.removeAll()

        if selectedStartCity == selectedEndCity {
            errorText = "Origen y destino no pueden ser iguales."
            showAlert = true
            return false
        }
        
        if selectedRoute1 == "" {
            showAlert = true
            errorText = "Select a going hour"
            return false
        }
    
        if selectedRoute2 == "" && isRoundTrip {
            showAlert = true
            errorText = "Select a back hour"
            return false
        }
        
    
        print([selectedSorter, selectedStartCity, selectedEndCity])
        let route1 : Route? = RoutesService.shared.routes.first(where: { $0.textTimeAndprice() == selectedRoute1 })
        
        
        // Crear el ticket de ida
        let newTicket1 = Ticket(
          ticketId: UUID().uuidString,
          userId: userLogged.userId,
          purchaseDate: Date(),
          travelDate: selectedDate1,
          originCity: route1?.originCity ?? "",
          destinationCity: route1?.destinationCity ?? "",
          departureTime: route1?.departureTime ?? Date(),
          arrivalTime: route1?.arrivalTime ?? Date(),
          price: route1?.price ?? 0
        )
        
        ticketsBuy.append(newTicket1)
        
        
        
        // Si es viaje redondo, crear el ticket de regreso
        if isRoundTrip && selectedRoute2 != "" {
            let route2 : Route? = RoutesService.shared.routes.first(where: { $0.textTimeAndprice() == selectedRoute2 })

            let newTicket2 = Ticket(
              ticketId: UUID().uuidString,
              userId: userLogged.userId,
              purchaseDate: Date(),
              travelDate: selectedDate2,
              originCity: route2?.originCity ?? "",
              destinationCity: route2?.destinationCity ?? "",
              departureTime: route2?.departureTime ?? Date(),
              arrivalTime: route2?.arrivalTime ?? Date(),
              price: route2?.price ?? 0
            )
            ticketsBuy.append(newTicket2)

            
        }


        return ticketsBuy.count > 0 // Return true if at least one ticket was created
    }
    
    
}
