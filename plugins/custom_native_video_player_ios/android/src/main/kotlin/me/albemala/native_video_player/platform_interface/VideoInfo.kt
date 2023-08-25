package me.albemala.native_video_player.platform_interface

data class VideoInfo(
    val height: Int,
    val width: Int,
    val duration: Int
) {
    fun toMap(): Map<String, Any> = mapOf(
        "height" to height,
        "width" to width,
        "duration" to duration
    )
}
