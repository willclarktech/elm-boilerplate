import App from 'koa';
import Router from 'koa-router';
import bodyParser from 'koa-bodyparser';
import cors from 'kcors';
import { graphqlKoa, graphiqlKoa } from 'graphql-server-koa';
import schema from './schema';

const HOST = 'localhost';
const PORT = 3030;
const API_ROUTE = '/api';
const GRAPHIQL_ROUTE = '/graphiql';

const app = new App();
const router = new Router();

app.use(bodyParser());
app.use(cors());

router.post(API_ROUTE, graphqlKoa({ schema }));
router.get(GRAPHIQL_ROUTE, graphiqlKoa({ endpointURL: API_ROUTE }));

app.use(router.routes());
app.use(router.allowedMethods());

app.listen(PORT, err =>
    err
        ? console.error(`API Error: ${err}`)
        : console.info(
          `API running at ${HOST}:${PORT}${API_ROUTE}`,
          `\nGraphiQL running at ${HOST}:${PORT}${GRAPHIQL_ROUTE}`
        )
);
