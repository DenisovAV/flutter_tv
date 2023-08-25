import Foundation

struct VideoSource {
    let path: String
    let type: VideoSourceType

    init?(from map: [String: Any]) {
        guard let path = map["path"] as? String else { return nil }
        self.path = path

        let typeRaw = map["type"] as? String ?? ""
        guard let type = VideoSourceType(rawValue: typeRaw) else { return nil }
        self.type = type
    }
}
