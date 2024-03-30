<script setup >
const props = defineProps({
  data: Object
})
</script>

<template>
  <div class="px-4">
    <div v-for="item in data.items">
      <a :href="item.url" :target="item.target" class="flex gap-4 border-b-2 py-3">
        <img :src="item.icon" :alt="item.name" class="h-10" >
        <div>
          <div>{{item.name}}</div>
          <div class="text-gray-400 text-xs">{{item.url}}</div>
        </div>
      </a>
    </div>
  </div>
</template>

<style scoped>

</style>