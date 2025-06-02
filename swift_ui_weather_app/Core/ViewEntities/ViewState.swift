enum ViewState<Data> {
    case loading
    case data(Data)
    case error(Error)
}
