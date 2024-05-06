<script setup >
const props = defineProps({
  data: Object
})

const categories = computed(() => {
  const categoriesMap = {};
  // Group items into categories
  for (const item of props.data.items) {
    const name = item.category ?? 'None';
    if (!categoriesMap[name]) {
      categoriesMap[name] = [];
    }
    categoriesMap[name].push(item);
  }

  // Convert the categories object to an array of { name, items }
  const categoryList = Object.keys(categoriesMap).map(name => ({
    name,
    items: categoriesMap[name]
  }));

  // Sort the categories by the number of items to help even out the columns
  categoryList.sort((a, b) => b.items.length - a.items.length);

  // Determine the number of columns
  const numColumns = 3; // change this as needed
  const columns = Array.from({ length: numColumns }, () => []);

  // Distribute categories into columns trying to even out the number of items per column
  categoryList.forEach(category => {
    // Find the column with the least number of items
    const targetColumn = columns.reduce((minCol, currentCol, index) => {
      const minItems = columns[minCol].reduce((sum, cat) => sum + cat.items.length, 0);
      const currentItems = currentCol.reduce((sum, cat) => sum + cat.items.length, 0);
      return currentItems < minItems ? index : minCol;
    }, 0);

    // Add the category to the target column
    columns[targetColumn].push(category);
  });

  return columns;
});

</script>

<template>


  <div class="grid grid-cols-3 gap-2 p-2">
    <div v-for="(column, c) in categories" class="flex flex-col gap-2">
      <div v-for="(category, r) in column">
        <div class="border-2 border-gray-400 rounded-xs">

          <div class="px-2 py-1 bg-gray-300 border-b-2 border-gray-400">
            {{category.name}}
          </div>

          <div class="p-2">
            <div v-for="item in category.items">
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
    </div>
  </div>
</template>

