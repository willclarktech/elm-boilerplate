import { user, todos } from './fixtures';

const resolvers = {
  Query: {
    user(root, { id }) {
      return { ...user, id };
    },
  },
  User: {
    todos() {
      return todos;
    },
  },
};

export default resolvers;
