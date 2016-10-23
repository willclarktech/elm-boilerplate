import { makeExecutableSchema } from 'graphql-tools';

const schema = `
type Todo {
  id: Int!
  text: String!
  completed: Boolean!
}

type User {
  id: Int!
  todos: [Todo]
}

type Query {
  user: User
}

schema {
  query: Query
}
`;

const typeDefs = [schema];
const resolvers = {
  Query: {
    user() {
      return {
        id: 1,
        todos: [
          {
            id: 11234,
            text: 'Go shopping',
            completed: true,
          },
          {
            id: 453,
            text: 'Work out',
            completed: false,
          },
          {
            id: 2,
            text: 'Learn something',
            completed: false,
          },
          {
            id: 23456,
            text: 'Breathe',
            completed: true,
          },
          {
            id: 888,
            text: 'Worship devil',
            completed: true,
          },
        ],
      };
    },
  },
};

const executableSchema = makeExecutableSchema({
  typeDefs,
  resolvers,
});

export default executableSchema;
