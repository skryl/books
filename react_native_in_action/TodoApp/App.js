import React, { Component }             from 'react'
import { StyleSheet, View, ScrollView } from 'react-native'
import Heading                          from './Heading'
import Input                            from './Input'
import Button                           from './Button'
import TodoList                         from './TodoList'

let todoIndex = 0;

class App extends Component {
  constructor( ) {
    super()
    this.state = {
      inputValue: '',
      todos: [],
      type: 'All'
    }

    this.submitTodo = this.submitTodo.bind(this)
    this.toggleTodo = this.toggleTodo.bind(this)
    this.deleteTodo = this.deleteTodo.bind(this)
  }

  inputChange(inputValue) {
    console.log('Input Value: ' + inputValue)
    this.setState({ inputValue })
  }

  submitTodo() {
    const { todos, inputValue } = this.state

    if (inputValue.match(/^\s*$/)) { return }

    let todo = {
      title:    inputValue,
      index:    todoIndex,
      complete: false
    }

    todoIndex++
    todos.push(todo)
    this.setState({ todos: todos, inputValue: '' }, () => console.log('State: ', this.state))
  }

  toggleTodo(todoIndex) {
    let { todos } = this.state
    todos.forEach((todo) => ((todo.index == todoIndex) ? todo.complete = !todo.complete : null))
    this.setState({todos})
  }

  deleteTodo(todoIndex) {
    let { todos } = this.state
    todos = todos.filter((todo) => (todo.index != todoIndex))
    this.setState({todos})
  }

  render() {
    const { todos, inputValue } = this.state

    return (
      <View style={styles.container}>
        <ScrollView
         keyboardShouldPersistTaps='always'
         style={styles.content}>
          <Heading />
          <Input
            inputValue={inputValue}
            inputChange={(text) => (this.inputChange(text))} />
          <TodoList
            toggleTodo={this.toggleTodo}
            deleteTodo={this.deleteTodo}
            todos={todos} />
          <Button submitTodo={this.submitTodo} />
        </ScrollView>
      </View>
    )
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5'
  },
  content: {
    flex: 1,
    paddingTop: 60
  }
})

export default App
