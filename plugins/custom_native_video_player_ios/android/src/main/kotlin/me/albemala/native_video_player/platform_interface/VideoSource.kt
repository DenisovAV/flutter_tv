package me.albemala.native_video_player.platform_interface

data class VideoSource(
    val path: String,
    val type: VideoSourceType
) {
    companion object {
        fun from(map: Map<*, *>): VideoSource? {
            val path = map["path"] as? String
                ?: return null
            val typeValue = map["type"] as? String
                ?: return null
            val type = VideoSourceType
                .values()
                .firstOrNull {
                    it.value == typeValue
                }
                ?: return null
            return VideoSource(
                path,
                type
            )
        }
    }
}
