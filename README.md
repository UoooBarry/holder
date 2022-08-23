# README

[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
![auto-test](https://github.com/UoooBarry/rails-forum/actions/workflows/auto-test.yml/badge.svg)

Ruby On Rails Forum API Project.

## Getting Started

This project is warped up with docker-compose.

### build and setup project

```bash
make init
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
