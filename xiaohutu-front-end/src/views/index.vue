<template>
  <div class="app-container home">
    <h1 style="color: whitesmoke">欢迎登录小糊涂后台管理系统</h1>
    <div class="charts">
      <Echarts :options="BarChartOptions" height="400px" width="600px"></Echarts>
      <Echarts :options="PieChartOptions" height="400px" width="600px"></Echarts>
      <Echarts :options="PieChartOptions" height="400px" width="600px"></Echarts>
      <Echarts :options="PieChartOptions" height="400px" width="600px"></Echarts>
      <Echarts :options="PieChartOptions" height="400px" width="600px"></Echarts>
      <Echarts :options="PieChartOptions" height="400px" width="600px"></Echarts>
    </div>

  </div>
</template>

<script setup name="Index">
import Echarts from "@/components/Echarts/Echarts.vue";
import { ref } from 'vue'

const version = ref('3.8.8')

function goTarget(url) {
  window.open(url, '__blank')
}
// 定义饼图配置
const PieChartOptions = ref({
  title: {
    text: '注册用户',
  },
  tooltip: {},
  legend: {
    data: ['注册用户']
  },
  series: [
    {
      name: '销量',
      type: 'pie',
      data: [
        { value: 335, name: '直接访问' },
        { value: 310, name: '邮件营销' },
        { value: 234, name: '联盟广告' },
        { value: 135, name: '视频广告' },
        { value: 1548, name: '搜索引擎' }
      ]
    }
  ]
})
// 定义树状图表配置
const BarChartOptions = {
  title: {
    text: 'title',
  },
  tooltip: {},
  xAxis: {
    data: ['衬衫', '羊毛衫', '雪纺衫', '裤子', '高跟鞋', '袜子'],
  },
  yAxis: {

  },
  series: [
    {
      name: '销量',
      type: 'bar',
      data: [5, 20, 36, 10, 10, 20],
    }
  ],
};
</script>

<style scoped lang="scss">
.home {
  background-color: #100c2a;
  .charts {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
  }
  blockquote {
    padding: 10px 20px;
    margin: 0 0 20px;
    font-size: 17.5px;
    border-left: 5px solid #eee;
  }
  hr {
    margin-top: 20px;
    margin-bottom: 20px;
    border: 0;
    border-top: 1px solid #eee;
  }
  .col-item {
    margin-bottom: 20px;
  }

  ul {
    padding: 0;
    margin: 0;
  }

  font-family: "open sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-size: 13px;
  color: #676a6c;
  overflow-x: hidden;

  ul {
    list-style-type: none;
  }

  h4 {
    margin-top: 0px;
  }

  h2 {
    margin-top: 10px;
    font-size: 26px;
    font-weight: 100;
  }

  p {
    margin-top: 10px;

    b {
      font-weight: 700;
    }
  }

  .update-log {
    ol {
      display: block;
      list-style-type: decimal;
      margin-block-start: 1em;
      margin-block-end: 1em;
      margin-inline-start: 0;
      margin-inline-end: 0;
      padding-inline-start: 40px;
    }
  }
}
</style>

