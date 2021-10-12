import Foundation

struct HomeViewModel {
    var launch: Launch

    var flightNumber: String {
        return "\(launch.flightNumber)"
    }
    
    var name: String {
        return launch.name
    }
        
    var simplifiedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy, HH:mm"
        return dateFormatter.string(from: launch.dateLocal)
    }
}
