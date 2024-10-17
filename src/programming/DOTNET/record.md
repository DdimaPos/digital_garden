---
tags:
  - programming
  - dotnet
  - OOP
---
# Record Modifier in C#

The `record` modifier defines a [reference type](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/reference-types) that encapsulates data. You can also use `record struct` to create similar features for value types.

> [!Note]  
> When a [primary constructor](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/instance-constructors#primary-constructors) is declared on a record, the compiler generates public properties for the constructor parameters, known as _positional properties_. These are only synthesized when the `record` modifier is used.

## Examples:

- **Reference type `record` (or `record class`):**
```c#
public record Person(string FirstName, string LastName);

public record Person
{
    public required string FirstName { get; init; }
    public required string LastName { get; init; }
};
```
- **Value type `record struct`:**
```c#
public readonly record struct Point(double X, double Y, double Z);

public record struct Point
{
    public double X { get; init; }
    public double Y { get; init; }
    public double Z { get; init; }
}

```
## Mutable Records
Records can also have mutable properties and fields:
- **Mutable `record`:**
```c#
public record Person
{
    public required string FirstName { get; set; }
    public required string LastName { get; set; }
};
```
- **Mutable `record struct`:**
```c#
public record struct DataMeasurement(DateTime TakenAt, double Measurement);

public record struct Point
{
    public double X { get; set; }
    public double Y { get; set; }
    public double Z { get; set; }
}
```

## Key Features of Records

- **Positional Property Definition**: Easy syntax for defining properties.
- **Value Equality**: Equality in record types is based on the values of their properties, though for reference-type properties, equality is determined by reference identity rather than the actual contents of the reference.
- **[[record#Nondestructive mutation]]**: Create modified copies of records without changing the original.
- **Display Formatting**: Built-in formatting for better display in debugging or logs.
- **Inheritance Support**: Records can be part of inheritance hierarchies.

## Reference vs. Value Types
- `record` or `record class` creates reference types. The `class` keyword is optional.
- `record struct` creates value types.
- Positional properties are immutable in `record class` and `readonly record struct`, but mutable in `record struct`.
## Positional syntax for property definition

You can declare properties using positional parameters and initialize them when creating an instance:

```c#
public record Person(string FirstName, string LastName);

public static void Main()
{
    Person person = new("Nancy", "Davolio");
    Console.WriteLine(person);
    // output: Person { FirstName = Nancy, LastName = Davolio }
}
```
### Compiler-Generated Features:
- **Public auto-implemented properties**:
    - `init-only` for `record` and `readonly record struct`.
    - Read-write for `record struct`.
- **Primary constructor** matching the positional parameters.
- **Parameterless constructor** for `record struct`, initializing fields to default values.
- **`Deconstruct` method** for extracting positional parameters.

You can apply attributes to these properties using the `property:`, `field:`, or `param:` targets:
```c#
public record Person([property: JsonPropertyName("firstName")] string FirstName, 
    [property: JsonPropertyName("lastName")] string LastName);
```
If the auto-implemented property isn't what you need, you can define your own property and adjust its accessibility or mutability:
```c#
public record Person(string FirstName, string LastName, string Id)
{
    internal string Id { get; init; } = Id;
}

public static void Main()
{
    Person person = new("Nancy", "Davolio", "12345");
    Console.WriteLine(person.FirstName); //output: Nancy
}
```
A record can also include additional fields or properties:
```c#
public record Person(string FirstName, string LastName)
{
    public string[] PhoneNumbers { get; init; } = [];
};
```
## Immutability

- **Positional records** and **readonly record structs** declare `init-only` properties.
- **Positional record structs** declare read-write properties, though you can override these defaults.

Immutability is useful for thread safety and hash codes but may not suit all use cases (e.g., [Entity Framework Core](https://learn.microsoft.com/en-us/ef/core/) doesn't support immutable entity types).

**Init-only properties** are shallowly immutable—after initialization, you can't change the property itself, but the data it references can be modified:
```c#
public record Person(string FirstName, string LastName, string[] PhoneNumbers);

public static void Main()
{
    Person person = new("Nancy", "Davolio", new string[1] { "555-1234" });
    Console.WriteLine(person.PhoneNumbers[0]); // output: 555-1234

    person.PhoneNumbers[0] = "555-6789";
    Console.WriteLine(person.PhoneNumbers[0]); // output: 555-6789
}
```

Records achieve immutability through compiler-synthesized methods, without modifying object state unless explicitly defined otherwise.
## Nondestructive mutation
Records in C# support **nondestructive mutation** using the `with` expression. This allows you to create a copy of an existing record instance with certain properties modified, without affecting the original instance.

For example:
```c#
public record Person(string FirstName, string LastName)
{
    public string[] PhoneNumbers { get; init; }
}

public static void Main()
{
    Person person1 = new("Nancy", "Davolio") { PhoneNumbers = new string[1] };
    Console.WriteLine(person1);
    // output: Person { FirstName = Nancy, LastName = Davolio, PhoneNumbers = System.String[] }

    Person person2 = person1 with { FirstName = "John" };
    Console.WriteLine(person2);
    // output: Person { FirstName = John, LastName = Davolio, PhoneNumbers = System.String[] }
    Console.WriteLine(person1 == person2); // output: False

    person2 = person1 with { PhoneNumbers = new string[1] };
    Console.WriteLine(person2);
    // output: Person { FirstName = Nancy, LastName = Davolio, PhoneNumbers = System.String[] }
    Console.WriteLine(person1 == person2); // output: False

    person2 = person1 with { };
    Console.WriteLine(person1 == person2); // output: True
}
```

The `with` expression creates a **shallow copy** of the original instance. If a record has reference-type properties, the reference is copied, not the actual object it points to. This means that both the original and the copied instance share the same reference to the object.

In the case of a **`record class`**, the compiler synthesizes the following methods to support nondestructive mutation:

- **A clone method**: This method creates a new instance and is invoked by the `with` expression.
- **A copy constructor**: This constructor initializes the new instance with the same values as the original instance, except for properties modified by the `with` expression.

The clone method cannot be overridden, and you cannot define a member named `Clone` in any record type.

If you need different copying behavior, you can define your own copy constructor. If you do, the compiler will not generate one. For sealed records, the constructor should be `private`; for others, it should be `protected`.
