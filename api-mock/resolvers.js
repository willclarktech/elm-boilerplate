import { user as userFixture, todos } from './fixtures';

const resolvers = {
  Query: {
    user(root, { id }) {
      return { ...userFixture, id, todos };
    },
  },
  Mutation: {
    updateUserTodos(root, { user }) {
      return user;
    },
  },
};

export default resolvers;
