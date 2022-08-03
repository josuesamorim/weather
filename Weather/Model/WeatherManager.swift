
import Foundation

protocol WeatherManagerDelegate {
   func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=735d87f69ebb3eddfc5451f4ad2de5f8&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        //Create a URL
        if let url = URL(string: urlString){
            
            //Create a URL Session
            let session = URLSession(configuration: .default)
            
            //Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                    
                }
            }
            //Start task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = (decodeData.weather[0].id)
            let temp = decodeData.main.temp
            let city = decodeData.name
            
            let weather = WeatherModel(conditionId: id, cityName: city, temperature: temp)
         
            return weather
          
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    

    
    
    
}
