
import Foundation

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=735d87f69ebb3eddfc5451f4ad2de5f8&units=metric"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
    }
    
    func performRequest(urlString: String){
        //Create a URL
        if let url = URL(string: urlString){
            //Create a URL Session
            let session = URLSession(configuration: .default)
            //Give the session a task
            let task = session.dataTask(with: url, completionHandler: handle(data:urlResponse:error:))
            //Start task
            task.resume()
        }
    }
    
    func handle(data: Data?, urlResponse: URLResponse?, error: Error?){
        if error != nil {
            print(error!)
            return
        }
        
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
        }
    }
}
