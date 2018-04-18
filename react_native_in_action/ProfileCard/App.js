import React, { Component } from 'react';
import { View, Text, Image } from 'react-native';
import styles from './Styles'


export default class App extends Component<Props> {
  render() {
    return (
      <View style={styles.container}>
        <View style={styles.cardContainer}>
          <View style={styles.cardImageContainer}>
            <Image style={styles.cardImage} source={require('./profile.png')}/>
          </View>
          <View>
            <Text style={styles.cardName}>
              John Doe
            </Text>
          </View>
          <View style={styles.cardOccupationContainer}>
            <Text style={styles.cardOccupation}>
              React Native Developer
            </Text>
          </View>
          <View>
            <Text style={styles.cardDescription}>
              John is a really great JavaScript developer. He
              loves using JS to build React Native applications
              for iOS and Android.
            </Text>
          </View>
        </View>
      </View>
    );
  }
}
