import React    from 'react'
import { View } from 'react-native'
import Todo     from './Todo'

const TodoList = ({ toggleTodo, deleteTodo, todos }) => {
  todos = todos.map((todo, i) => (
    <Todo
      toggleTodo={toggleTodo}
      deleteTodo={deleteTodo}
      key={i}
      todo={todo} />
  ))

  return(
    <View> {todos} </View>
  )
}

export default TodoList
