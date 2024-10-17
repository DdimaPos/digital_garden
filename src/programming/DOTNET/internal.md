---
tags:
  - programming
  - dotnet
  - OOP
---
# Definition
The `internal` keyword is an [[Access Modifiers]] for types and type members
```c#
class SampleClass
{
    internal int x;
}
```
Internal types or members are accessible only within **files in the same [[assembly]]**

# Usage
A common use of internal access is in component-based development because it enables a group of components to cooperate in a private manner without being exposed to the rest of the application code.
>[!warning]
>It is an error to reference a type or a member with internal access outside the assembly within which it was defined.

