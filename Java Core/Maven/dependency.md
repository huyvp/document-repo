# <dependency>

[← Back to Index](README.md)

## Description
Represents a dependency required by the project.

## Example
```xml
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-web</artifactId>
  <version>3.2.0</version>
</dependency>
```

## Options & Explanation
- groupId: Organization providing the dependency
- artifactId: Artifact name
- version: Version of dependency
- scope:
  - compile (default)
  - provided
  - runtime
  - test
- optional: Whether dependency is optional
