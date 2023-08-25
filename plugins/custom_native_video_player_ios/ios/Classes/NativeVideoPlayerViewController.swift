import Foundation
import Flutter
import AVFoundation

public class NativeVideoPlayerViewController: NSObject, FlutterPlatformView {
    private let api: NativeVideoPlayerApi
    private let player: AVPlayer
    private let playerView: NativeVideoPlayerView

    init(
        messenger: FlutterBinaryMessenger,
        viewId: Int64,
        frame: CGRect
    ) {
        api = NativeVideoPlayerApi(
            messenger: messenger,
            viewId: viewId
        )
        player = AVPlayer(playerItem: nil)
        playerView = NativeVideoPlayerView(frame: frame, player: player)
        super.init()

        api.delegate = self
        player.addObserver(self, forKeyPath: "status", context: nil)
    }

    deinit {
        player.removeObserver(self, forKeyPath: "status")
        removeOnVideoCompletedObserver()

        player.replaceCurrentItem(with: nil)
    }

    public func view() -> UIView {
        playerView
    }

}

extension NativeVideoPlayerViewController: NativeVideoPlayerApiDelegate {
    func loadVideoSource(videoSource: VideoSource) {
        let isUrl = videoSource.type == .network
        let sourcePath = videoSource.path
        guard let uri = isUrl
            ? URL(string: sourcePath)
            : URL(fileURLWithPath: sourcePath)
        else {
            return
        }
        let videoAsset = AVAsset(url: uri)
        let playerItem = AVPlayerItem(asset: videoAsset)

        removeOnVideoCompletedObserver()
        player.replaceCurrentItem(with: playerItem)
        addOnVideoCompletedObserver()

        api.onPlaybackReady()
    }

    func getVideoInfo() -> VideoInfo {
        let videoInfo = VideoInfo(
            height: getVideoHeight(),
            width: getVideoWidth(),
            duration: getVideoDuration()
        )
        return videoInfo
    }

    func play() {
        player.play()
    }

    func pause() {
        player.pause()
    }

    func stop(completion: @escaping () -> Void) {
        player.pause()
        if #available(iOS 15, *) {
            // on iOS 15 or newer
            player.seek(to: CMTime.zero) { _ in completion()}
        } else {
            player.seek(to: CMTime.zero)
            completion()
        }
    }

    func isPlaying() -> Bool {
        player.rate != 0 && player.error == nil
    }

    func seekTo(position: Int, completion: @escaping () -> Void) {
        player.seek(
            to: CMTimeMakeWithSeconds(Float64(position), preferredTimescale: Int32(NSEC_PER_SEC)),
            toleranceBefore: .zero,
            toleranceAfter: .zero
        ) { _ in
            completion()
        }
    }

    func getPlaybackPosition() -> Int {
        let currentTime = player.currentItem?.currentTime() ?? CMTime.zero
        return Int(currentTime.isValid ? currentTime.seconds : 0)
    }

    func setPlaybackSpeed(speed: Double) {
        player.rate = Float(speed)
    }

    func setVolume(volume: Double) {
        player.volume = Float(volume)
    }
}

extension NativeVideoPlayerViewController {
    private func getVideoDuration() -> Int {
        Int(player.currentItem?.asset.duration.seconds ?? 0)
    }

    private func getVideoHeight() -> Int {
        if let videoTrack = getVideoTrack() {
            return Int(videoTrack.naturalSize.height)
        }
        return 0
    }

    private func getVideoWidth() -> Int {
        if let videoTrack = getVideoTrack() {
            return Int(videoTrack.naturalSize.width)
        }
        return 0
    }

    private func getVideoTrack() -> AVAssetTrack? {
        if let tracks = player.currentItem?.asset.tracks(withMediaType: .video),
           let track = tracks.first {
            return track
        }
        return nil
    }
}

extension NativeVideoPlayerViewController {
    override public func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey: Any]?,
        context: UnsafeMutableRawPointer?
    ) {
        if keyPath == "status" {
            switch (player.status) {
            case .unknown:
                break
            case .readyToPlay:
                break
            case .failed:
                if let error = player.error {
                    api.onError(error)
                }
            default:
                break
            }
        }
    }
}

extension NativeVideoPlayerViewController {
    @objc
    private func onVideoCompleted(notification: NSNotification) {
        api.onPlaybackEnded()
    }

    private func addOnVideoCompletedObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onVideoCompleted(notification:)),
            name: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem
        )
    }

    private func removeOnVideoCompletedObserver() {
        NotificationCenter.default.removeObserver(
            self,
            name: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem
        )
    }
}
