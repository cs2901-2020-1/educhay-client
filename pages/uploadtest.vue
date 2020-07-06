<template>
  <div class="container">
    <div class="large-12 medium-12 small-12 cell">
      <label
        >File
        <input id="file" ref="file" type="file" @change="handleFileUpload()" />
      </label>
      <button @click="submitFile()">Submit</button>
    </div>
  </div>
</template>

<script>
  export default {
    auth: false,
    data() {
      return {
        file: ''
      }
    },
    methods: {
      submitFile() {
        const formData = new FormData()
        formData.append('file', this.file)
        this.$axios
          .post('/uploadFile', formData, {
            headers: {
              'Content-Type': 'multipart/form-data'
            }
          })
          .then(function() {
            console.log('gaa')
          })
          .catch(function() {
            console.log('gee')
          })
      },
      handleFileUpload() {
        this.file = this.$refs.file.files[0]
      }
    }
  }
</script>
