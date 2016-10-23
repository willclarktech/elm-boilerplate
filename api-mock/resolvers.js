import { user, todos } from './fixtures';

const resolvers = {
  Query: {
    user() {
      return user;
    },
  },
  User: {
    todos() {
      return todos;
    },
  },
};

export default resolvers;
