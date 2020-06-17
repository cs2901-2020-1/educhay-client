<template>
  <div class="parallax">
    <div id="title" class="title">
      <p>La plataforma de cursos más completa del país</p>
      <h2>Aprende con <span class="logo">Educhay</span></h2>
    </div>
    <v-btn color="rgb(1, 166, 255)" class="enter">¡Ingresa ya!</v-btn>
  </div>
</template>

<script>
  export default {
    auth: false
  }
</script>

<style>
  .logo {
    font-weight: 900;
    color: rgb(25, 84, 140);
  }

  .enter {
    padding: 1rem 0 0 0;
    width: auto;
    color: white !important;
  }

  #title {
    text-align: center;
    color: white;
    font-weight: bold !important;
    padding: 0 0 6rem 0;
    font-size: 1.5rem !important;
  }

  #title > h2 {
    font-weight: bolder;
  }

  .parallax {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    background-image: url(../assets/slide1.png);

    height: 70vh;

    background-attachment: fixed;
    background-position: top;
    background-repeat: no-repeat;
    background-size: cover;
  }
</style>
