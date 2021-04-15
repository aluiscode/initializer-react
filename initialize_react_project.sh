#Initialize a React project with JS
#by @lazcanocode
#10-04-2021
#! /bin/bash

echo "Initializing the React project"
echo "------------------------------"
echo "------------------------------"
read -p "Introduzca el nombre del projecto en minusculas: " NAME
read -p "Introduzca la descripcion del projecto: " DESC
read -p "Introduzca el nombre del autor del projecto: " AUTOR

#packeges.json
touch package.json
cat > package.json << EOF
{
  "name": "$NAME",
  "version": "1.0.0",
  "description": "$DESC",
  "main": "src/index.js",
  "scripts": {
    "start": "webpack serve --mode development",
    "build": "webpack --mode production",
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "$AUTOR",
  "license": "MIT",
  "dependencies": {
    "react": "^17.0.2",
    "react-dom": "^17.0.2",
    "react-router-dom": "^5.2.0",
    "styled-components": "^5.2.3"
  },
  "devDependencies": {
    "@babel/core": "^7.13.15",
    "@babel/preset-env": "^7.13.15",
    "@babel/preset-react": "^7.13.13",
    "babel-loader": "^8.2.2",
    "babel-plugin-styled-components": "^1.12.0",
    "eslint": "^7.24.0",
    "eslint-config-prettier": "^8.2.0",
    "eslint-config-standard": "^16.0.2",
    "eslint-plugin-import": "^2.22.1",
    "eslint-plugin-node": "^11.1.0",
    "eslint-plugin-promise": "^4.3.1",
    "eslint-plugin-react": "^7.23.2",
    "html-loader": "^2.1.2",
    "html-webpack-plugin": "^5.3.1",
    "prettier": "^2.2.1",
    "webpack": "^5.31.2",
    "webpack-cli": "^4.6.0",
    "webpack-dev-server": "^3.11.2"
  }
}

EOF

echo "Installing libraries"
npm i
echo "Installing libraries completed"

#Iniciar el proyecto
echo "Adding .gitgnore"
git init

#gitIgnore
touch .gitignore
cat > .gitignore << EOF
### react ###
.DS_*
*.log
logs
**/*.backup.*
**/*.back.*

node_modules
bower_components

*.sublime*

psd
thumb
sketch

EOF
echo ".gitignore completed"


echo "Creating project structure"
# Making folders
#Each component with their own style
mkdir src
mkdir src/assets
mkdir src/assets/fonts
mkdir src/assets/images
mkdir src/assets/svgs

#Each component with their own style
mkdir src/components

#Should contain routes, SEO files
mkdir src/constants


#Should containe the global state where all the global state api will be managed
mkdir src/contexts

#Should containe static text lie messages error or static contents
mkdir src/config

#Should containe all helpers methods
mkdir src/helpers

#Should containe webpages each page should have their individual stylesheet like each components
mkdir src/pages

#Should containe all the global styles, to avoid duplicated styles
mkdir src/styles


#index html
mkdir public
touch public/index.html
cat > public/index.html << EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<body>
  <div id="root"></div>
  <div id="modal"></div>
</body>
</html>

EOF

#index.js
touch src/index.js
cat > src/index.js << EOF
import React from 'react'
import ReactDOM from 'react-dom'
import { Routes } from './router'

const App = () => (
  <Routes />
)

ReactDOM.render(<App />, document.getElementById('root'))

EOF

#Making router
mkdir -p src/router
touch src/router/index.js
cat > src/router/index.js << EOF
import React from 'react'
import { BrowserRouter, Switch, Route } from 'react-router-dom'
import { Home } from '../pages/Home'

export const Routes = () => {
  return (
    <BrowserRouter>
      <Switch>
        <Route exact path='/' component={Home} />
      </Switch>
    </BrowserRouter>
  )
}

EOF

#Page Home
mkdir -p src/pages/Home
touch src/pages/Home/index.js
cat > src/pages/Home/index.js << EOF
import React from 'react'
import { H1 } from './styles'

export const Home = () => <H1>Hello World</H1>

EOF

touch src/pages/Home/styles.js
cat > src/pages/Home/styles.js << EOF
import styled from 'styled-components'

export const H1 = styled.h1\`
  color: blue;
\`

EOF


echo "Created project structure"

echo "Adding webpack"
#webpack
touch webpack.config.js
cat > webpack.config.js << EOF
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  entry: './src/index.js',
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: 'bundle.js'
  },
  resolve: {
    extensions: ['.js', '.jsx']
  },
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader'
        },
      },
      {
        test: /\.html$/,
        use: [
          {
            loader: 'html-loader'
          }
        ]
      }
    ]
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: './public/index.html',
      filename: './index.html'
    }),
  ],
  devServer: {
    contentBase: path.join(__dirname, 'dist'),
    compress: true,
    port: 3001,
  }
};

EOF

#babelrc
touch .babelrc
cat > .babelrc << EOF
{
  "presets": [
    "@babel/preset-env",
    "@babel/preset-react"
  ],
  "plugins": [
    [
      "babel-plugin-styled-components",
      {
        "ssr": false
      }
    ]
  ]
}

EOF
echo "Webpack Added"

# Formatear con Eslint in Visual Studio Code
    # "[javascript]": {
    #     "editor.defaultFormatter": "dbaeumer.vscode-eslint",
    #     "editor.formatOnSave": true
    # },
    # "[typescript]": {
    #     "editor.defaultFormatter": "dbaeumer.vscode-eslint",
    #     "editor.formatOnSave": true
    # },

#Eslint Prettier and Husky

echo "Eslint"
touch .eslintrc.js
cat > .eslintrc.js << EOF
  module.exports = {
  env: {
    browser: true,
    es2021: true
  },
  extends: [
    'plugin:react/recommended',
    'standard',
    'prettier'
  ],
  parserOptions: {
    ecmaFeatures: {
      jsx: true
    },
    ecmaVersion: 12,
    sourceType: 'module'
  },
  plugins: [
    'react'
  ],
  rules: {
  }
}

EOF
echo "Eslint added"

echo "Prettier"
touch .prettierrc
cat > .prettierrc << EOF
{
  "semi": false,
  "singleQuote": true
}

EOF
echo "Prettier added"
