import { Platform, StyleSheet } from 'react-native';

const profileCardColor = 'dodgerblue';

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center'
  },

  cardContainer: {
    alignItems: 'center',
    backgroundColor: profileCardColor,
    width: 300,
    height: 400,
    borderWidth: 3,
    borderRadius: 20,
    ...Platform.select({
      ios: {
        shadowColor: 'black',
        shadowOffset: {
          height: 10
        },
        shadowOpacity: 1
      },
      android: {
        elevation: 15
      }
    })
  },

  cardImageContainer: {
    alignItems: 'center',
    backgroundColor: 'white',
    width: 120,
    height: 120,
    borderWidth: 3,
    borderRadius: 60,
    marginTop: 30,
    paddingTop: 15,
    ...Platform.select({
      ios: {
        shadowColor: 'black',
        shadowOffset: {
          height: 10
        },
        shadowOpacity: 1
      },
      android: {
        elevation: 15,
        borderWidth: 3
      }
    })
  },

  cardImage: {
    width: 80,
    height: 80
  },

  cardName: {
    color: 'white',
    marginTop: 30,
    fontWeight: 'bold',
    fontSize: 24,
    textShadowColor: 'black',
    textShadowOffset: {
      height: 2,
      width: 2
    },
    textShadowRadius: 3
  },

  cardOccupationContainer: {
    borderColor: 'black',
    borderBottomWidth: 3
  },

  cardOccupation: {
    marginTop: 10,
    marginBottom: 10,
    fontWeight: 'bold'
  },

  cardDescription: {
    marginTop: 10,
    marginRight: 40,
    marginLeft: 40,
    marginBottom: 10,
    fontStyle: 'italic'
  }
});

export default styles
