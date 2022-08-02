
import Foundation

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=735d87f69ebb3eddfc5451f4ad2de5f8&units=metric"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        //Create a URL
        if let url = URL(string: urlString){
            
            //Create a URL Session
            let session = URLSession(configuration: .default)
            
            //Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                    
                }
            }
            //Start task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data){
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = (decodeData.weather[0].id)
            let temp = decodeData.main.temp
            let city = decodeData.name
            
            let weather = WeatherModel(conditionId: id, cityName: city, temperature: temp)
            
            print(weather.conditionName)
            print(weather.temperatureString)
          
        } catch {
            print(error)
        }
    }
    

    
    
    
}
