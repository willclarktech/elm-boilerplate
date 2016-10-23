import fs from 'fs';
import path from 'path';

const schema = fs.readFileSync(
  path.join(__dirname, 'typeDefs.graphql'),
  'utf8'
);

const typeDefs = [schema];

export default typeDefs;
