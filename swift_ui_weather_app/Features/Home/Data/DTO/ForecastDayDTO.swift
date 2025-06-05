struct ForecastDayDTO: Codable {
    let date: String
    let dateEpoch: Int
    let hour: [HourInfoDTO]

    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case hour
    }
}
