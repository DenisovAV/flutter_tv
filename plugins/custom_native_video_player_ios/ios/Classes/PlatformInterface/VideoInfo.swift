struct VideoInfo {
    let height: Int
    let width: Int
    let duration: Int

    func toMap() -> [String: Any] {
        [
            "height": height,
            "width": width,
            "duration": duration
        ]
    }
}
