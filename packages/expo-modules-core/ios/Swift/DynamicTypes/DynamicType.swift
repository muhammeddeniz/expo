// Copyright 2021-present 650 Industries. All rights reserved.

// Function names should start with a lowercase character, but in this one case
// we want it to be uppercase as we treat it more like a generic class.
// swiftlint:disable identifier_name

/**
 Factory creating an instance of the dynamic type wrapper conforming to `AnyDynamicType`.
 Depending on the given type, it may return one of `DynamicArrayType`, `DynamicOptionalType`, `DynamicConvertibleType`, etc.
 */
internal func DynamicType<T>(_ type: T.Type) -> AnyDynamicType {
  if let ArrayType = T.self as? AnyArray.Type {
    return DynamicArrayType(elementType: ArrayType.getElementDynamicType())
  }
  if let OptionalType = T.self as? AnyOptional.Type {
    return DynamicOptionalType(wrappedType: OptionalType.getWrappedDynamicType())
  }
  if let ConvertibleType = T.self as? ConvertibleArgument.Type {
    return DynamicConvertibleType(innerType: ConvertibleType)
  }
  if let EnumType = T.self as? EnumArgument.Type {
    return DynamicEnumType(innerType: EnumType)
  }
  if let SharedObjectType = T.self as? SharedObject.Type {
    return DynamicSharedObjectType(innerType: SharedObjectType)
  }
  return DynamicRawType(innerType: T.self)
}

/**
 Handy prefix operator that makes the dynamic type from the static type.
 */
prefix operator ~
public prefix func ~ <T>(type: T.Type) -> AnyDynamicType {
  return DynamicType(type)
}
