import React, { Component } from 'react';
import { StackNavigator }   from 'react-navigation'
import StarWars             from './StarWars'
import People               from './People'

const App = StackNavigator({
  StarWars: {
    screen: StarWars
  },
  People: {
    screen: People
  }
})

export default App
