<template>
  <div ref="chartRef" :style="{ width: width, height: height }"></div>
</template>

<script setup>
import * as echarts from 'echarts';
import { ref, onMounted, onBeforeUnmount, watch,defineProps } from 'vue';

// 定义接收的 props
const props = defineProps({
  options: {
    type: Object,
    required: true,
  },
  width: {
    type: String,
    default: '100%',
  },
  height: {
    type: String,
    default: '400px',
  },
});

// DOM 引用
const chartRef = ref(null); // 用于绑定图表容器
let chartInstance = null;   // 图表实例

// fetch('../../theme/customed.json').then(r => r.json())
//     .then(theme => {
//       console.log(theme)
//       echarts.registerTheme('customed', theme)
//     })
// 初始化图表
const initChart = () => {
  if (chartRef.value) {
    chartInstance = echarts.init(chartRef.value,'dark'); // 初始化 ECharts 实例
    chartInstance.setOption(props.options);            // 设置图表配置项
  }
};

// 监听窗口大小调整以自适应图表
const resizeChart = () => {
  chartInstance?.resize();
};

// 监听 options 变化
watch(
    () => props.options,
    (newOptions) => {
      if (chartInstance) {
        chartInstance.setOption(newOptions); // 更新图表
      }
    },
    { deep: true }
);

// 生命周期钩子
onMounted(() => {
  initChart();
  window.addEventListener('resize', resizeChart); // 监听窗口大小变化
});

onBeforeUnmount(() => {
  window.removeEventListener('resize', resizeChart); // 移除监听器
  chartInstance?.dispose();                          // 销毁实例
});
</script>

<style scoped>
/* 添加必要的样式 */
</style>
