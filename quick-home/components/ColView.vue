<script setup >
const props = defineProps({
  data: Object
})

const columnsWithItems = computed(() => {
  const columnCount = props.data.columns;
  const items = props.data.items;
  if(!items) return []
  // split items into columns evenly
  return items.reduce((acc, item, index) => {
    const columnIndex = index % columnCount;
    if (!acc[columnIndex]) {
      acc[columnIndex] = [];
    }
    acc[columnIndex].push(item);
    return acc;
  }, []);
})
</script>

<template>


  <div class="gap-4 flex">
    <div class="flex-1" v-for="column in columnsWithItems">
        <div class="px-4">
          <div v-for="item in column">
            <a :href="item.url" :target="item.target" class="flex gap-4 border-b-2 py-3">
              <img :src="item.icon" :alt="item.name" class="h-10" >
              <div>
                <div>{{item.name}}</div>
                <div class="text-gray-400 text-xs">{{item.url}}</div>
              </div>
            </a>
          </div>
        </div>
    </div>
  </div>

</template>

<style scoped>

</style>