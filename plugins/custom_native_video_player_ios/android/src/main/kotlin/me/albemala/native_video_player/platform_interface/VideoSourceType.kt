package me.albemala.native_video_player.platform_interface

enum class VideoSourceType(val value: String) {
    Asset("asset"),
    File("file"),
    Network("network");
}
