# README

[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
![auto-test](https://github.com/UoooBarry/rails-forum/actions/workflows/auto-test.yml/badge.svg)

Ruby On Rails Forum API Project.

## Stacks

[Ruby On Rails](https://rubyonrails.org/)

[PostgreSQL](https://www.postgresql.org/)

[ElasticSeach](https://www.elastic.co/)

## Getting Started

This project is warped up with docker-compose.

### Build and setup project

```bash
make init
```

### Start project

```bash
docker-compose up
```

## Tests

[Rspec](https://github.com/rspec/rspec-rails) is setup to run the tests automatically.
Spec files are in [specs](./spec/)

Please run the tests with

```bash
make rspec
```

## Github Actions

[Github Action](https://github.com/UoooBarry/rails-forum/actions) is setup to run the rspec and rubocop automatically. Failures will be marked in the pipelines.

## API

### Response Format

Each response will contains a `meta` object,
You can get the status code and message from the `meta` object.

```json
"meta": {
  "status": 200,
  "message": "success"
}
```

When errors occur, the status and message fields in `meta` will be filled with the error message.

```json
"meta": {
  "status": 401,
  "message": "Information provided is not correct"
}
```

### Documentation

![/api-docs](./docs/assets/api-doc.png)

A swagger [JSON file](swagger/v1/swagger.json) is provided to describe the API.

You can access api-doc via [/api-docs](http://localhost:3000/api-docs)

### Update api doc

[Rswag](https://github.com/rswag/rswag) is used to write endpoint tests and auto generate descriptions.

```bash
make swaggerize
```
