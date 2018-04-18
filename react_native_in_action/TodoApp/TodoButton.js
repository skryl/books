import React from 'react'
import { Text, TouchableHighlight, StyleSheet }  from 'react-native'

const TodoButton = ({ onPress, complete, name }) => (
  <TouchableHighlight
    onPress={onPress}
    underlayColor='#efefef'
    style={styles.button} >
    <Text style={[
      styles.text,
      complete ? styles.complete : null,
      name == 'Delete' ? styles.delete : null]} >
        {name}
    </Text>
  </TouchableHighlight>
)

const styles = StyleSheet.create({
  button: {
    padding: 7,
    borderColor: '#ededed',
    borderWidth: 1,
    borderRadius: 4,
    marginRight: 5
  },
  text: {
    color: '#666666'
  },
  complete: {
    color: 'green',
    fontWeight: 'bold'
  },
  delete: {
    color: 'rgba(175, 47, 47, 1)'
  }
})

export default TodoButton
