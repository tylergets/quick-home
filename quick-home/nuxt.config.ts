// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: true },
  modules: ["@nuxtjs/tailwindcss", "@nuxtjs/google-fonts"],

  telemetry: false,

  googleFonts: {
    download: false,
    families: {
      Roboto: true,
    }
  }
})