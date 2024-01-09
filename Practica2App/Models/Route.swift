import Foundation


struct Route: Hashable, Codable, Identifiable{
    let id: UUID

    let routeId: Int
    let originCity: String
    let destinationCity: String
    let departureTime: Date
    let arrivalTime: Date
    let price: Double

    init(routeId: Int, originCity: String, destinationCity: String, departureTime: Date, arrivalTime: Date, price: Double) {
        self.routeId = routeId
        self.originCity = originCity
        self.destinationCity = destinationCity
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
        self.price = price
        
        // Create a new UUID for the id property
        self.id = UUID()
    }
    func departureTimeText() -> String {
        let formatter = DateFormatter()
       formatter.dateFormat = "hh:mm"
       return formatter.string(from: departureTime)

    }
    
    
    func arrivalTimeText() -> String {
        let formatter = DateFormatter()
       formatter.dateFormat = "hh:mm"
       return formatter.string(from: arrivalTime)

    }
    
    func textTimeAndprice() -> String {
        return "\(self.departureTimeText()) to \(self.arrivalTimeText()) - \(String(format: "%.2f", self.price)) €"

    }
    
}
