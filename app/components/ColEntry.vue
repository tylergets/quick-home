<script setup>
const props = defineProps({
  item: {}
})

const item = computed(() => {
  return props.item;
})

function getFallbackImageUrl() {
  return "https://ui-avatars.com/api/?name=" + unref(item).name.toLowerCase();
}

const showFallback = ref(false);
const imageUrl = computed(() => {
  if(showFallback.value) {
    return getFallbackImageUrl();
  }
  return unref(item).icon;
});

function onImgError(e) {
  showFallback.value = true;
}

</script>

<template>
  <a :href="item.url" :target="item.target" class="flex gap-4 border-b-2 py-3">
    <img @error.native="onImgError" :src="imageUrl" :alt="item.name" class="h-10" >
    <div>
      <div>{{item.name}}</div>
      <div class="text-gray-400 text-xs">{{item.url}}</div>
    </div>
  </a>
</template>

<style scoped>

</style>