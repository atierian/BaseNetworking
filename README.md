# Networking

Example generic networking layer for a consistent environment that can be wrapped by specific services within that environment.
To create a new service layer:
- Define data models
- Define endpoints
- Define public APIs for service

Some highlights:
- Test coverage
- Ease of adding new services
- Ability to change development environment in single build for ease of QA testing
- Ability to define logging levels and logger output format

Some notes:
- Experimented with a few different approaches to dependency injection / mocking.
- This is just an example implementation of an idea, it is not a finished "product"
