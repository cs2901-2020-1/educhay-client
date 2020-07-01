<template>
  <div>
    <video-player :options="videoOptions" />
  </div>
</template>

<script>
  import VideoPlayer from '@/components/VideoPlayer.vue'
  import awsvideoconfig from '~/src/aws-video-exports'

  export default {
    name: 'VideoExample',
    auth: false,
    components: {
      VideoPlayer
    },
    data() {
      return {
        videoOptions: {
          autoplay: false,
          controls: true,
          sources: [
            {
              src:
                'https://' +
                awsvideoconfig.awsOutputVideo +
                '/color_pencils_small_frames/color_pencils_small_frames.m3u8',
              type: 'application/x-mpegURL'
            }
          ]
        }
      }
    }
  }
</script>
<style>
  @import 'node_modules/video.js/dist/video-js.css';
</style>
