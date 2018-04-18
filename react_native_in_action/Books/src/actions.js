export const ADD_BOOK = 'ADD_BOOK'
export const REMOVE_BOOK = 'REMOVE_BOOK'
import uuid from 'uuid/v4'


export function addBook (book) {
  return {
    type: ADD_BOOK,
    book: {
      id: uuid(),
      ...book
    }
  }
}


export function removeBook (book) {
  return {
    type: REMOVE_BOOK,
    book
  }
}
