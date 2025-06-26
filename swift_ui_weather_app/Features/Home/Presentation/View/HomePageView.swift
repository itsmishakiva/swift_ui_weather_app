import SwiftUI
import Foundation

struct HomePageView: View {
    static let screenSize = UIScreen.main.bounds
    static let screenWidth = screenSize.width
    static let screenHeight = screenSize.height
    
    @StateObject private var viewModel = HomePageViewModel(
        repository: DefaultWeatherRepository(
            apiClient: DefaultWeatherApiClient(),
            mapper: WeatherMapper()
        )
    )
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .error(let error):
                Text(error.localizedDescription)
            case .data(let data):
                var currentImageURL: String {
                    data.currentImageURL
                }
                var currentWeather: WeatherInfo {
                    data.currentWeather
                }
                var location: Location {
                    data.location
                }
                var forecast: [HourlyWeatherInfo]? {
                    data.forecast
                }
                
                
                AsyncImage(url: URL(string: currentImageURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                } placeholder: {
                    Color.blue.ignoresSafeArea()
                }
                ScrollView() {
                    GeometryReader { geometry in
                        let offset = geometry.frame(in: .global).minY
                        let _ = print("\( max(220, 220 + (offset / 62) * 80))")
                        
                        LazyVStack(pinnedViews: [.sectionHeaders]) {
                            Section(
                                header: ZStack(alignment: .top) {
                                    VStack(spacing: 0) {
                                        Color.clear.frame(height: 60)
                                        Text(
                                            location.title,
                                        ).font(.headline)
                                            .foregroundColor(.white)
                                        Color.clear.frame(height: 16)
                                        Text(
                                            String(format: "%d°C", currentWeather.temperatureCelsium)
                                        ).font(.headlineHuge)
                                            .foregroundColor(.white)
                                        Color.clear.frame(height: 20)
                                        HStack(alignment: .top){
                                            VStack(spacing: 0){
                                                Text(
                                                    String(format: "Wind: %d km/h", currentWeather.windKm)
                                                ).font(.caption)
                                                    .foregroundColor(.white)
                                                Color.clear.frame(height: 8)
                                                Text(
                                                    String(format: "Feels like: %d °C", currentWeather.feelsLikeCelsium)
                                                ).font(.caption)
                                                    .foregroundColor(.white)
                                            }
                                            Spacer()
                                            VStack{
                                                Text(
                                                    
                                                    String(format: "Humidity: %d", currentWeather.humidity)
                                                ).font(.caption)
                                                    .foregroundColor(.white)
                                            }
                                        }.padding(.horizontal, 48)
                                            .opacity(pow(Double(offset / 62), 3.0))
                                        Spacer()
                                    }
                                }
                                    .frame(height: max(220, 220 + (offset / 62) * 80), alignment: .top)
                                .clipped()
                                .offset(y: max(-40, -(1 - offset / 62) * 40))
                            ){
                                VStack() {
                                    if forecast != nil {
                                        ScrollView(.horizontal, showsIndicators: false){
                                            HStack(spacing: 16) {
                                                Spacer().frame(width: 0)
                                                ForEach(0..<forecast!.count, id: \.self) { index in
                                                    WeatherForHourTile(weather: forecast![index])
                                                }
                                                Spacer().frame(width: 0)
                                            }
                                        }
                                    }
                                    Spacer().frame(height: 60)
                                    Spacer()
                                }.frame(width: HomePageView.screenWidth)
                            }.frame(width: HomePageView.screenWidth, height: 300)
                        }
                    }
                }
            }
        }.onAppear {
            Task {
                await viewModel.getCurrentWeather()
            }
        }
    }
}

#Preview {
    HomePageView()
}
