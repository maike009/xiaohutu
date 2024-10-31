module.exports = {
  root: true,
  env: {
    browser: true, //  根据你的目标环境添加，如果代码运行在 Node.js 中，则添加 node: true
  },
  extends: [
    'plugin:vue/vue3-essential', //  或 'plugin:vue/vue3-recommended'  (推荐)
    'eslint:recommended',
    'plugin:prettier/recommended',  //  简化 Prettier 集成
  ],
  parserOptions: {
    ecmaVersion: 'latest', //  或 2022 或其他支持的版本
    sourceType: 'module', //  如果使用 ES modules
  },
  plugins: [
    'vue',  //  确保已安装 eslint-plugin-vue
    'prettier',  //  如果使用 prettier/prettier 规则，则需要
  ],
  rules: {
    'prettier/prettier': [
      'warn', //  或 'error'
      {
        singleQuote: true,
        semi: false,
        printWidth: 100,
        trailingComma: 'all', //  或 'es5' 或 'none'
        endOfLine: 'auto', //  通常不需要配置，让 Prettier 自动检测
      },
    ],
    'vue/multi-word-component-names': 'off', //  关闭驼峰命名规则
    'vue/no-setup-props-destructure': 'off', // 允许在 <script setup> 中解构 props
    'vue/no-deprecated-html-element-is': 'off', // 关闭对已弃用 HTML 元素的 is 属性的检查
    // '@typescript-eslint/no-unused-vars': 'off', // 如果你不使用 TypeScript，不需要这个规则
  },
};