import Foundation
import Flutter

public class NativeVideoPlayerViewFactory: NSObject, FlutterPlatformViewFactory {
    public static let id = "native_video_player_view"

    private let messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
    }

    public func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        NativeVideoPlayerViewController(
            messenger: messenger,
            viewId: viewId,
            frame: frame
        )
    }
}
