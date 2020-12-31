process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')
// ESlint(Vueあり)の設定
const eslint =  require('./loaders/eslint')
environment.loaders.append('eslint', eslint)

module.exports = environment.toWebpackConfig()
