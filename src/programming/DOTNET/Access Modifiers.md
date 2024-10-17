---
tags:
  - programming
  - dotnet
---
All types and type members have an accessibility level. The accessibility level controls whether they can be used from other code in your [[assembly]] or other assemblies. 

- [[public]]: Code in any assembly can access this type or member. The accessibility level of the containing type controls the accessibility level of public members of the type.
- [[private]]: Only code declared in the same `class` or `struct` can access this member.
- [[protected]]: Only code in the same `class` or in a derived `class` can access this type or member.
- [[internal]]: Only code in the same [[assembly]] can access this type or member.
- [[protected internal]]: Only code in the same [[assembly]] _or_ in a derived class in another assembly can access this type or member.
- [[private protected]]: Only code in the same [[assembly]] _and_ in the same class or a derived class can access the type or member.
- file: Only code in the same file can access the type or member.

The [[record]] modifier on a type causes the compiler to synthesize extra members. The `record` modifier doesn't affect the default accessibility for either a `record class` or a `record struct`.
## Summary table

| Caller's location                      | `public` | `protected internal` | `protected` | `internal` | `private protected` | `private` | `file` |
| -------------------------------------- | -------- | -------------------- | ----------- | ---------- | ------------------- | --------- | ------ |
| Within the file                        | ✔️️      | ✔️                   | ✔️          | ✔️         | ✔️                  | ✔️        | ✔️     |
| Within the class                       | ✔️️      | ✔️                   | ✔️          | ✔️         | ✔️                  | ✔️        | ❌      |
| Derived class (same assembly)          | ✔️       | ✔️                   | ✔️          | ✔️         | ✔️                  | ❌         | ❌      |
| Non-derived class (same assembly)      | ✔️       | ✔️                   | ❌           | ✔️         | ❌                   | ❌         | ❌      |
| Derived class (different assembly)     | ✔️       | ✔️                   | ✔️          | ❌          | ❌                   | ❌         | ❌      |
| Non-derived class (different assembly) | ✔️       | ❌                    | ❌           | ❌          | ❌                   | ❌         | ❌      |
