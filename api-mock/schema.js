import { makeExecutableSchema } from 'graphql-tools';
import typeDefs from './typeDefs';
import resolvers from './resolvers';

const executableSchema = makeExecutableSchema({
  typeDefs,
  resolvers,
  logger: { log: e => console.error(e) },
});

export default executableSchema;
