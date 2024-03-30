<script setup lang="ts">
const { data, pending } = await useFetch('/api/settings')
</script>

<template>
  <div v-if="pending">
    Loading...
  </div>
  <div v-else>
    <MainDash :data="data" />
  </div>
</template>
