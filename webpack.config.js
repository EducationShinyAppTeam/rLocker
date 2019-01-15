const path = require('path');
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');

module.exports = {
  mode: "production",
  entry: {
    rlocker: path.resolve(__dirname, "inst/www/js/src/app.js"),
  },
  optimization: {
    minimizer: [
      new UglifyJsPlugin({
        uglifyOptions: {
          output: {
            comments: false
          }
        }
      })
    ]
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
          options: {
            "presets": [
              ["env", {
                "targets": {
                  "browsers": [
                    "Chrome >= 52",
                    "FireFox >= 44",
                    "Safari >= 7",
                    "Explorer 11",
                    "last 4 Edge versions"
                  ]
                }
              }],
            ],
          }
        }
      },
    ]
  },
  output: {
    path: path.resolve(__dirname, "inst/www/js/dist/"),
    filename: "[name].js",
  }
}