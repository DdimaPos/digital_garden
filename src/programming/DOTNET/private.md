---
tags:
  - programming
  - dotnet
  - OOP
---
The `private` keyword is a member [[Access Modifiers]].

Private access is the least permissive access level. Private members are accessible **only within the body** of the class or the struct in which they are declared, as in this example:
```c#
class Employee
{
    private int _i;
    double _d;  
}
```

>[!note]
>Nested types in the same body can also access those private members.

>[!error]
>It is a compile-time error to reference a private member outside the class or the struct in which it is declared.

