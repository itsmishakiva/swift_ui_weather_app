import Foundation
class DefaultWeatherApiClient : WeatherApiClient {
    private let baseUrl = "https://api.weatherapi.com/v1/";
    private let apiKey = "9af9a3f28a0d4dde809125312250106";
    
    func getCurrentWeather(location: Location) async throws -> WeatherResponse {
        guard let url = URL(
            string: "\(baseUrl)current.json?key=\(apiKey)&q=$\(location.title)")
        else { throw NetworkError.badUrl }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse else { throw NetworkError.badResponse }
        
        guard response.statusCode >= 200 && response.statusCode < 300
        else { throw NetworkError.badStatus }
        
        guard let decodedResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
        else { throw NetworkError.failedToDecodeResponse }
        
        return decodedResponse
    }
    
    func getWeatherForDay(location: Location) async throws -> ForecastResponse {
        guard let url = URL(
            string: "\(baseUrl)forecast.json?key=\(apiKey)&q=\(location.title)&day=1")
        else { throw NetworkError.badUrl }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse else { throw NetworkError.badResponse }
        
        guard response.statusCode >= 200 && response.statusCode < 300
        else { throw NetworkError.badStatus }
        
        guard let decodedResponse = try? JSONDecoder().decode(ForecastResponse.self, from: data)
        else { throw NetworkError.failedToDecodeResponse }
        
        return decodedResponse
    }
}
