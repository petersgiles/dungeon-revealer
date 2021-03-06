ARG NODE_VERSION=10

FROM node:$NODE_VERSION

WORKDIR /usr/src/build

COPY . .

RUN echo "unsafe-perm = true" > .npmrc

RUN npm install

ARG SPACE=4000

RUN export NODE_OPTIONS=--max_old_space_size=$SPACE && npm run build

RUN node ./scripts/copy-node-bindings-path.js

ARG FETCH_CMD=true

RUN eval $FETCH_CMD

ARG ARCH

RUN npm run compile:$ARCH

CMD ["sh"]
