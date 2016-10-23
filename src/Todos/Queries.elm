module Todos.Queries exposing (queryUser, updateUserTodos)


queryUser : String
queryUser =
    """
query queryUser($userId: String!) {
  user(id: $userId) {
    id
    todos {
      id
      text
      completed
    }
  }
}
"""


updateUserTodos : String
updateUserTodos =
    """
mutation updateUserTodos($user: UserInput!) {
  updateUserTodos(user: $user) {
    id
    todos {
      id
      text
      completed
    }
  }
}
"""
