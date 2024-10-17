---
tags:
  - programming
  - dotnet
  - OOP
---
The `protected internal` keyword combination is a member [[Access Modifiers]]. A protected  internal member is **accessible from the current [[assembly]] or from types that are derived from the containing class**.
> [!note]
> Struct members cannot be `protected internal` because the struct cannot be inherited

# Overriding protected internal members
When overriding a virtual member, the accessibility modifier of the overridden method depends on the [[assembly]] where the derived class is defined.

When the derive class is define din the same assembly as the base class, all overridden members have `protected internal` access. If the derived class is defined in a different assembly from the base class, overridden member have `protected` access. 